import 'package:flutter/material.dart';
import 'package:flutter_quiz/data/questions.dart';

import '../../ui/ui.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.selectedAnswers,
    required this.onRestart,
  });

  final List<String> selectedAnswers;
  final VoidCallback onRestart;

  List<Map<String, dynamic>> getSummary() {
    List<Map<String, dynamic>> summary = [];

    for (var i = 0; i < selectedAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'selected_answer': selectedAnswers[i],
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summary = getSummary();
    final numOfQuestions = questions.length;
    final numOfCorrectQuestions = summary
        .where((data) => data['selected_answer'] == data['correct_answer'])
        .length;
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Opacity(
              opacity: 0.6,
              child: Text(
                'Ты ответил правильно на $numOfCorrectQuestions вопросов из $numOfQuestions',
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ResultSummary(
            summary: summary,
          ),
          const SizedBox(
            height: 30,
          ),
          TextButton.icon(
            onPressed: onRestart,
            icon: Icon(
              Icons.refresh,
              color: theme.canvasColor,
            ),
            label: Text(
              'Начни тест занова',
              style: theme.textTheme.titleSmall,
            ),
          )
        ],
      ),
    );
  }
}
