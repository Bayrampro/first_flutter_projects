import 'package:flutter/material.dart';
import 'package:shopping_list/screens/groceries_list.dart';
import 'ui/ui.dart';

void main() {
  runApp(const ShoppingListApp());
}

class ShoppingListApp extends StatelessWidget {
  const ShoppingListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Groceries',
      theme: theme,
      home: const GroceriesList(),
    );
  }
}
