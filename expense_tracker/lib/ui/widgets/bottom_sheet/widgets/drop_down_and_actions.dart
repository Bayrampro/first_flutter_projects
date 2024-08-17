import 'package:flutter/material.dart';

import '../../../../models/models.dart';

class DropDownAndActions extends StatelessWidget {
  const DropDownAndActions({
    super.key,
    required Category selectedCategory,
    required void Function(Category? category) onSelectedCategory,
    required this.close,
    required VoidCallback onSubmitExpense,
  })  : _selectedCategory = selectedCategory,
        _onSelectedCategory = onSelectedCategory,
        _onSubmitExpense = onSubmitExpense;

  final Category _selectedCategory;
  final void Function(Category? category) _onSelectedCategory;
  final void Function(BuildContext context) close;
  final VoidCallback _onSubmitExpense;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DropdownButton(
          value: _selectedCategory,
          items: Category.values
              .map(
                (category) => DropdownMenuItem(
                  value: category,
                  child: Text(category.name.toUpperCase()),
                ),
              )
              .toList(),
          onChanged: _onSelectedCategory,
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () => close(context),
              child: const Text('Отмена'),
            ),
            const SizedBox(
              width: 8.0,
            ),
            ElevatedButton(
              onPressed: _onSubmitExpense,
              child: const Text('Сохранить'),
            )
          ],
        ),
      ],
    );
  }
}
