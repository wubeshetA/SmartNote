import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

import 'package:smartnote/theme.dart';
import 'package:flip_card/flip_card.dart';
import 'package:smartnote/views/question/flashcard.dart';

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
  int _currentCardIndex = 0;
  bool showDefaultView = true;

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

  Widget _defaultView() {
    return Container(
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
                horizontal: 8, vertical: 8), // Add some margin around the card
            child: ExpansionTile(
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              expandedAlignment: Alignment.topLeft,
              // change the text color on expansion
              textColor: Colors.black,
              iconColor: themeColor,
              collapsedIconColor: Colors.black,
              collapsedTextColor: Colors.black,
              tilePadding: EdgeInsets.all(16), // Add some padding to the title
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
    );
  }

  Widget _flashCardView() {
    return Center(child: LayoutBuilder(builder: (context, contraints) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            // give the width 80% of it's container
            width: contraints.maxWidth * 0.85,
            height: contraints.maxHeight * 0.45,
            child: FlipCard(
              front: QuestionFlashCard(
                  text: questions[_currentCardIndex].question,
                  index: _currentCardIndex),
              back: AnswerFlashCard(
                  text: questions[_currentCardIndex].answer,
                  ),
            ),
          ),
          SizedBox(height: 50),

          // create a previous and next buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton.icon(
                onPressed: () {
                  previousFlashCard();
                },
                label: Text(
                  'Previous',
                  style: TextStyle(color: themeColor, fontSize: 18),
                ),
                icon: Icon(Icons.chevron_left_rounded),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  nextFlashCard();
                },
                label: Text(
                  'Next',
                  // add text color
                  style: TextStyle(color: themeColor, fontSize: 18),
                ),
                icon: Icon(Icons.chevron_right_rounded),
                // add decoration
              ),
            ],
          ),
        ],
      );
    }));
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
            onPressed: () {
              setState(() {
                showDefaultView = !showDefaultView; // Step 2: Toggle the flag
              });
            },
            icon: showDefaultView
                ? Icon(Icons.view_agenda)
                : Icon(Icons.view_carousel),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.login),
          ),
        ],
      ),
      body: showDefaultView ? _defaultView() : _flashCardView());

  void nextFlashCard() {
    setState(() {
      _currentCardIndex = (_currentCardIndex + 1) % questions.length;
    });
  }

  void previousFlashCard() {
    setState(() {
      _currentCardIndex = (_currentCardIndex - 1) % questions.length;
    });
  }
}

class Question {
  final String question;
  final String answer;

  const Question({
    required this.question,
    required this.answer,
  });
}
