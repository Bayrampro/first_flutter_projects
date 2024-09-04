import 'package:flutter/material.dart';

class ChoosingButton extends StatelessWidget {
  const ChoosingButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
          color: theme.canvasColor,
          iconSize: 35,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: theme.textTheme.titleMedium!.copyWith(
            color: theme.canvasColor,
          ),
        ),
      ],
    );
  }
}
