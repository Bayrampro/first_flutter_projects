import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  useMaterial3: true,
  textTheme: TextTheme(
    titleLarge: GoogleFonts.lato(
      color: Colors.white,
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: const TextStyle(
      color: Colors.white,
      fontSize: 17.0,
    ),
  ),
);
