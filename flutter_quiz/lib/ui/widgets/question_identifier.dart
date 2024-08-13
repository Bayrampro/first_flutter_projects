import 'package:flutter/material.dart';

class QuestionIdentifier extends StatelessWidget {
  const QuestionIdentifier({
    super.key,
    required this.e,
    required this.isCorrectAnswer,
  });

  final Map<String, dynamic> e;
  final bool isCorrectAnswer;

  @override
  Widget build(BuildContext context) {
    final questionNumber = e['question_index'] + 1;
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: isCorrectAnswer
            ? const Color.fromARGB(255, 150, 198, 241)
            : const Color.fromARGB(255, 249, 133, 241),
      ),
      child: Text(
        '$questionNumber',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 22, 2, 56),
        ),
      ),
    );
  }
}
