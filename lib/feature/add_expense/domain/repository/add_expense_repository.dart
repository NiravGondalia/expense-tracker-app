import 'package:expense_tracker_app/feature/add_expense/domain/model/category.dart';
import 'package:expense_tracker_app/feature/add_expense/domain/model/expense.dart';

abstract class AddExpenseRepository {
  Future<List<Category>> getCategories();
  Future<int> saveExpense(Expense expense);
}

