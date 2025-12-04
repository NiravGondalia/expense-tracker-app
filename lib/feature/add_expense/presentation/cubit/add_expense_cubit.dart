import 'package:expense_tracker_app/core/database/database_helper.dart';
import 'package:expense_tracker_app/feature/add_expense/domain/model/expense.dart';
import 'package:expense_tracker_app/feature/add_expense/presentation/cubit/add_expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpenseCubit extends Cubit<AddExpenseState> {
  AddExpenseCubit() : super(AddExpenseLoading());

  Future<void> saveExpense({
    required String amountText,
    required String category,
    required DateTime date,
    required String descriptionText,
  }) async {
    final amount = double.tryParse(amountText) ?? 0;
    if (amount <= 0) return;

    emit(AddExpenseLoading());

    try {
      final expense = Expense(
        amount: amount,
        category: category,
        date: date,
        description: descriptionText.isEmpty ? null : descriptionText,
      );

      await DatabaseHelper.instance.insertExpense(expense);
      emit(AddExpenseSuccess());
    } catch (e) {
      emit(AddExpenseError(e.toString()));
    }
  }
}
