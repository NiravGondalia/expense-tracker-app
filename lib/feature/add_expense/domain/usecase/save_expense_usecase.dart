import 'package:expense_tracker_app/feature/add_expense/domain/model/expense.dart';
import 'package:expense_tracker_app/feature/add_expense/domain/repository/add_expense_repository.dart';

class SaveExpenseUseCase {
  final AddExpenseRepository _repository;

  SaveExpenseUseCase(this._repository);

  Future<int> call(Expense expense) async {
    return await _repository.saveExpense(expense);
  }
}

