import 'package:flutter/material.dart';
import 'package:flutter_quiz/data/questions.dart';
import 'package:flutter_quiz/screens/results_screen/results_screen.dart';
import 'package:flutter_quiz/screens/screens.dart';
import 'package:flutter_quiz/ui/ui.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  var activeScreen = 'start-screen';

  void switchScreen() {
    activeScreen = 'questions-screen';
    setState(() {});
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);
    setState(() {
      if (selectedAnswers.length == questions.length) {
        activeScreen = 'results-screen';
      }
    });
  }

  void restartQuiz() {
    selectedAnswers = [];
    setState(() {
      activeScreen = 'start-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidget = activeScreen == 'start-screen'
        ? StartScreen(switchScreen: switchScreen)
        : QuestionsScreen(
            chooseAnswer: chooseAnswer,
          );
    if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        selectedAnswers: selectedAnswers,
        onRestart: restartQuiz,
      );
    }
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 50, 2, 134),
                Color.fromARGB(255, 36, 2, 94),
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
