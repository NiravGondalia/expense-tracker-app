import 'package:expense_tracker_app/core/helpers/app_colors.dart';
import 'package:expense_tracker_app/feature/home/presentation/widget/expense_list_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total expense",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                Center(
                  child: Text(
                    "₹10,000",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8),
              itemCount: 30,
              itemBuilder: (context, index) => ExpenseListItem(),
            ),
          ),
        ],
      ),
    );
  }
}
