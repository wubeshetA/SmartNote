// Create a stateful widget that can just display helloworld
import 'package:flutter/material.dart';

class Questions extends StatefulWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  List<Note> notes = [
    Note(title: "Microbiology", date: DateTime.now()),
    Note(title: "Science", date: DateTime.now()),
    Note(title: "Algebra linear", date: DateTime.now()),
    Note(title: "Calculus", date: DateTime.now()),
    Note(title: "World Economic", date: DateTime.now()),
    Note(title: "Arts Story", date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('ListView Navigation'),
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
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return Card(
              child: ExpansionTile(
                title: Text(note.title),
                subtitle: Text(note.date.toString()),
                trailing: Icon(Icons.question_answer_outlined),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Dummy text for ${note.title}.'),
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

// class Note {
//   final String title;
//   final DateTime date;

//   const Note({
//     required this.title,
//     required this.date,
//   });
// }
