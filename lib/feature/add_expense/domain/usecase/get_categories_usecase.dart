import 'package:expense_tracker_app/feature/add_expense/domain/model/category.dart';
import 'package:expense_tracker_app/feature/add_expense/domain/repository/add_expense_repository.dart';

class GetCategoriesUseCase {
  final AddExpenseRepository _repository;

  GetCategoriesUseCase(this._repository);

  Future<List<Category>> call() async {
    return await _repository.getCategories();
  }
}

