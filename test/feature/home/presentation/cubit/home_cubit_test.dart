import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker_app/feature/add_expense/domain/model/category.dart';
import 'package:expense_tracker_app/feature/add_expense/domain/model/expense.dart';
import 'package:expense_tracker_app/feature/home/domain/usecase/calculate_total_spent_usecase.dart';
import 'package:expense_tracker_app/feature/home/domain/usecase/delete_expense_usecase.dart';
import 'package:expense_tracker_app/feature/home/domain/usecase/filter_expenses_usecase.dart';
import 'package:expense_tracker_app/feature/home/domain/usecase/get_categories_usecase.dart';
import 'package:expense_tracker_app/feature/home/domain/usecase/get_expenses_usecase.dart';
import 'package:expense_tracker_app/feature/home/presentation/cubit/home_cubit.dart';
import 'package:expense_tracker_app/feature/home/presentation/cubit/home_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetExpensesUseCase extends Mock implements GetExpensesUseCase {}
class MockGetCategoriesUseCase extends Mock implements GetCategoriesUseCase {}
class MockFilterExpensesUseCase extends Mock implements FilterExpensesUseCase {}
class MockCalculateTotalSpentUseCase extends Mock implements CalculateTotalSpentUseCase {}
class MockDeleteExpenseUseCase extends Mock implements DeleteExpenseUseCase {}

void main() {
  late HomeCubit cubit;
  late MockGetExpensesUseCase getExpenses;
  late MockGetCategoriesUseCase getCategories;
  late MockFilterExpensesUseCase filterExpenses;
  late MockCalculateTotalSpentUseCase calcTotal;
  late MockDeleteExpenseUseCase deleteExpense;

  final List<Expense> expenses = [
    Expense(id: 1, amount: 100, category: 'Food', date: DateTime(2024, 1, 1), description: 'Lunch'),
    Expense(id: 2, amount: 200, category: 'Transport', date: DateTime(2024, 1, 2), description: 'Taxi'),
    Expense(id: 3, amount: 50, category: 'Food', date: DateTime(2024, 1, 3), description: 'Coffee'),
  ];

  final List<Category> categories = [
    Category(id: 1, name: 'Food', icon: 'restaurant'),
    Category(id: 2, name: 'Transport', icon: 'directions_car'),
  ];

  setUp(() {
    getExpenses = MockGetExpensesUseCase();
    getCategories = MockGetCategoriesUseCase();
    filterExpenses = MockFilterExpensesUseCase();
    calcTotal = MockCalculateTotalSpentUseCase();
    deleteExpense = MockDeleteExpenseUseCase();

    cubit = HomeCubit(
      getExpensesUseCase: getExpenses,
      getCategoriesUseCase: getCategories,
      filterExpensesUseCase: filterExpenses,
      calculateTotalSpentUseCase: calcTotal,
      deleteExpenseUseCase: deleteExpense,
    );
  });

  tearDown(() => cubit.close());

  test('initial state should be HomeLoading', () {
    expect(cubit.state, isA<HomeLoading>());
  });

  group('loadExpenses', () {
    blocTest<HomeCubit, HomeState>(
      'loads expenses successfully',
      build: () {
        when(() => getExpenses()).thenAnswer((_) async => expenses);
        when(() => getCategories()).thenAnswer((_) async => categories);
        when(() => calcTotal(expenses)).thenReturn(350.0);
        when(() => filterExpenses(
          expenses: expenses,
          category: null,
          searchQuery: '',
        )).thenReturn(expenses);
        return cubit;
      },
      act: (c) => c.loadExpenses(),
      expect: () => [
        isA<HomeLoading>(),
        isA<HomeLoaded>(),
      ],
      verify: (_) {
        verify(() => getExpenses()).called(1);
        verify(() => getCategories()).called(1);
      },
    );

    blocTest<HomeCubit, HomeState>(
      'emits error when loading fails',
      build: () {
        when(() => getExpenses()).thenThrow(Exception('db error'));
        return cubit;
      },
      act: (c) => c.loadExpenses(),
      expect: () => [
        isA<HomeLoading>(),
        isA<HomeError>(),
      ],
    );
  });
}
