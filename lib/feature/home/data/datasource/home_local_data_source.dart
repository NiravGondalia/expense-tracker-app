import 'package:expense_tracker_app/core/database/database_helper.dart';
import 'package:expense_tracker_app/feature/add_expense/domain/model/category.dart';
import 'package:expense_tracker_app/feature/add_expense/domain/model/expense.dart';

abstract class HomeLocalDataSource {
  Future<List<Expense>> getExpenses();
  Future<List<Category>> getCategories();
  Future<int> deleteExpense(int id);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final DatabaseHelper _databaseHelper;

  HomeLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<List<Expense>> getExpenses() async {
    return await _databaseHelper.getAllExpenses();
  }

  @override
  Future<List<Category>> getCategories() async {
    return await _databaseHelper.getAllCategories();
  }

  @override
  Future<int> deleteExpense(int id) async {
    return await _databaseHelper.deleteExpense(id);
  }
}

