import 'package:expense_tracker_app/core/di/di_service.dart';
import 'package:expense_tracker_app/core/navigation/app_routes.dart';
import 'package:expense_tracker_app/core/navigation/navigation_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardCubit extends Cubit<int> {
  DashboardCubit() : super(0);

  void checkAndChangePage(int index, Function() allowPageChange) {
    if(index == 1) {
      getIt<NavigationService>().pushNamed(AppRoutes.addExpense);
    } else {
      allowPageChange();
    }
  }
}

