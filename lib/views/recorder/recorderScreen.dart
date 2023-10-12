import 'package:flutter/material.dart';
import 'package:smartnote/views/recorder/record.dart';

class Recorder extends StatefulWidget {
  const Recorder({Key? key}) : super(key: key);

  @override
  State<Recorder> createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  final recorder = SoundRecorder();
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

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: buildStart(),
        ),
      );
  Widget buildStart() {
    final isRecording = recorder.isRecording;
    final icon = isRecording ? Icons.stop : Icons.mic;
    final text = isRecording ? 'Stop' : 'Start';
    final primary = isRecording ? Colors.red : Colors.white;
    final onPrimary = isRecording ? Colors.white : Colors.black;

    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(175, 50),
          primary: primary,
          onPrimary: onPrimary,
        ),
        onPressed: () async {
          await recorder.toggleRecording();
          print('isRecording: ${recorder.isRecording}');
          setState(() {});
        },
        icon: Icon(icon),
        label: Text(text));
  }
}
