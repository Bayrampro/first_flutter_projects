import 'package:flutter/material.dart';
import '../../../models/models.dart';
import '../../../ui/ui.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.meals,
    required this.title,
  });

  final List<Meal> meals;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(title),
          ),
          meals.isEmpty
              ? const EmptyMealsInfo()
              : SliverList.builder(
                  itemCount: meals.length,
                  itemBuilder: (context, index) => MealItem(
                    meal: meals[index],
                  ),
                )
        ],
      ),
    );
  }
}
