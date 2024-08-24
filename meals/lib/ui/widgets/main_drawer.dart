import 'package:flutter/material.dart';

import '../ui.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
    required this.drawerNavigation,
  });

  final void Function(String identifier) drawerNavigation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                theme.colorScheme.primaryContainer,
                theme.colorScheme.primaryContainer.withOpacity(0.8),
              ]),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.fastfood,
                  size: 45,
                  color: theme.colorScheme.onSurface,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Начни готовить!',
                  style: theme.textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          DrawerItem(
            label: 'Блюда',
            icon: Icons.restaurant,
            onTap: () => drawerNavigation('meals'),
          ),
          DrawerItem(
            label: 'Фильтры',
            icon: Icons.settings,
            onTap: () => drawerNavigation('filters'),
          ),
        ],
      ),
    );
  }
}
