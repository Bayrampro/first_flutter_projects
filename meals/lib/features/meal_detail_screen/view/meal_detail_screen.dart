import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorite_meals_provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../models/models.dart';
import 'widgets/widgets.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  void _onToggleFavoriteMeals(WidgetRef ref, Meal meal, BuildContext context) {
    final wasAdded =
        ref.read(favoriteMealsProvider.notifier).toggleFavoriteMeals(meal);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        showCloseIcon: true,
        content: Text(wasAdded
            ? 'Блюдо успешно добавлено!'
            : 'Блюдо больше не избранное'),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(favoriteMealsProvider).contains(meal);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(meal.title),
            actions: [
              IconButton(
                onPressed: () => _onToggleFavoriteMeals(ref, meal, context),
                icon: Icon(
                  isFavorite ? Icons.star : Icons.star_border,
                ),
              )
            ],
          ),
          SliverToBoxAdapter(
            child: Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                width: double.infinity,
                height: 350,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: DetailData(
              meal: meal,
              label: 'Ингредиенты',
              data: meal.ingredients,
              padding: 7.0,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          SliverToBoxAdapter(
            child: DetailData(
              meal: meal,
              label: 'Шаги',
              data: meal.steps,
              padding: 10.0,
            ),
          ),
        ],
      ),
    );
  }
}
