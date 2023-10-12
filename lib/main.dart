import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:smartnote/services/localStorage.dart';
import 'package:smartnote/services/storage/sqlite_db_helper.dart';
import 'views/bottom_navigator.dart';
import 'views/note/note.dart';

void main() async {
  await dotenv.load(fileName: 'assets/.env');
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

// =============== playground for file reading

 

  runApp(MyApp());
}

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
