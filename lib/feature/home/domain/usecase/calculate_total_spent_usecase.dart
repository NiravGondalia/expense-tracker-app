import 'package:expense_tracker_app/feature/add_expense/domain/model/expense.dart';

class CalculateTotalSpentUseCase {
  double call(List<Expense> expenses) {
    return expenses.fold<double>(
      0,
      (sum, expense) => sum + expense.amount,
    );
  }
}

