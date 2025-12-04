import 'package:expense_tracker_app/feature/add_expense/domain/model/category.dart';
import 'package:expense_tracker_app/feature/add_expense/domain/model/expense.dart';

abstract class HomeRepository {
  Future<List<Expense>> getExpenses();
  Future<List<Category>> getCategories();
}

