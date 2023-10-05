// Create a stateful widget that can just display helloworld
import 'package:flutter/material.dart';

class Recorder extends StatefulWidget {
  const Recorder({Key? key}) : super(key: key);

  @override
  _RecorderState createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Recorder page'),
    );
  }
}