import 'package:flutter/material.dart';
import 'package:flutter_quiz/data/questions.dart';
import 'package:flutter_quiz/ui/ui.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({
    super.key,
    required this.chooseAnswer,
  });

  final void Function(String answer) chooseAnswer;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentIndexOfQuestion = 0;

  void answerQuestion(String answer) {
    widget.chooseAnswer(answer);
    setState(() {
      currentIndexOfQuestion++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeQuestion = questions[currentIndexOfQuestion];
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(
            opacity: 0.6,
            child: Text(
              activeQuestion.text,
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ...activeQuestion.getShuffled().map(
                (e) => AnswerButton(
                  answer: e,
                  onTap: () => answerQuestion(e),
                ),
              )
        ],
      ),
    );
  }
}
