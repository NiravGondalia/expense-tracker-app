import 'package:expense_tracker_app/core/database/database_helper.dart';
import 'package:expense_tracker_app/feature/add_expense/domain/model/expense.dart';
import 'package:expense_tracker_app/feature/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeLoading());

  List<Expense> _expenses = [];
  double _totalSpent = 0;

  Future<void> loadExpenses() async {
    emit(HomeLoading());

    try {
      _expenses = await DatabaseHelper.instance.getAllExpenses();
      _totalSpent = _expenses.fold<double>(
        0,
        (sum, expense) => sum + expense.amount,
      );

      emit(
        HomeLoaded(
          expenses: _expenses,
          filteredExpenses: _expenses,
          totalSpent: _totalSpent,
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void searchExpenses(String query) {
    final String searchQuery = query.toLowerCase().trim();

    if (searchQuery.isEmpty) {
      emit(
        HomeLoaded(
          expenses: _expenses,
          filteredExpenses: _expenses,
          totalSpent: _totalSpent,
          searchQuery: '',
        ),
      );
      return;
    }

    final List<Expense> filtered = _expenses
        .where(
          (expense) =>
              (expense.description?.toLowerCase() ?? '').contains(searchQuery),
        )
        .toList();

    emit(
      HomeLoaded(
        expenses: _expenses,
        filteredExpenses: filtered,
        totalSpent: _totalSpent,
        searchQuery: query,
      ),
    );
  }
}
