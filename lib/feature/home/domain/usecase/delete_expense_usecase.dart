import 'package:expense_tracker_app/feature/home/domain/repository/home_repository.dart';

class DeleteExpenseUseCase {
  final HomeRepository _repository;

  DeleteExpenseUseCase(this._repository);

  Future<int> call(int id) async {
    return await _repository.deleteExpense(id);
  }
}

