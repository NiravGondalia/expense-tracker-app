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
}
