// Create a stateful widget that can just display helloworld
import 'package:flutter/material.dart';
import 'package:smartnote/views/screens/question/question.dart';

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
          title: const Text(
            'Questions',
          ),
          backgroundColor: Color.fromARGB(255, 246, 244, 244),
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
            return InkWell(
              onTap: () {
                // Push to a new screen or redirect as needed
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QuestionView()));
              },
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      child: ListTile(
                        title: Text(note.title),
                        subtitle: Text(note.date.toString()),
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

// class Note {
//   final String title;
//   final DateTime date;

//   const Note({
//     required this.title,
//     required this.date,
//   });
// }
