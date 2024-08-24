import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/features/meals_screen/meals.dart';
import 'package:meals/models/models.dart';
import 'package:meals/providers/filters_provider.dart';
import '../../../data/data.dart';
import 'widgets/widgets.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({
    super.key,
  });

  void _selectCategory(
      BuildContext context, Category category, List<Meal> filteredMeals) {
    final lastMeals = filteredMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealsScreen(
          meals: lastMeals,
          title: category.title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredMeals = ref.watch(filteredMealsProvider);
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text('Выбери кухню'),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(21.0),
          sliver: SliverGrid.builder(
            itemCount: availableCategories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemBuilder: (BuildContext context, int index) {
              final category = availableCategories[index];
              return CategoryGridItem(
                category: category,
                onSelectedCategory: () => _selectCategory(
                  context,
                  category,
                  filteredMeals,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
