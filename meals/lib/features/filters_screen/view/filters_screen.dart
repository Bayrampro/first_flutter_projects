import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';

import 'widgets/widgets.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({
    super.key,
  });

  void onChangedGluten(bool value, WidgetRef ref) {
    ref.read(filtersProvider.notifier).setFilter(Filters.glutenValueKey, value);
  }

  void onChangedLactose(bool value, WidgetRef ref) {
    ref
        .read(filtersProvider.notifier)
        .setFilter(Filters.lactoseValueKey, value);
  }

  void onChangedVegeterian(bool value, WidgetRef ref) {
    ref
        .read(filtersProvider.notifier)
        .setFilter(Filters.vegeterianValueKey, value);
  }

  void onChangedVegan(bool value, WidgetRef ref) {
    ref.read(filtersProvider.notifier).setFilter(Filters.veganValueKey, value);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Фильтры'),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                FilterSwitch(
                  title: 'Без глютена',
                  subtitle: 'Только без глютеновые блюда',
                  onChanged: (value) => onChangedGluten(value, ref),
                  value: activeFilters[Filters.glutenValueKey]!,
                ),
                FilterSwitch(
                  title: 'Без лактозы',
                  subtitle: 'Только блюда без лактозы',
                  onChanged: (value) => onChangedLactose(value, ref),
                  value: activeFilters[Filters.lactoseValueKey]!,
                ),
                FilterSwitch(
                  title: 'Вегетерянское',
                  subtitle: 'Блюда для вегетерянцов',
                  onChanged: (value) => onChangedVegeterian(value, ref),
                  value: activeFilters[Filters.vegeterianValueKey]!,
                ),
                FilterSwitch(
                  title: 'Веган',
                  subtitle: 'Блюда для веганов',
                  onChanged: (value) => onChangedVegan(value, ref),
                  value: activeFilters[Filters.veganValueKey]!,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
