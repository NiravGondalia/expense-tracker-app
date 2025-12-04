import 'package:expense_tracker_app/core/navigation/app_routes.dart';
import 'package:expense_tracker_app/core/navigation/navigation_service.dart';
import 'package:expense_tracker_app/core/navigation/route_generator.dart';
import 'package:flutter/material.dart';

import 'core/di/di_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      navigatorKey: getIt<NavigationService>().navigatorKey,
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: AppRoutes.dashboard,
    );
  }
}