import 'package:flutter/material.dart';
import 'package:smartnote/services/localStorage.dart';
import 'package:smartnote/services/storage/sqlite_db_helper.dart';
import 'package:smartnote/theme.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  late Future<List<String>> pathsFuture;

  @override
  void initState() {
    super.initState();
    pathsFuture = readPaths();
  }

  Future<List<String>> readPaths() async {
    var sqliteDbHelper = SqliteDatabaseHelper();

    var paths = await sqliteDbHelper.getPaths();
    List<String> titles = [];

    for (var path in paths) {
      // call the read file function for each path
      print(
          "============printing note&Q with id: ${path['id']}====================");
      print(await readFileContent(path['notes'].toString()));
      print("---------------");
      print(await readFileContent(path['questions'].toString()));
      titles.add(path['title'].toString());
    }

    return titles; // return the list of titles
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Recorder'),
        title: Text('Record'),
        centerTitle: true,
        backgroundColor: bgColor,
        elevation: 0.0,
        // add a sign in button on the right side
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.login),
          ),
        ],
      ),


      body: FutureBuilder<List<String>>(
        future: pathsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child:
                    CircularProgressIndicator()); // Show a loader until Future is completed
          } else {
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            else if (!snapshot.hasData)
              return Center(child: Text('No Titles Found'));
            else // When Future is complete and no errors occurred, return the created posts
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index]),
                    onTap: () {
                      Navigator.of(context).pushNamed('/note');
                    },
                  );
                },
              );
          }
        },
      ),
    );
  }
}
