import 'package:flutter/material.dart';
import 'package:smartnote/services/storage/sqlite_db_helper.dart';
import 'package:smartnote/theme.dart';
import 'package:smartnote/views/note/note_view.dart';
import 'dart:async';
import 'dart:io';
import 'package:smartnote/views/question/question_view.dart';

class Questions extends StatefulWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
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
          title: const Text('Questions'),
          backgroundColor: themeColor,
          centerTitle: true,
          // leading: IconButton(
          //   //icon: Icon(Icons.arrow_back),
          //   onPressed: () => Navigator.pop(context),
          // ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.login),
            ),
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
              return Center(child: Text('No Saved Questions Found!'));
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
                                            builder: (context) => QuestionView(
                                                  jsonFilePath: data.questions,
                                                  topicTitle: data.title,
                                                )));
                                  },
                                  child: Text(
                                    data.title,
                                    style: TextStyle(
                                      // Added TextStyle for custom font styling
                                      fontSize: 18,

                                      // fontWeight: FontWeight.,
                                    ),
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    data.created_at.toString(),
                                    style: TextStyle(
                                      // Added TextStyle for custom font styling
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    // Push to a new screen or redirect as needed
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NoteView(
                                                    htmlFilePath: data.notes,
                                                    topicTitle: data.title,)));
                                  },
                                  child: Icon(
                                    Icons.note,
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

void main() async {
  var dbHelper = SqliteDatabaseHelper();
  var paths = await dbHelper.getPaths();
  paths.forEach((path) {});
}

class DataNote {
  final int id;
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
