import 'package:expense_tracker_app/feature/add_expense/data/datasource/add_expense_local_data_source.dart';
import 'package:expense_tracker_app/feature/add_expense/domain/model/category.dart';
import 'package:expense_tracker_app/feature/add_expense/domain/model/expense.dart';
import 'package:expense_tracker_app/feature/add_expense/domain/repository/add_expense_repository.dart';

class AddExpenseRepositoryImpl implements AddExpenseRepository {
  final AddExpenseLocalDataSource _localDataSource;

  AddExpenseRepositoryImpl(this._localDataSource);

  @override
  Future<List<Category>> getCategories() async {
    return await _localDataSource.getCategories();
  }

  @override
  Future<int> saveExpense(Expense expense) async {
    return await _localDataSource.saveExpense(expense);
  }
}

