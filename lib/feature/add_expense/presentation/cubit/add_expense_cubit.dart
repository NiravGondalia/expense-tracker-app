import 'package:expense_tracker_app/core/database/database_helper.dart';
import 'package:expense_tracker_app/feature/add_expense/domain/model/category.dart';
import 'package:expense_tracker_app/feature/add_expense/domain/model/expense.dart';
import 'package:expense_tracker_app/feature/add_expense/presentation/cubit/add_expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpenseCubit extends Cubit<AddExpenseState> {
  AddExpenseCubit() : super(AddExpenseLoading());

  List<Category> _categories = [];
  String _selectedCategory = '';
  DateTime _selectedDate = DateTime.now();

  Future<void> loadCategories() async {
    emit(AddExpenseLoading());
    _categories = await DatabaseHelper.instance.getAllCategories();
    _selectedCategory = _categories.isNotEmpty ? _categories.first.name : '';
    _selectedDate = DateTime.now();
    emit(AddExpenseLoaded(
      categories: _categories,
      selectedCategory: _selectedCategory,
      selectedDate: _selectedDate,
    ));
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    emit(AddExpenseLoaded(
      categories: _categories,
      selectedCategory: _selectedCategory,
      selectedDate: _selectedDate,
    ));
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    emit(AddExpenseLoaded(
      categories: _categories,
      selectedCategory: _selectedCategory,
      selectedDate: _selectedDate,
    ));
  }

  Future<void> saveExpense({
    required String amountText,
    required String descriptionText,
  }) async {
    final amount = double.tryParse(amountText) ?? 0;

    if (amount <= 0) {
      emit(AddExpenseError('Please enter a valid amount'));
      return;
    }

    if (descriptionText.trim().isEmpty) {
      emit(AddExpenseError('Please enter a description'));
      return;
    }

    emit(AddExpenseLoading());

    try {
      final expense = Expense(
        amount: amount,
        category: _selectedCategory,
        date: _selectedDate,
        description: descriptionText.trim(),
      );

      await DatabaseHelper.instance.insertExpense(expense);
      emit(AddExpenseSuccess());
    } catch (e) {
      emit(AddExpenseError(e.toString()));
    }
  }
}
