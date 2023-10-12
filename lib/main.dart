import 'package:flutter/material.dart';
import 'views/screens/bottom_navigator.dart';
import 'views/screens/note/note.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        // '/': (context) => Home(),
        '/note': (context) => NoteWebViewContainer(),
      },
      // remove debug banner
      debugShowCheckedModeBanner: false,

      title: 'Recorder',
      theme: ThemeData(),
      home: BottomNavBarNavigator(),
    );
  }
}
