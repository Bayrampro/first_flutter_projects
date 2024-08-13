import 'package:flutter/material.dart';
import 'package:test_project/features/theme/PropertiesOfTheme/AppBarTheme.dart';
import 'package:test_project/features/theme/PropertiesOfTheme/TextStyle.dart';

final theme = ThemeData(
  primaryColor: Colors.black54,
  appBarTheme: AppBarThemeOfApp,
  scaffoldBackgroundColor: Colors.black54,
  textTheme: TextTheme(
    bodyMedium: BodyMedium,
    titleSmall: TitleSmall,
  ),
  dividerColor: Colors.white,
  useMaterial3: true,
);