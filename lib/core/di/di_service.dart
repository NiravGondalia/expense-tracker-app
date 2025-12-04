import 'package:expense_tracker_app/core/navigation/navigation_service.dart';
import 'package:expense_tracker_app/feature/add_expense/presentation/cubit/add_expense_cubit.dart';
import 'package:expense_tracker_app/feature/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void initDependencies() {
  getIt.registerLazySingleton(() => NavigationService());
  getIt.registerLazySingleton(() => DashboardCubit());
  getIt.registerFactory(() => AddExpenseCubit());
}
