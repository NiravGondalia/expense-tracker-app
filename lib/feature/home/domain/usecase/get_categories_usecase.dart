import 'package:expense_tracker_app/feature/add_expense/domain/model/category.dart';
import 'package:expense_tracker_app/feature/home/domain/repository/home_repository.dart';

class GetCategoriesUseCase {
  final HomeRepository _repository;

  GetCategoriesUseCase(this._repository);

  Future<List<Category>> call() async {
    return await _repository.getCategories();
  }
}

