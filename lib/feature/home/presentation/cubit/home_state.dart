import 'package:expense_tracker_app/feature/add_expense/domain/model/expense.dart';

abstract class HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Expense> expenses;
  final List<Expense> filteredExpenses;
  final double totalSpent;
  final String searchQuery;

  HomeLoaded({
    required this.expenses,
    required this.filteredExpenses,
    required this.totalSpent,
    this.searchQuery = '',
  });
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

