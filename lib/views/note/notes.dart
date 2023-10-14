import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:smartnote/services/storage/sqlite_db_helper.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'note.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  // List<Note> notes = [
  //   Note(title: "Microbiology", date: DateTime.now()),
  //   Note(title: "Science", date: DateTime.now()),
  //   Note(title: "Algebra linear", date: DateTime.now()),
  //   Note(title: "Calculus", date: DateTime.now()),
  //   Note(title: "World Economic", date: DateTime.now()),
  //   Note(title: "Arts Story", date: DateTime.now()),
  // ];
  late Future<List<DataNote>> all_data;
  @override
  void initState() {
    super.initState();
    all_data = fetchData();
  }

  Future<List<DataNote>> fetchData() async {
    var dbHelper = SqliteDatabaseHelper();
    List<Map<String, dynamic>> rawList = await dbHelper.getPaths();

    return rawList.map((dataMap) => DataNote.fromMap(dataMap)).toList();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Notes',
          ),
          backgroundColor: Color.fromARGB(221, 246, 244, 244),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            CircleAvatar(
              // Replace with your image or use a placeholder

              radius: 20,
            ),
            SizedBox(width: 15),
          ],
        ),
        body: FutureBuilder<List<DataNote>>(
          future: all_data,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No data found.'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final data = snapshot.data![index];
                  return InkWell(
                    onTap: () {
                      // Push to a new screen or redirect as needed
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NoteWebViewContainer(
                                  htmlFilePath: data.notes)));
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                            child: ListTile(
                              title: Text(data.title),
                              subtitle: Text(data.created_at.toString()),
                              trailing: Icon(Icons.question_answer_outlined),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      );
}

class Note {
  final String title;
  final DateTime date;

  const Note({
    required this.title,
    required this.date,
  });
}

class DetailScreen extends StatelessWidget {
  final Note note;

  const DetailScreen({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
      ),
      body: Center(
        child: Text('Details for ${note.title}'),
      ),
    );
  }
}

// class DataNote {
//   final int id;
//   final String notes;
//   final String questions;
//   final String title;
//   final String created_at;

//   const DataNote({
//     required this.id,
//     required this.notes,
//     required this.questions,
//     required this.title,
//     required this.created_at,
//   });
// }

class DataNote {
  final int
      id; // I noticed it was a String in your example, make sure this is the right type
  final String notes;
  final String questions;
  final String title;
  final String created_at;

  DataNote({
    required this.id,
    required this.notes,
    required this.questions,
    required this.title,
    required this.created_at,
  });

  factory DataNote.fromMap(Map<String, dynamic> map) {
    return DataNote(
      id: map['id'],
      notes: map['notes'],
      questions: map['questions'],
      title: map['title'],
      created_at: map['created_at'],
    );
  }
}
