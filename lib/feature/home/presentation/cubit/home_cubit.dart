import 'package:expense_tracker_app/core/database/database_helper.dart';
import 'package:expense_tracker_app/feature/add_expense/domain/model/expense.dart';
import 'package:expense_tracker_app/feature/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeLoading());

  Future<void> loadExpenses() async {
    emit(HomeLoading());

    try {
      final List<Expense> expenses = await DatabaseHelper.instance.getAllExpenses();
      final double totalSpent = expenses.fold<double>(
        0,
        (sum, expense) => sum + expense.amount,
      );

      emit(HomeLoaded(
        expenses: expenses,
        totalSpent: totalSpent,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
