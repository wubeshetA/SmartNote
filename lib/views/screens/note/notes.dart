// Create a stateful widget that can just display helloworld
import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // create a button that will redirect to the webview widget
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/note'); 
        },
        child: Text('Note View'),
      )
    );
  }
}