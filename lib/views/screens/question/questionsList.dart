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
        ),
        body: ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Card(
                child: ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.date.toString()),
                  trailing: const Icon(Icons.question_answer_outlined),
                ),
              );
            }),
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
