import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

import 'package:smartnote/theme.dart';

class QuestionView extends StatefulWidget {
  final String jsonFilePath;
  const QuestionView({required this.jsonFilePath, Key? key}) : super(key: key);

  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  List<Question> questions = [];

  @override
  void initState() {
    super.initState();
    loadQuestionsFromFile().then((_) {
      setState(() {}); // Rebuild the widget after loading the data.
    });
  }

  Future<void> loadQuestionsFromFile() async {
    final file = File(widget.jsonFilePath);
    String jsonString = await file.readAsString();
    List jsonData = jsonDecode(jsonString);
    questions = jsonData
        .map((questionData) => Question(
            question: questionData['question'], answer: questionData['answer']))
        .toList();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Questions'),
          backgroundColor: bgColor,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.login),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: questions.length,
          itemBuilder: (context, index) {
            final question = questions[index];
            return Card(
              child: ExpansionTile(
                title: Text("$index: ${question.question}"),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // aligns text to the left
                      children: [
                        Text("Answer:"),
                        SizedBox(height: 10.0),
                        Text(question
                            .answer), // Assuming 'question' is defined in this scope.
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
}

class Question {
  final String question;
  final String answer;

  const Question({
    required this.question,
    required this.answer,
  });
}
