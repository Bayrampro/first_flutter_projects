import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  const Result({
    super.key,
    required this.totalScore
  });

  final int totalScore;

  Widget resultPhrase(context){
    final theme = Theme.of(context);
    if(totalScore <= 100 && totalScore >= 80){
      return Column(
        children: [
          const Icon(
              Icons.auto_awesome_outlined,
              color: Colors.deepPurple,
              size: 100,
          ),
          Text(
              'Да вы эксперт по футболу! Ваш балл $totalScore',
              style: theme.textTheme.titleLarge,
          )
        ],
      );
    }
    else if(totalScore <= 80 && totalScore >= 50){
      return Column(
        children: [
           Icon(
            Icons.sentiment_satisfied_alt,
            color: Colors.green[900]!,
            size: 40,
          ),
          Text(
            'Ух ты! Неплохие знание по лучшей игры с мячом! Ваш балл $totalScore',
            style: theme.textTheme.titleLarge,
          )
        ],
      );
    }
    else if(totalScore <= 50 && totalScore >= 30){
      return Column(
        children: [
          const Icon(
            Icons.sentiment_neutral_outlined,
            color: Colors.yellow,
            size: 40,
          ),
          Text(
            'Лучше чем ничего! Ваш балл $totalScore',
            style: theme.textTheme.titleLarge,
          )
        ],
      );
    }
    else{
      return Column(
        children: [
          const Icon(
            Icons.sentiment_dissatisfied_outlined,
            color: Colors.red,
            size: 40,
          ),
          Text(
            'Ничего страшного. Вы еще заберете свое! Ваш балл $totalScore',
            style: theme.textTheme.titleLarge,
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(45.0),
        child: resultPhrase(context),
      ),
    );
  }
}
