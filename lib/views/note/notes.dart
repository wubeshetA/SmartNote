import 'package:flutter/material.dart';
import 'package:smartnote/services/localStorage.dart';
import 'package:smartnote/services/storage/sqlite_db_helper.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  late Future<void> pathsFuture;

  @override
  void initState() {
    super.initState();
    pathsFuture = readPaths();
  }

  Future<void> readPaths() async {
    var sqliteDbHelper = SqliteDatabaseHelper();

    var paths = await sqliteDbHelper.getPaths();
    print("====================paths====================");
    print(paths);
    print(
        "====================Iterating and reading files...====================");

    for (var path in paths) {
      // call the read file function for each path
      print(
          "============printing note&Q with id: ${path['id']}====================");
      print(await readFileContent(path['notes'].toString()));
      print("---------------");
      print(await readFileContent(path['questions'].toString()));
      print(path['title'].toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: pathsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child:
                  CircularProgressIndicator()); // Show a loader until Future is completed
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else // When Future is complete and no errors occurred, return the created posts
            return Container(
              // create a button that will redirect to the webview widget
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/note');
                },
                child: Text('Note View'),
              ),
            );
        }
      },
    );
  }
}
