import 'package:flutter/material.dart';

import '../ui.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem({
    super.key,
    required this.e,
  });

  final Map<String, dynamic> e;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isCorrectAnswer = e['selected_answer'] == e['correct_answer'];
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          QuestionIdentifier(
            e: e,
            isCorrectAnswer: isCorrectAnswer,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${e['question']}',
                  style: theme.textTheme.titleLarge?.copyWith(fontSize: 16),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${e['correct_answer']}',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 202, 171, 252),
                  ),
                ),
                Text(
                  '${e['selected_answer']}',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 181, 254, 246),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
