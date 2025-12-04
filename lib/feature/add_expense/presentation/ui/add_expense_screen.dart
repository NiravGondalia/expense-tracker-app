import 'package:expense_tracker_app/core/extensions/size_extension.dart';
import 'package:expense_tracker_app/core/helpers/app_colors.dart';
import 'package:expense_tracker_app/feature/add_expense/presentation/widget/category_chip.dart';
import 'package:flutter/material.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Expense"), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Amount",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            8.vSpace,
            TextField(
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                prefixText: "₹ ",
                prefixStyle: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                hintText: "0",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            24.vSpace,

            Text(
              "Category",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            8.vSpace,
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                CategoryChip(
                  label: "Food",
                  icon: Icons.restaurant,
                  isSelected: true,
                ),
                CategoryChip(
                  label: "Transport",
                  icon: Icons.directions_car,
                  isSelected: false,
                ),
                CategoryChip(
                  label: "Shopping",
                  icon: Icons.shopping_bag,
                  isSelected: false,
                ),
                CategoryChip(
                  label: "Bills",
                  icon: Icons.receipt_long,
                  isSelected: false,
                ),
                CategoryChip(
                  label: "Entertainment",
                  icon: Icons.movie,
                  isSelected: false,
                ),
                CategoryChip(
                  label: "Other",
                  icon: Icons.more_horiz,
                  isSelected: false,
                ),
              ],
            ),
            24.vSpace,

            Text(
              "Date",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            8.vSpace,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today, color: AppColors.primary),
                  12.hSpace,
                  Text("Today, Dec 4, 2024", style: TextStyle(fontSize: 16)),
                  Spacer(),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
            24.vSpace,

            Text(
              "Description",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            8.vSpace,
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Add a note...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            32.vSpace,

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Save Expense",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
