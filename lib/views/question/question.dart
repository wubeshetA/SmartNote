import 'package:flutter/material.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({Key? key}) : super(key: key);

  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  List<Question> questions = [
    const Question(
        question: "What is the definition of a microorganism?",
        answer: "Small living organisms not visible to the naked eye"),
    const Question(
        question: "What are the types of microorganisms?",
        answer: "Bacteria, Viruses, Fungi"),
    const Question(
        question: "What are the characteristics of bacteria?",
        answer:
            "Single-celled prokaryotes, Found virtually everywhere on Earth, Some species can be harmful (pathogenic bacteria)"),
    const Question(
        question: "What are the characteristics of viruses?",
        answer:
            "Obligate intracellular parasites, Consist of genetic material enclosed in a protein coat, Cannot reproduce without a host"),
    const Question(
        question: "What are the characteristics of fungi?",
        answer:
            "Eukaryotic organisms, Obtain nutrients by absorbing them from their environment, Include yeasts, molds, and mushrooms"),
  ];

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
