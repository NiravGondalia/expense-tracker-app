import 'package:expense_tracker_app/core/database/database_helper.dart';
import 'package:expense_tracker_app/feature/add_expense/domain/model/category.dart';
import 'package:expense_tracker_app/feature/add_expense/domain/model/expense.dart';

abstract class AddExpenseLocalDataSource {
  Future<List<Category>> getCategories();
  Future<int> saveExpense(Expense expense);
}

class AddExpenseLocalDataSourceImpl implements AddExpenseLocalDataSource {
  final DatabaseHelper _databaseHelper;

  AddExpenseLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<List<Category>> getCategories() async {
    return await _databaseHelper.getAllCategories();
  }

  @override
  Future<int> saveExpense(Expense expense) async {
    return await _databaseHelper.insertExpense(expense);
  }
}

