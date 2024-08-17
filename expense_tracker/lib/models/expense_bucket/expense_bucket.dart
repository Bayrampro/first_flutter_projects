import '../models.dart';

class ExpenseBucket {
  ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => category == expense.category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    var sum = 0.0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
