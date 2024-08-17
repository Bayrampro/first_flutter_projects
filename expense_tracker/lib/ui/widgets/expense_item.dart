import 'package:flutter/material.dart';

import '../../models/category/category_icons.dart';
import '../../models/models.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({
    super.key,
    required this.expense,
  });

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                Text('TMT ${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(
                      width: 5,
                    ),
                    Text('${expense.formattedDate}'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
