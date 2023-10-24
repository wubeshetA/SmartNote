import 'package:flutter/material.dart';

// create a stateless widget call Flash card with constructor text
class QuestionFlashCard extends StatelessWidget {
  final String text;
  final index;
  const QuestionFlashCard({required this.text, required this.index, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          '${index + 1}. ${this.text}',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.black
              // fontWeight: FontWeight.bold
              ),
        ),
      )),
    );
  }
}

class AnswerFlashCard extends StatelessWidget {
  final String text;
  const AnswerFlashCard({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          this.text,
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 20, color: Colors.green
              // fontWeight: FontWeight.bold
              ),
        ),
      )),
    );
  }
}
