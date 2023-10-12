import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'recorderScreen.dart';
import 'dart:async';

final pathToSaveAudio = 'audio_example.aac';

class SoundRecorder {
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecorderInitialized = false;
  bool get isRecording => _audioRecorder!.isRecording;

  /// Initializes the audio recorder and requests microphone permission.
  Future init() async {
    _audioRecorder = FlutterSoundRecorder();

    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      print('could not get microphone permission');
      throw RecordingPermissionException('Microphone permission not granted');
    }

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
  Future _pause() async {
    if (!_isRecorderInitialized) return;

    await _audioRecorder!.pauseRecorder();
  }

  Future _resume() async {
    if (!_isRecorderInitialized) return;

    await _audioRecorder!.resumeRecorder();
  }

  /// Toggles between starting and stopping the audio recorder.
  Future<bool> toggleStartAndStop() async {
    if (_audioRecorder!.isStopped) {
      await _record();
    } else {
      await _stop();
    }
    return isRecording;
  }
  Future<bool> togglePauseAndResume() async {
    if (_audioRecorder!.isPaused) {
      await _resume();
    } else {
      await _pause();
    }
    return isRecording;
  }
}
