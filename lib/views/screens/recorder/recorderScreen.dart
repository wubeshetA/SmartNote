import 'package:flutter/material.dart';
import 'package:smartnote/views/screens/recorder/record.dart';
import 'dart:async';

class Recorder extends StatefulWidget {
  const Recorder({Key? key}) : super(key: key);

  @override
  State<Recorder> createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  final recorder = SoundRecorder();

 late Timer _timer;
  @override
  void initState() {
    super.initState();
    recorder.init();
  }

  @override
  void dispose() {
    recorder.dispose();
    super.dispose();
  }

  // =============Timer================

  Duration _duration = Duration();

  void _startTimer() {
    _duration = Duration();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _duration += Duration(seconds: 1);
      });
    });
  }

  void _pauseTimer() {
    setState(() {
      _timer.cancel();
    });
    
  }
  void resumeOrPauseTimer() {
    if (_timer.isActive) {
      _pauseTimer();
    } else {
      // imcrement the timer
      _startTimer();

    }
  }



  void _resetTimer() {
    
    setState(() {
      _duration = Duration();
    });
    _pauseTimer();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${_duration.inMinutes}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              buildPlayers(),
            ],
          ),
        ),
      );

  Widget buildPlayers() {
    final isRecording = recorder.isRecording;

    final icon = isRecording ? Icons.stop : Icons.mic;
    final text = isRecording ? 'Stop' : 'Start';
    final primary = isRecording ? Colors.red : Colors.white;
    final onPrimary = isRecording ? Colors.white : Colors.black;

    return Container(
      // set the wideth of the container to the width of the screen
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          // add a button to pause recording and resume recording

          IgnorePointer(
            ignoring: !recorder.isRecording,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(175, 50),
               
              ),
              onPressed: () async {
                await recorder.togglePauseAndResume();
               
                  if (recorder.isRecording) {
                    _pauseTimer();
                  } else {
                    _startTimer();
                  }
              
              },
              icon: Icon(recorder.isRecording? Icons.pause : Icons.play_arrow),
              label: Text(''),
            ),
          ),

          SizedBox(width: 5),
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(175, 50),
                primary: primary,
                onPrimary: onPrimary,
              ),
              onPressed: () async {
                await recorder.toggleStartAndStop();
                print('isRecording: ${recorder.isRecording}');
                setState(() {
                  if (recorder.isRecording) {
                    _startTimer();
                  }
                });
              },
              icon: Icon(icon),
              label: Text(text)),
          SizedBox(width: 5),

          // Add a button to reset the timer
          IgnorePointer(
            ignoring: !recorder.isRecording,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(175, 50),
              
              ),
              onPressed: () async {
                await recorder.toggleStartAndStop();
                print('isRecording: ${recorder.isRecording}');
                setState(() {
                  if (recorder.isRecording) {
                    _resetTimer();
                  }
                });
              },
              icon: Icon(Icons.replay),
              label: Text(''),
            ),
          ),
        ],
      ),
    );
  }
}
