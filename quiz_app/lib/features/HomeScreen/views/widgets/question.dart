import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  const Question({
    super.key,
    required this.question
  });

  final String question;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      child: Text(
          question,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineMedium,
      ),
    );
  }
}
