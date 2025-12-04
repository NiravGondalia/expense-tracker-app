import 'package:expense_tracker_app/feature/add_expense/domain/model/expense.dart';

abstract class HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Expense> expenses;
  final double totalSpent;

  HomeLoaded({
    required this.expenses,
    required this.totalSpent,
  });
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

