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
  List<Note> notes = [
    Note(title: "Microbiology", date: DateTime.now()),
    Note(title: "Science", date: DateTime.now()),
    Note(title: "Algebra linear", date: DateTime.now()),
    Note(title: "Calculus", date: DateTime.now()),
    Note(title: "World Economic", date: DateTime.now()),
    Note(title: "Arts Story", date: DateTime.now()),
  ];

  List<DataNote> all_data = [
    const DataNote(
        id: 1,
        notes: 'assets/trial.html', // html file
        questions: 'file_path_to_questions_for_this_note.json', // json file
        title: 'title of the shortnote',
        created_at: 'date time'),
    const DataNote(
        id: 2,
        notes: 'assets/trial.html', // html file
        questions: 'file_path_to_questions_for_this_note.json', // json file
        title: 'title of the shortnote',
        created_at: 'date time'),
  ];

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
        body: ListView.builder(
          itemCount: all_data.length,
          itemBuilder: (context, index) {
            final data = all_data[index];
            return InkWell(
              onTap: () {
                // Push to a new screen or redirect as needed
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NoteWebViewContainer(htmlFilePath: data.notes)));
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

class DataNote {
  final int id;
  final String notes;
  final String questions;
  final String title;
  final String created_at;

  const DataNote({
    required this.id,
    required this.notes,
    required this.questions,
    required this.title,
    required this.created_at,
  });
}
