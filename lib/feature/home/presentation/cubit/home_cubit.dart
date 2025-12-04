import 'package:expense_tracker_app/feature/add_expense/domain/model/category.dart';
import 'package:expense_tracker_app/feature/add_expense/domain/model/expense.dart';
import 'package:expense_tracker_app/feature/home/domain/usecase/calculate_total_spent_usecase.dart';
import 'package:expense_tracker_app/feature/home/domain/usecase/filter_expenses_usecase.dart';
import 'package:expense_tracker_app/feature/home/domain/usecase/get_categories_usecase.dart';
import 'package:expense_tracker_app/feature/home/domain/usecase/get_expenses_usecase.dart';
import 'package:expense_tracker_app/feature/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetExpensesUseCase _getExpensesUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;
  final FilterExpensesUseCase _filterExpensesUseCase;
  final CalculateTotalSpentUseCase _calculateTotalSpentUseCase;

  HomeCubit({
    required GetExpensesUseCase getExpensesUseCase,
    required GetCategoriesUseCase getCategoriesUseCase,
    required FilterExpensesUseCase filterExpensesUseCase,
    required CalculateTotalSpentUseCase calculateTotalSpentUseCase,
  })  : _getExpensesUseCase = getExpensesUseCase,
        _getCategoriesUseCase = getCategoriesUseCase,
        _filterExpensesUseCase = filterExpensesUseCase,
        _calculateTotalSpentUseCase = calculateTotalSpentUseCase,
        super(HomeLoading());

  List<Expense> _expenses = [];
  List<Category> _categories = [];
  double _totalSpent = 0;
  String _searchQuery = '';
  String? _selectedCategory;

  Future<void> loadExpenses() async {
    emit(HomeLoading());

    try {
      _expenses = await _getExpensesUseCase();
      _categories = await _getCategoriesUseCase();
      _totalSpent = _calculateTotalSpentUseCase(_expenses);
      _searchQuery = '';

      _emitLoadedState();
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void searchExpenses(String query) {
    _searchQuery = query;
    _emitLoadedState();
  }

  void filterByCategory(String? category) {
    _selectedCategory = category;
    _emitLoadedState();
  }

  void _emitLoadedState() {
    final List<Expense> filteredExpenses = _filterExpensesUseCase(
      expenses: _expenses,
      category: _selectedCategory,
      searchQuery: _searchQuery,
    );

    emit(
      HomeLoaded(
        expenses: _expenses,
        filteredExpenses: filteredExpenses,
        categories: _categories,
        totalSpent: _totalSpent,
        searchQuery: _searchQuery,
        selectedCategory: _selectedCategory,
      ),
    );
  }
}
