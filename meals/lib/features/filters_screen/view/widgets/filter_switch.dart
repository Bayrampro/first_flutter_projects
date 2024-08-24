import 'package:flutter/material.dart';

class FilterSwitch extends StatelessWidget {
  const FilterSwitch({
    super.key,
    required this.onChanged,
    required this.value,
    required this.title,
    required this.subtitle,
  });

  final void Function(bool value) onChanged;
  final bool value;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
      child: SwitchListTile.adaptive(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: theme.colorScheme.secondaryContainer,
        applyCupertinoTheme: true,
        title: Text(
          title,
          style: theme.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        subtitle: Text(subtitle),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
