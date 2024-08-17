import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BotomSheetError extends StatelessWidget {
  const BotomSheetError({
    super.key,
    required this.close,
  });

  final void Function(BuildContext context) close;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: const Text('Не правильный ввод'),
        content: const Text(
          'Возможные причины: \n Пустой ввод \n Цена отрицательная \n Дату не выбрали',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => close(context),
            child: const Text('OK'),
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: const Text('Не правильный ввод'),
        content: const Text(
          'Возможные причины: \n Пустой ввод \n Цена отрицательная \n Дату не выбрали',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => close(context),
            child: const Text('OK'),
          ),
        ],
      );
    }
  }
}
