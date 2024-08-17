import 'package:flutter/material.dart';

import '../../../models/models.dart';
import 'widgets/widgets.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({
    super.key,
    required this.addExpense,
  });

  final void Function(Expense expense) addExpense;

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  var _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final datePickerResult = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
      initialDate: now,
    );
    setState(() {
      _selectedDate = datePickerResult;
    });
  }

  void _onSelectedCategory(value) {
    if (value == null) {
      return;
    }
    setState(() {
      _selectedCategory = value;
    });
  }

  void _onSubmitExpense() {
    final amount = double.tryParse(_amountController.text);
    final isInvalidAmount = amount == null || amount <= 0;
    if (_titleController.text.trim().isEmpty ||
        isInvalidAmount ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (context) => BotomSheetError(
          close: close,
        ),
      );
      return;
    }
    final newExpense = Expense(
      title: _titleController.text,
      amount: amount,
      date: _selectedDate!,
      category: _selectedCategory,
    );
    widget.addExpense(newExpense);
    close(context);
  }

  void close(BuildContext context) => Navigator.of(context).pop();

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SizedBox(
      width: double.infinity,
      height: mediaQuery.size.height * 0.95,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            TextField(
              maxLength: 50,
              autofocus: true,
              controller: _titleController,
              decoration: const InputDecoration(
                label: Text('Заголовок'),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            AmountAndDateInputs(
              amountController: _amountController,
              presentDatePicker: _presentDatePicker,
              selectedDate: _selectedDate,
            ),
            const SizedBox(
              height: 18.0,
            ),
            DropDownAndActions(
              onSelectedCategory: _onSelectedCategory,
              onSubmitExpense: _onSubmitExpense,
              close: close,
              selectedCategory: _selectedCategory,
            ),
          ],
        ),
      ),
    );
  }
}
