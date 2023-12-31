import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartnote/models/noteAndQuestion.dart';
import 'package:smartnote/backend/storage/cloud/cloud_database.dart';
import 'package:smartnote/backend/storage/local/sqlite_db_helper.dart';
import 'package:smartnote/theme.dart';
import 'package:smartnote/views/note/note_view.dart';
import 'dart:async';
import 'dart:io';
import 'package:smartnote/views/question/question_view.dart';
import 'package:smartnote/views/widgets/appbar.dart';

class Questions extends StatefulWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  late Future<List<DataNote>> all_data;

  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    all_data = fetchData();
    // read mock_notes.html from assets folder

    // all_data.then((list) {
    //   list.add(DataNote(
    //       id: 200,
    //       notes: 'assets/mock_notes.html',
    //       questions: 'assets/mock_questions.json',
    //       title: 'Microbiology',
    //       created_at: '2023-10-19 16:27:52'));
    // });
    // add additional mock data to the list
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
    }
    else {

    var dbHelper = SqliteDatabaseHelper();
    List<Map<String, dynamic>> rawList = await dbHelper.getPaths();

    return rawList.map((dataMap) => DataNote.fromMap(dataMap)).toList();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: SmartNoteAppBar(appBarTitle: "Curated Questions"),
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
                                    data.title.trim(),
                                    style:  themeFontFamily.copyWith(
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
                                            builder: (context) => NoteView(
                                                  htmlFilePath: data.notes,
                                                  topicTitle: data.title,
                                                )));
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

// void main() async {
//   var dbHelper = SqliteDatabaseHelper();
//   var paths = await dbHelper.getPaths();
//   paths.forEach((path) {});
// }
