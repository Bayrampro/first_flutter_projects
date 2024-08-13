import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  const Answer({
    super.key,
    required this.answer,
    required this.onPressed
  });

  final String answer;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            onPressed: onPressed,
            child: Text(answer)
        ),
      ),
    );
  }
}
