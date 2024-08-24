import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget {
  const MealItemTrait({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(
          icon,
          color: theme.colorScheme.onPrimaryContainer,
          size: 17,
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          label,
          style: theme.textTheme.titleSmall!.copyWith(
            color: theme.colorScheme.onPrimaryContainer,
          ),
        )
      ],
    );
  }
}
