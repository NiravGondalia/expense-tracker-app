import 'package:expense_tracker_app/core/database/database_helper.dart';
import 'package:expense_tracker_app/core/navigation/navigation_service.dart';
import 'package:expense_tracker_app/feature/add_expense/presentation/cubit/add_expense_cubit.dart';
import 'package:expense_tracker_app/feature/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:expense_tracker_app/feature/home/data/datasource/home_local_data_source.dart';
import 'package:expense_tracker_app/feature/home/data/repository/home_repository_impl.dart';
import 'package:expense_tracker_app/feature/home/domain/repository/home_repository.dart';
import 'package:expense_tracker_app/feature/home/domain/usecase/calculate_total_spent_usecase.dart';
import 'package:expense_tracker_app/feature/home/domain/usecase/filter_expenses_usecase.dart';
import 'package:expense_tracker_app/feature/home/domain/usecase/get_categories_usecase.dart';
import 'package:expense_tracker_app/feature/home/domain/usecase/get_expenses_usecase.dart';
import 'package:expense_tracker_app/feature/home/presentation/cubit/home_cubit.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void initDependencies() {
  getIt.registerLazySingleton(() => NavigationService());
  getIt.registerLazySingleton(() => DatabaseHelper.instance);

  getIt.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(getIt<DatabaseHelper>()),
  );
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(getIt<HomeLocalDataSource>()),
  );
  getIt.registerFactory(() => GetExpensesUseCase(getIt<HomeRepository>()));
  getIt.registerFactory(() => GetCategoriesUseCase(getIt<HomeRepository>()));
  getIt.registerFactory(() => FilterExpensesUseCase());
  getIt.registerFactory(() => CalculateTotalSpentUseCase());
  getIt.registerLazySingleton(
    () => HomeCubit(
      getExpensesUseCase: getIt<GetExpensesUseCase>(),
      getCategoriesUseCase: getIt<GetCategoriesUseCase>(),
      filterExpensesUseCase: getIt<FilterExpensesUseCase>(),
      calculateTotalSpentUseCase: getIt<CalculateTotalSpentUseCase>(),
    ),
  );

  getIt.registerLazySingleton(() => DashboardCubit());

  getIt.registerFactory(() => AddExpenseCubit());
}
