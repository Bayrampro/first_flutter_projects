import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({
    super.key,
    required this.switchScreen,
  });

  final VoidCallback switchScreen;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'images/quiz-logo.png',
            width: 300,
            color: const Color.fromARGB(150, 255, 255, 255),
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            'Изучай Flutter весело!',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(
            height: 25,
          ),
          OutlinedButton.icon(
            onPressed: switchScreen,
            icon: Icon(
              Icons.arrow_forward,
              color: theme.canvasColor,
            ),
            label: Text(
              'Начни тест',
              style: theme.textTheme.titleSmall,
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: theme.canvasColor,
                width: 2.0,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
