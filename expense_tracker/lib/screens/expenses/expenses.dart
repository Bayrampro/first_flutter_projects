import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../ui/ui.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _expensesList = [
    Expense(
      title: 'Колбаса',
      amount: 36.5,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Ноутбук',
      amount: 14000.0,
      date: DateTime.now(),
      category: Category.work,
    ),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _expensesList.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _expensesList.indexOf(expense);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text('${expense.title} был удален'),
        showCloseIcon: true,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Отмена',
          onPressed: () {
            setState(() {
              _expensesList.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
    setState(() {
      _expensesList.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Трекер траты денег'),
            actions: [
              IconButton(
                onPressed: _showExpenseForm,
                icon: const Icon(Icons.add),
              )
            ],
          ),
          SliverToBoxAdapter(
            child: Chart(expenses: _expensesList),
          ),
          ExpensesList(
            expensesList: _expensesList,
            removeExpense: _removeExpense,
          ),
        ],
      ),
    );
  }

  void _showExpenseForm() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => ExpenseForm(
        addExpense: _addExpense,
      ),
    );
  }
}
