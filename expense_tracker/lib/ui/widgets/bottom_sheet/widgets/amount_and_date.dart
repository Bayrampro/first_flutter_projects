import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class AmountAndDateInputs extends StatelessWidget {
  const AmountAndDateInputs({
    super.key,
    required TextEditingController amountController,
    required VoidCallback presentDatePicker,
    DateTime? selectedDate,
  })  : _amountController = amountController,
        _selectedDate = selectedDate,
        _presentDatePicker = presentDatePicker;

  final TextEditingController _amountController;
  final DateTime? _selectedDate;
  final VoidCallback _presentDatePicker;

  @override
  Widget build(BuildContext context) {
    final dateFormatter = GetIt.I.get<DateFormat>();
    return Row(
      children: [
        Expanded(
          child: TextField(
            keyboardType: TextInputType.number,
            controller: _amountController,
            decoration: const InputDecoration(
              prefixText: 'TMT ',
              label: Text('Цена'),
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                _selectedDate != null
                    ? dateFormatter.format(_selectedDate)
                    : 'Нет данных',
                style: const TextStyle(fontSize: 18),
              ),
              IconButton(
                onPressed: _presentDatePicker,
                icon: const Icon(
                  Icons.calendar_month,
                  size: 30,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
