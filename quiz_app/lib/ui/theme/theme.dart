import 'package:flutter/material.dart';

final theme = ThemeData(
  primaryColor: Colors.green,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.green, primary: Colors.green,),
  scaffoldBackgroundColor: Colors.lightGreenAccent,
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      fontWeight: FontWeight.bold
    )
  )
);