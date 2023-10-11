import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:flutter_sound_lite/public/flutter_sound_player.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smartnote/services/transcribe.dart';
// import 'package:flutter_sound/public/flutter_sound_player.dart';

class Recorder extends StatefulWidget {
  // intialize constant constructor
  const Recorder({Key? key}) : super(key: key);
  @override
  _RecorderState createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecording = false;
  bool _isPaused = false;
  String? pathToRecorded;
  Duration _duration = Duration();
  Timer? _timer;

  String transcribedText = 'No trascription yet...';
  FlutterSoundPlayer? _player;

  Future initPlayer() async {
    _player = FlutterSoundPlayer();
    await _player!.openAudioSession();
  }

  Future playAudio() async {
    await _player!.startPlayer(fromURI: '$pathToRecorded');
  }

  Future stopAudio() async {
    await _player!.stopPlayer();
  }

  @override
  void initState() {
    super.initState();
    _audioRecorder = FlutterSoundRecorder();
    _initAudioRecorder();
  }

  Future<void> _initAudioRecorder() async {
    await _audioRecorder!.openAudioSession();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _duration += Duration(seconds: 1);
      });
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _duration = Duration();
    });
  }



  Future<void> _requestPermissions() async {
    var status = await Permission.microphone.status;
    if (status.isDenied) {
      // Request microphone permission
      Map<Permission, PermissionStatus> statuses = await [
        Permission.microphone,
        Permission.storage,
      ].request();
      print(statuses[Permission.microphone]);
    }
  }

  Future<void> _startRecording() async {
    await _requestPermissions();
    Directory tempDir = await getApplicationDocumentsDirectory();
    print(
        '=============$tempDir====================${tempDir.path}=============================================');
    pathToRecorded = '${tempDir.path}/smartnotes_audio.wav';

    await _audioRecorder!.startRecorder(
      toFile: pathToRecorded,
      // decode it to mp3
      // codec: Codec.mp3,
    );

    setState(() {
      _isRecording = true;
    });

    _startTimer();
  }

  Future<void> _pauseRecording() async {
    await _audioRecorder!.pauseRecorder();
    _pauseTimer();

    setState(() {
      _isPaused = true;
    });
  }

  Future<void> _resumeRecording() async {
    await _audioRecorder!.resumeRecorder();
    _startTimer();

    setState(() {
      _isPaused = false;
    });
  }

  Future<void> _stopRecording() async {
    await _audioRecorder!.stopRecorder();
    _resetTimer();

    setState(() {
      _isRecording = false;
      _isPaused = false;
    });
  }

  @override
  void dispose() {
    _audioRecorder!.closeAudioSession();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(transcribedText ?? 'No text found'),
          SizedBox(height: 20),
          Text(
            '${_duration.inMinutes}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _isRecording && !_isPaused
                    ? _pauseRecording
                    : _resumeRecording,
                child: Text(_isPaused ? 'Resume' : 'Pause'),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: !_isRecording ? _startRecording : null,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 30,
                  child: Icon(Icons.mic, color: Colors.white, size: 30),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _isRecording ? _stopRecording : null,
                child: Text('Stop'),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isRecording
                ? null
                : () {
                    // save the recorded audio

                    print('Audio saved at $pathToRecorded');
                  },
            child: Text('Save'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await initPlayer();
              await playAudio();
            },
            child: Text('Play'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await stopAudio();
            },
            child: Text('Stop'),
          ),
          ElevatedButton(
            onPressed: () {
              transcribeAudio(pathToRecorded!).then((value) {
                setState(() {
                  transcribedText = value;
                });
              });
            },
            child: Text('Generate Short Notes'),
          ),
        ],
      ),
    );
  }
}
