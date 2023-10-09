import 'package:flutter/material.dart';
import 'package:audiorecorder/audiorecorder.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Recorder extends StatefulWidget {
  @override
  _RecorderState createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  bool isRecording = false;
  Recording _recording;
  String _filePath;

  _startRecording() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath =
          appDocDir.path + '/' + DateTime.now().toString() + '.aac';
      print('File path: $filePath');
      _recording = await AudioRecorder.start(
          path: filePath, audioOutputFormat: AudioOutputFormat.AAC);
      setState(() {
        _filePath = filePath;
        isRecording = true;
      });
    } catch (e) {
      print(e);
    }
  }

  _stopRecording() async {
    try {
      Recording recording = await AudioRecorder.stop();
      setState(() {
        _recording = recording;
        isRecording = false;
      });
      print('Recording saved at: ${_recording.path}');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voice Recorder Widget'),
      ),
      body: Center(
        child: Text(
          isRecording ? 'Recording...' : 'Press the button to start recording',
          style: TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          isRecording ? _stopRecording() : _startRecording();
        },
        child: Icon(isRecording ? Icons.stop : Icons.mic),
      ),
    );
  }
}
