import 'package:flutter/material.dart';
import '../../../models/models.dart';
import '../../../ui/ui.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({
    super.key,
    required this.meals,
    required this.title,
  });

  final List<Meal> meals;
  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
    );
  }
}
