import 'dart:io';
import 'package:flutter/services.dart';
import 'package:google_speech/google_speech.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:process_run/cmd_run.dart';

Future<String> transcribeAudio(String fileName) async {
  // Assume this function splits the large audio file into smaller segments
  // and returns a list of file paths for these segments
  List<String> segmentFiles = await splitAudioFile(fileName);

  final serviceAccount = ServiceAccount.fromString(
      '${(await rootBundle.loadString('assets/speech_to_text.json'))}');
  final speechToText = SpeechToText.viaServiceAccount(serviceAccount);

  StringBuffer fullTranscription = StringBuffer();

  for (String segmentFile in segmentFiles) {
    final audio = File(segmentFile).readAsBytesSync().toList();
    final config = RecognitionConfig(
        encoding: AudioEncoding.LINEAR16,
        model: RecognitionModel.basic,
        enableAutomaticPunctuation: true,
        sampleRateHertz: 16000,
        languageCode: 'en-US');

    final response = await speechToText.recognize(config, audio).onError(
        (error, stackTrace) =>
            throw Exception('Error while transcribing audio segment'));

    final segmentTranscription = response.results
        .map((result) => result.alternatives.first.transcript)
        .join('\n');

    fullTranscription.write(segmentTranscription);
  }

  return fullTranscription.toString();
}

Future<List<String>> splitAudioFile(String filePath) async {
  final FlutterFFmpeg _ffmpeg = FlutterFFmpeg();

  List<String> splitFiles = [];
  int duration = await getAudioDuration(filePath);
  int segmentLength = 60; // seconds
  int numberOfSegments = (duration / segmentLength).ceil();

  for (int i = 0; i < numberOfSegments; i++) {
    String segmentPath =
        "path/to/segment_$i.mp3"; // Set the correct path for segments
    await _ffmpeg.execute(
        "-i $filePath -ss ${i * segmentLength} -t $segmentLength -c copy $segmentPath");
    splitFiles.add(segmentPath);
  }

  return splitFiles;
}

// Future<int> getAudioDuration(String filePath) async {
//   final FlutterFFmpeg _ffmpeg = FlutterFFmpeg();

//   // Command to get the duration of the audio file
//   final String command =
//       "-i $filePath -show_entries format=duration -v quiet -of csv=\"p=0\"";
//   try {
//     final result = await _ffmpeg.executeWithArguments(command.split(' '));
//     if (result != 0) {
//       throw 'FFmpeg failed with exit code $result';
//     }

//     // Get the output from FFmpeg, which contains the duration
//     final String output = await _ffmpeg.getOutput();
//     double durationInSeconds = double.parse(output.trim());
//     return durationInSeconds.round();
//   } catch (e) {
//     print("Error getting audio duration: $e");
//     return 0;
//   }
// }

Future<int> getAudioDuration(String filePath) async {
  try {
    // FFmpeg command to get the duration
    var cmd =
        'ffmpeg -i "$filePath" -show_entries format=duration -v quiet -of csv="p=0"';

    // Run the command and capture the output
    var result = await runExecutableArguments('ffmpeg', [
      '-i',
      filePath,
      '-show_entries',
      'format=duration',
      '-v',
      'quiet',
      '-of',
      'csv=p=0'
    ]);

    if (result.exitCode != 0) {
      throw 'FFmpeg failed with exit code ${result.exitCode}';
    }

    // Parse the output to get the duration
    double durationInSeconds = double.parse(result.stdout.trim());
    return durationInSeconds.round();
  } catch (e) {
    print("Error getting audio duration: $e");
    return 0;
  }
}
