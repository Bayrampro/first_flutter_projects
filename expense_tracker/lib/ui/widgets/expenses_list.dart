import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../models/models.dart';
import '../ui.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expensesList,
    required void Function(Expense expense) removeExpense,
  }) : _removeExpense = removeExpense;

  final List<Expense> expensesList;
  final void Function(Expense expense) _removeExpense;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    return expensesList.isEmpty
        ? SliverToBoxAdapter(
            child: SizedBox(
              height: mediaQuery.size.height,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text('У вас траты пока что нету. Добавь новый!')],
              ),
            ),
          )
        : SliverList.builder(
            itemCount: expensesList.length,
            itemBuilder: (context, index) {
              final expense = expensesList[index];
              return Dismissible(
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(8.0),
                  color: theme.colorScheme.error,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Icon(
                    Icons.delete,
                    color: theme.canvasColor,
                  ),
                ),
                key: ValueKey(expense),
                onDismissed: (diraction) => _removeExpense(expense),
                child: ExpenseItem(expense: expense),
              );
            },
          );
  }
}
