import 'package:expense_tracker_app/feature/add_expense/domain/model/expense.dart';
import 'package:expense_tracker_app/feature/home/domain/repository/home_repository.dart';

class GetExpensesUseCase {
  final HomeRepository _repository;

  GetExpensesUseCase(this._repository);

  Future<List<Expense>> call() async {
    return await _repository.getExpenses();
  }
}

