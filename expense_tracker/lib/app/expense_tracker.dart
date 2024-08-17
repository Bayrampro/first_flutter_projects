import 'package:expense_tracker/screens/screens.dart';
import 'package:flutter/material.dart';

import '../ui/ui.dart';

class ExpenseTracker extends StatelessWidget {
  const ExpenseTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: darkThemeData,
      theme: themeData,
      home: const Expenses(),
    );
  }
}
