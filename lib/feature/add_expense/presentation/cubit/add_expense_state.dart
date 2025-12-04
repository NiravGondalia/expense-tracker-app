import 'package:expense_tracker_app/feature/add_expense/domain/model/category.dart';

abstract class AddExpenseState {}

class AddExpenseLoading extends AddExpenseState {}

class AddExpenseLoaded extends AddExpenseState {
  final List<Category> categories;
  final String selectedCategory;
  final DateTime selectedDate;

  AddExpenseLoaded({
    required this.categories,
    required this.selectedCategory,
    required this.selectedDate,
  });
}

class AddExpenseSuccess extends AddExpenseState {}

class AddExpenseError extends AddExpenseState {
  final String message;
  AddExpenseError(this.message);
}
