import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';

//Класс который наследует основной StateNotifier.
//<List<Meal>> показывает что список с моделю Meal будет работать FavoriteMealsProvider
class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  //Пустой список это initial значение <List<Meal>>
  FavoriteMealsNotifier() : super([]);

  bool toggleFavoriteMeals(Meal meal) {
    final isExist = state.contains(meal);

    if (isExist) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    //Provider который будет использован в UI
    //Generics <FavoriteMealsProvider, List<Meal>> нужно понимать как:
    //StateNotifierProvider => FavoriteMealsProvider => List<Meal>
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
  (ref) => FavoriteMealsNotifier(),
);
