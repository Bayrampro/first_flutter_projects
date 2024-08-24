import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/features/category_screen/category.dart';
import 'package:meals/features/favorites_screen/favorites.dart';
import 'package:meals/features/filters_screen/filters.dart';
import 'package:meals/providers/favorite_meals_provider.dart';
import '../../ui/ui.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _currentIndex = 0;

  void _changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _drawerNavigation(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const CategoryScreen();
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    switch (_currentIndex) {
      case 0:
        activePage = const CategoryScreen();
        break;
      case 1:
        activePage = FavoritesScreen(
          meals: favoriteMeals,
          title: 'Избранные',
        );
        break;
    }
    return Scaffold(
      drawer: MainDrawer(
        drawerNavigation: _drawerNavigation,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _changePage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal_sharp),
            label: 'Категории',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Избранные',
          ),
        ],
      ),
    );
  }
}
