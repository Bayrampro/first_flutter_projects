import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/app/meals_app.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MealsApp(),
    ),
  );
}
