import 'package:flutter/material.dart';
import 'package:quiz_app/features/HomeScreen/Home.dart';
import 'package:quiz_app/ui/ui.dart';


void main(){
  runApp(const QuizApp());
}


class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {

  var _questionIndex = 0;
  var _totalScore = 0;
  final _questions = [
    {
      'question': 'Кто выиграл ЛЧ в 2012?',
      'answer': [
        {'text': 'Бавария', 'score': 0},
        {'text': 'Челси', 'score': 20},
        {'text': 'Барселона', 'score': 0},
        {'text': 'Реал Мадрид', 'score': 0}
      ],
    },
    {
      'question': 'Самый молодой автор гола в истории Евро?',
      'answer': [
        {'text': 'Роналду', 'score': 0},
        {'text': 'Бэкхем', 'score': 0},
        {'text': 'Ямаль', 'score': 20},
        {'text': 'Азар', 'score': 0}
      ],
    },
    {
      'question': 'Сколько чемпионств в АПЛ у Манчестер Сити?',
      'answer': [
        {'text': '10', 'score': 20},
        {'text': '3', 'score': 0},
        {'text': '21', 'score': 0},
        {'text': '8', 'score': 0}
      ],
    },
    {
      'question': 'Что такое требл?',
      'answer': [
        {'text': 'Это чемпионат который проводился до 2000х', 'score': 0},
        {'text': 'Это когда команда берет внутренний чемпионат, кубок страны и главный континентальный кубок в одном сезоне', 'score': 20},
        {'text': 'Это когда команда берет внутренний чемпионат, чемпионат мира и любой внутренний кубок в одном сезоне', 'score': 0},
        {'text': 'Это когда игрок берет золотой мяч, the best от ФИФА и чемпионат мира  в одном сезоне', 'score': 0}
      ],
    },
    {
      'question': 'Был ли требл у Реал Мадрида?',
      'answer': [
        {'text': 'Да', 'score': 0},
        {'text': 'Нет', 'score': 20},
      ],
    },
  ];

  void _answerQuestion(int score){
    _totalScore += score;
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Quiz App'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Column(
          children: [
            if(_questionIndex < _questions.length)
              Question(
                  question: _questions[_questionIndex]['question'].toString(),
              ),
            if(_questionIndex < _questions.length)
              ...(_questions[_questionIndex]['answer'] as List<Map<String, dynamic>>)
               .map(
                  (e){
                    return Answer(answer: e['text'], onPressed: () => _answerQuestion(e['score']),);
                  }
               )
            else
              Result(totalScore: _totalScore),
          ],
        ),
      ),
    );
  }
}
