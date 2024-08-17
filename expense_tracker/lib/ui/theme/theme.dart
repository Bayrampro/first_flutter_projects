import 'package:flutter/material.dart';

final kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 148, 97, 237),
);

final kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 52, 30, 91),
);

final darkThemeData = ThemeData.dark().copyWith(
  colorScheme: kDarkColorScheme,
  appBarTheme: AppBarTheme(
    backgroundColor: kDarkColorScheme.primaryContainer,
    foregroundColor: kDarkColorScheme.onPrimaryContainer,
  ),
  cardTheme: CardTheme(
    color: kDarkColorScheme.secondaryContainer,
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    elevation: 8.0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kDarkColorScheme.onPrimaryContainer,
      foregroundColor: kDarkColorScheme.primaryContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
    ),
  ),
);

final themeData = ThemeData().copyWith(
  colorScheme: kColorScheme,
  appBarTheme: AppBarTheme(
    backgroundColor: kColorScheme.onPrimaryContainer,
    foregroundColor: kColorScheme.primaryContainer,
  ),
  cardTheme: CardTheme(
    color: kColorScheme.secondaryContainer,
    shadowColor: kColorScheme.secondary,
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    elevation: 8.0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kColorScheme.onPrimaryContainer,
      foregroundColor: kColorScheme.primaryContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
    ),
  ),
  textTheme: const TextTheme().copyWith(
    titleLarge: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.bold,
      color: kColorScheme.onPrimaryContainer,
    ),
  ),
);
