import 'package:expense_tracker_app/core/helpers/app_colors.dart';
import 'package:expense_tracker_app/feature/home/presentation/ui/home_screen.dart';
import 'package:expense_tracker_app/feature/home/presentation/widget/expense_list_item.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          HomeScreen(),
          HomeScreen(),
          HomeScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {

        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "New Expense"),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: "Stats"),
        ],
      ),
    );
  }
}
