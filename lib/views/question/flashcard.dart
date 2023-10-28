import 'package:flutter/material.dart';
import 'package:smartnote/theme.dart';

// create a stateless widget call Flash card with constructor text
class QuestionFlashCard extends StatelessWidget {
  final String text;
  final index;
  const QuestionFlashCard({required this.text, required this.index, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        // clipBehavior: Clip.antiAlias,
        
        borderRadius: BorderRadius.circular(10),
      ),
      color: themeColor,
      elevation: 4,
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          '${index + 1}. ${this.text}',
          textAlign: TextAlign.center,
          style: themeFontFamily.copyWith(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
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
    return Container(
      // give this container a border
      
      child: Card(
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          // clipBehavior: Clip.antiAlias,
          
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.white,
        elevation: 4,
        child: Center(
          
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            this.text,
            textAlign: TextAlign.start,
            style: themeFontFamily.copyWith(
                      color: themeColor,
                      fontSize: 18, fontWeight: FontWeight.bold),
          ),
        )),
      ),
    );
  }
}
