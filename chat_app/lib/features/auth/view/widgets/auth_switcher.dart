import 'package:flutter/material.dart';

class AuthSwitcher extends StatelessWidget {
  const AuthSwitcher({
    super.key,
    required this.constraints,
    required this.label,
    required this.onPressed,
    required this.border,
  });

  final BoxConstraints constraints;
  final String label;
  final VoidCallback onPressed;
  final BoxBorder border;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: border,
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          fixedSize: Size(constraints.maxWidth * 0.5, 55),
        ),
        child: Text(
          label,
          style: theme.textTheme.titleLarge,
        ),
      ),
    );
  }
}
