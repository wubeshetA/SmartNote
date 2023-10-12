import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'recorderScreen.dart';

final pathToSaveAudio = 'audio_example.aac';

class SoundRecorder {
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecorderInitialized = false;
  bool get isRecording => _audioRecorder!.isRecording ?? false;

  /// Initializes the audio recorder and requests microphone permission.
  Future init() async {
    _audioRecorder = FlutterSoundRecorder();

    print('trying to get permission');
    final status = await Permission.microphone.request();
    print("reached here");
    // if (status != PermissionStatus.granted) {
    //   print('could not get microphone permission');
    //   throw RecordingPermissionException('Microphone permission not granted');
    // }
    print("passed the if statement");

    await _audioRecorder!.openAudioSession();
    _isRecorderInitialized = true;
  }

  /// Closes the audio session and disposes the audio recorder.
  Future dispose() async {
    if (!_isRecorderInitialized) return;
    _audioRecorder!.closeAudioSession();
    _audioRecorder = null;
    _isRecorderInitialized = false;
  }

  /// Starts recording audio to a file.
  Future _record() async {
    if (!_isRecorderInitialized) return;
    await _audioRecorder!.startRecorder(
      toFile: pathToSaveAudio,
    );
  }

  /// Stops the audio recorder.
  Future _stop() async {
    if (!_isRecorderInitialized) return;

    await _audioRecorder!.stopRecorder();
  }

  /// Toggles between starting and stopping the audio recorder.
  Future<bool> toggleRecording() async {
    if (_audioRecorder!.isStopped) {
      await _record();
    } else {
      await _stop();
    }
    return isRecording;
  }
}
