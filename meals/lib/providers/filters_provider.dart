import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';
import 'meals_provider.dart';

enum Filters {
  glutenValueKey,
  lactoseValueKey,
  vegeterianValueKey,
  veganValueKey,
}

class FiltersNotifier extends StateNotifier<Map<Filters, bool>> {
  FiltersNotifier()
      : super({
          Filters.glutenValueKey: false,
          Filters.lactoseValueKey: false,
          Filters.vegeterianValueKey: false,
          Filters.veganValueKey: false,
        });
  void setFilter(Filters filter, bool value) {
    state = {
      ...state,
      filter: value,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filters, bool>>(
  (ref) => FiltersNotifier(),
);

final filteredMealsProvider = Provider<List<Meal>>((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  return meals.where((e) {
    if (activeFilters[Filters.glutenValueKey]! && !e.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filters.lactoseValueKey]! && !e.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filters.vegeterianValueKey]! && !e.isVegetarian) {
      return false;
    }
    if (activeFilters[Filters.veganValueKey]! && !e.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
