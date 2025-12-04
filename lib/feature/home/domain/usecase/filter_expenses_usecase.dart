import 'package:expense_tracker_app/feature/add_expense/domain/model/expense.dart';

class FilterExpensesUseCase {
  List<Expense> call({
    required List<Expense> expenses,
    String? category,
    String searchQuery = '',
  }) {
    List<Expense> filtered = expenses;

    if (category != null) {
      filtered = filtered
          .where((expense) => expense.category == category)
          .toList();
    }

    if (searchQuery.isNotEmpty) {
      final String query = searchQuery.toLowerCase().trim();
      filtered = filtered
          .where(
            (expense) =>
                (expense.description?.toLowerCase() ?? '').contains(query),
          )
          .toList();
    }

    return filtered;
  }
}

