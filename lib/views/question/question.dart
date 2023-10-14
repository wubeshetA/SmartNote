import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

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
    loadQuestionsFromAsset().then((_) {
      setState(() {}); // Rebuild the widget after loading the data.
    });
  }

  Future<void> loadQuestionsFromAsset() async {
    String jsonString = await rootBundle.loadString(widget.jsonFilePath);
    List jsonData = jsonDecode(jsonString);
    print(jsonData);
    questions = jsonData
        .map((questionData) => Question(
            question: questionData['question'], answer: questionData['answer']))
        .toList();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Questions'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            const CircleAvatar(
              // Replace with your image or use a placeholder
              radius: 20,
            ),
            const SizedBox(width: 15),
          ],
        ),
        body: ListView.builder(
          itemCount: questions.length,
          itemBuilder: (context, index) {
            final question = questions[index];
            return Card(
              child: ExpansionTile(
                title: Text("$index: ${question.question}"),
                trailing: const Icon(Icons.question_answer_outlined),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(question.answer),
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
