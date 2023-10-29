import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartnote/models/noteAndQuestion.dart';
import 'package:smartnote/services/storage/cloud/cloud_database.dart';
import 'package:smartnote/services/storage/local/sqlite_db_helper.dart';
import 'package:smartnote/theme.dart';
import 'package:smartnote/views/question/question_view.dart';
import 'package:smartnote/views/widgets/appbar.dart';

import 'note_view.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  User? user = FirebaseAuth.instance.currentUser;
  // List<Note> notes = [
  //   Note(title: "Microbiology", date: DateTime.now()),
  //   Note(title: "Science", date: DateTime.now()),
  //   Note(title: "Algebra linear", date: DateTime.now()),
  //   Note(title: "Calculus", date: DateTime.now()),
  //   Note(title: "World Economic", date: DateTime.now()),
  //   Note(title: "Arts Story", date: DateTime.now()),
  // ]; htmlFilePath  htmlFilePathhtmlFilePathhtmlFilePathhtmlFhtmlFilePath

  late Future<List<DataNote>> all_data;
  @override
  void initState() {
    super.initState();
    all_data = fetchData();
  }

  Future<List<DataNote>> fetchData() async {
    if (user != null) {
      var supabaseDbHelper = SupabaseDatabaseHelper();
      List rawList = await supabaseDbHelper.getPaths();
      print("----------------------displaying raw list-----------------");
      print(rawList);
      print("--------------------------------------");
      return rawList.map((dataMap) => DataNote.fromMap(dataMap)).toList();
      // return await supabaseDbHelper.getPaths(user_uid)
      //  var supabaseDbHelper = SupabaseDatabaseHelper();
    } else {
      var sqliteDbHelper = SqliteDatabaseHelper();
      List<Map<String, dynamic>> rawList = await sqliteDbHelper.getPaths();

      return rawList.map((dataMap) => DataNote.fromMap(dataMap)).toList();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
  
        appBar: SmartNoteAppBar(appBarTitle: "Your Notes"),
        body: FutureBuilder<List<DataNote>>(

        
          future: all_data,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No saved notes found!'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final data = snapshot.data![index];
                  return InkWell(
                    child: Padding(
                      // Added Padding for better spacing
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                // Rounded corners for the Card
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation:
                                  1, // Shadow effect for a touch of depth
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                  // Added padding for better structure
                                  vertical: 5,
                                  horizontal: 15,
                                ),
                                title: GestureDetector(
                                  onTap: () {
                                    // Push to a new screen or redirect as needed
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => NoteView(
                                                  htmlFilePath: data.notes,
                                                  topicTitle: data.title,
                                                )));
                                  },
                                  child: Text(
                                    data.title,
                                    style: themeFontFamily.copyWith(
                                      fontSize: 18
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    data.created_at.toString(),
                                    style: themeFontFamily.copyWith(
                                        fontSize: 14,
                                        color: Colors.grey[600]
                                    )
                                  ),
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    // Push to a new screen or redirect as needed
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => QuestionView(
                                                jsonFilePath: data.questions,
                                                topicTitle: data.title)));
                                  },
                                  child: Icon(
                                    Icons.question_answer_rounded,
                                    color:
                                        themeColor, // Added color for better visibility
                                    size: 24, // Increased icon size
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
