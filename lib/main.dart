import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:smartnote/services/storage/sqlite_db_helper.dart';
import 'views/bottom_navigator.dart';
import 'views/note/note_view.dart';

void main() async {
  await dotenv.load(fileName: 'assets/.env');
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

// =============== playground ===============
  SqliteDatabaseHelper db = SqliteDatabaseHelper();
  final all_data = await db.getPaths();

  // remove database
  // db.deleteAll();
  print("=============== ALL DATA IN DB ===================");
  print(all_data);
  print("=================PRINT ALL DATA IN DB ENDS HERE===================");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        // '/': (context) => Home(),
        '/note': (context) =>
            NoteView(htmlFilePath: 'path_to_your_html_file.html', topicTitle: 'Topic Title'),
      },
      // remove debug banner
      debugShowCheckedModeBanner: false,

      title: 'Recorder',
      theme: ThemeData(),
      home: BottomNavBarNavigator(),
    );
  }
}
