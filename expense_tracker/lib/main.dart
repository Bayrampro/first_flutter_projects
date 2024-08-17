import 'package:expense_tracker/app/app.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

void main() {
  GetIt.I.registerLazySingleton<Uuid>(() => const Uuid());
  GetIt.I.registerLazySingleton<DateFormat>(() => DateFormat.yMd());
  runApp(const ExpenseTracker());
}
