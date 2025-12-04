import 'package:expense_tracker_app/core/di/di_service.dart';
import 'package:expense_tracker_app/feature/add_expense/domain/model/category.dart';
import 'package:expense_tracker_app/feature/add_expense/domain/model/expense.dart';
import 'package:expense_tracker_app/feature/add_expense/domain/usecase/get_categories_usecase.dart';
import 'package:expense_tracker_app/feature/add_expense/domain/usecase/save_expense_usecase.dart';
import 'package:expense_tracker_app/feature/add_expense/presentation/cubit/add_expense_state.dart';
import 'package:expense_tracker_app/feature/home/presentation/cubit/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpenseCubit extends Cubit<AddExpenseState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final SaveExpenseUseCase _saveExpenseUseCase;

  AddExpenseCubit({
    required GetCategoriesUseCase getCategoriesUseCase,
    required SaveExpenseUseCase saveExpenseUseCase,
  })  : _getCategoriesUseCase = getCategoriesUseCase,
        _saveExpenseUseCase = saveExpenseUseCase,
        super(AddExpenseLoading());

  List<Category> _categories = [];
  String _selectedCategory = '';
  DateTime _selectedDate = DateTime.now();

  Future<void> loadCategories() async {
    emit(AddExpenseLoading());
    _categories = await _getCategoriesUseCase();
    _selectedCategory = _categories.isNotEmpty ? _categories.first.name : '';
    _selectedDate = DateTime.now();
    _emitLoadedState();
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    _emitLoadedState();
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    _emitLoadedState();
  }

  Future<void> saveExpense({
    required String amountText,
    required String descriptionText,
  }) async {
    final double amount = double.tryParse(amountText) ?? 0;

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
      final Expense expense = Expense(
        amount: amount,
        category: _selectedCategory,
        date: _selectedDate,
        description: descriptionText.trim(),
      );

      await _saveExpenseUseCase(expense);
      getIt<HomeCubit>().loadExpenses();
      emit(AddExpenseSuccess());
    } catch (e) {
      emit(AddExpenseError(e.toString()));
    }
  }

  void _emitLoadedState() {
    emit(AddExpenseLoaded(
      categories: _categories,
      selectedCategory: _selectedCategory,
      selectedDate: _selectedDate,
    ));
  }
}
