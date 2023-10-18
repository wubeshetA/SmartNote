import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

import 'package:smartnote/theme.dart';

class QuestionView extends StatefulWidget {
  final String jsonFilePath;
  final String topicTitle;
  const QuestionView(
      {required this.jsonFilePath, required this.topicTitle, Key? key})
      : super(key: key);

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
          elevation: 0.0,
          title: Text('${widget.topicTitle}'),
          backgroundColor: themeColor,
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
        body: Container(
          color: partialWhiteBgColor,
          child: ListView.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final question = questions[index];
              return Card(
                color: whiteBgColor,
                elevation: 0, // This will remove the shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10), // This will make the corners rounded
                ),
                margin: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8), // Add some margin around the card
                child: ExpansionTile(
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  expandedAlignment: Alignment.topLeft,
                  // change the text color on expansion
                  textColor: Colors.black,
                  iconColor: themeColor,
                  collapsedIconColor: Colors.black,
                  collapsedTextColor: Colors.black,
                  tilePadding:
                      EdgeInsets.all(16), // Add some padding to the title
                  title: Text("${index + 1}. ${question.question}"),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Aligns text to the left
                        children: [
                          Text("Answer:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight
                                      .bold)), // Made the "Answer:" text bold for better visual distinction
                          SizedBox(height: 15.0),
                          Text(question.answer,
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 18,
                                  fontWeight: FontWeight
                                      .bold)), // Assuming 'question' is defined in this scope
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
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
