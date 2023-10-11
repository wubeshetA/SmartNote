// Create a stateful widget that can just display helloworld
import 'package:flutter/material.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Upload page'),
    );
  }
}