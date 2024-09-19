import 'package:flutter/material.dart';

class ChoosingButton extends StatelessWidget {
  const ChoosingButton({
    super.key,
    required this.iconData,
    required this.label,
    required this.onPressed,
  });

  final IconData iconData;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(iconData, size: 35),
          color: theme.colorScheme.primary,
        ),
        Text(
          label,
          style: theme.textTheme.titleMedium!.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
