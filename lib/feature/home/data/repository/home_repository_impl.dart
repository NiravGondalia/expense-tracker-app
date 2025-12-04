import 'package:expense_tracker_app/feature/add_expense/domain/model/category.dart';
import 'package:expense_tracker_app/feature/add_expense/domain/model/expense.dart';
import 'package:expense_tracker_app/feature/home/data/datasource/home_local_data_source.dart';
import 'package:expense_tracker_app/feature/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource _localDataSource;

  HomeRepositoryImpl(this._localDataSource);

  @override
  Future<List<Expense>> getExpenses() async {
    return await _localDataSource.getExpenses();
  }

  @override
  Future<List<Category>> getCategories() async {
    return await _localDataSource.getCategories();
  }

  @override
  Future<int> deleteExpense(int id) async {
    return await _localDataSource.deleteExpense(id);
  }
}

