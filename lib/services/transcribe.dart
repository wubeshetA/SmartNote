import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:google_speech/google_speech.dart';

// Transcribe the audio file to text using Google Speech-to-Text
Future<String> transcribeAudio(String fileName) async {
  // Load audio

  // print("=============Inside the transcription=========$fileName===========");
  final audio = File(fileName).readAsBytesSync().toList();
  // print("=============Inside the transcription=========$audio===========");
  final config = RecognitionConfig(
      encoding: AudioEncoding.LINEAR16,
      model: RecognitionModel.basic,
      enableAutomaticPunctuation: true,
      sampleRateHertz: 16000,
      languageCode: 'en-US');

  final serviceAccount = ServiceAccount.fromString(
      '${(await rootBundle.loadString('assets/speech_to_text.json'))}');
  // Load service account credentials from assets

  // Create speech client
  final speechToText = SpeechToText.viaServiceAccount(serviceAccount);

  // Recognize speech
  final response = await speechToText.recognize(config, audio).onError(
      (error, stackTrace) => throw Exception('Error while transcibing audio'));

  // Return transcribed text
  final trascribedText = response.results
      .map((result) => result.alternatives.first.transcript)
      .join('\n');
  // print("===================Transcribed Text====================");
  print(trascribedText);
  
  return trascribedText;

}
