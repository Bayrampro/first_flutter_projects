import 'package:flutter/material.dart';
import 'package:meals/features/tabs_screen/tabs_screen.dart';

import '../ui/ui.dart';

class MealsApp extends StatelessWidget {
  const MealsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const TabsScreen(),
    );
  }
}
