import 'package:flutter/material.dart';

import 'widgets.dart';

class SwitchBar extends StatelessWidget {
  const SwitchBar({super.key, required this.onPressed, required this.isLogin});

  final VoidCallback onPressed;
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AuthSwitcher(
            constraints: constraints,
            onPressed: onPressed,
            label: 'Логин',
            border: Border(
              bottom: BorderSide(
                color: theme.primaryColor,
                width: isLogin ? 2.0 : 0,
              ),
            ),
          ),
          AuthSwitcher(
            constraints: constraints,
            onPressed: onPressed,
            label: 'Создать',
            border: Border(
              bottom: BorderSide(
                color: theme.primaryColor,
                width: !isLogin ? 2.0 : 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
