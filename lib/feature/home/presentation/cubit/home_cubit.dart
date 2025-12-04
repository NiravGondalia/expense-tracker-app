import 'package:expense_tracker_app/core/database/database_helper.dart';
import 'package:expense_tracker_app/feature/add_expense/domain/model/category.dart';
import 'package:expense_tracker_app/feature/add_expense/domain/model/expense.dart';
import 'package:expense_tracker_app/feature/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeLoading());

  List<Expense> _expenses = [];
  List<Category> _categories = [];
  double _totalSpent = 0;
  String _searchQuery = '';
  String? _selectedCategory;

  Future<void> loadExpenses() async {
    emit(HomeLoading());

    try {
      _expenses = await DatabaseHelper.instance.getAllExpenses();
      _categories = await DatabaseHelper.instance.getAllCategories();
      _totalSpent = _expenses.fold<double>(
        0,
        (sum, expense) => sum + expense.amount,
      );
      _searchQuery = '';

      searchExpenses(_searchQuery);
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void searchExpenses(String query) {
    _searchQuery = query.toLowerCase().trim();
    _applyFilters();
  }

  void filterByCategory(String? category) {
    _selectedCategory = category;
    _applyFilters();
  }

  void _applyFilters() {
    List<Expense> filtered = _expenses;

    if (_selectedCategory != null) {
      filtered = filtered
          .where((expense) => expense.category == _selectedCategory)
          .toList();
    }

    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where(
            (expense) =>
                (expense.description?.toLowerCase() ?? '')
                    .contains(_searchQuery),
          )
          .toList();
    }

    emit(
      HomeLoaded(
        expenses: _expenses,
        filteredExpenses: filtered,
        categories: _categories,
        totalSpent: _totalSpent,
        searchQuery: _searchQuery,
        selectedCategory: _selectedCategory,
      ),
    );
  }
}
