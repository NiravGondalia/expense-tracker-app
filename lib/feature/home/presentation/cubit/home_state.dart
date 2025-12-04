import 'package:expense_tracker_app/feature/add_expense/domain/model/category.dart';
import 'package:expense_tracker_app/feature/add_expense/domain/model/expense.dart';

abstract class HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Expense> expenses;
  final List<Expense> filteredExpenses;
  final List<Category> categories;
  final double totalSpent;
  final String searchQuery;
  final String? selectedCategory;

  HomeLoaded({
    required this.expenses,
    required this.filteredExpenses,
    required this.categories,
    required this.totalSpent,
    this.searchQuery = '',
    this.selectedCategory,
  });
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

