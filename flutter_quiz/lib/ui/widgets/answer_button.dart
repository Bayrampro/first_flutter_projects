import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    super.key,
    required this.answer,
    required this.onTap,
  });

  final String answer;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(
            mediaQuery.size.width * 0.7,
            40,
          ),
          maximumSize: const Size(
            600,
            40,
          ),
          backgroundColor: const Color.fromARGB(255, 26, 2, 68),
          foregroundColor: theme.canvasColor,
        ),
        child: Text(
          answer,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
