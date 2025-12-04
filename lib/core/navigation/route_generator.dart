import 'package:expense_tracker_app/core/navigation/app_routes.dart';
import 'package:expense_tracker_app/feature/add_expense/presentation/ui/add_expense_screen.dart';
import 'package:expense_tracker_app/feature/dashboard/presentation/ui/dashboard_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.dashboard:
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        );
      case AppRoutes.addExpense:
        return MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => const AddExpenseScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

