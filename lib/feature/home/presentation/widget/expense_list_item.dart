import 'package:expense_tracker_app/core/extensions/size_extension.dart';
import 'package:expense_tracker_app/core/helpers/app_colors.dart';
import 'package:expense_tracker_app/core/helpers/date_time_helper.dart';
import 'package:expense_tracker_app/feature/add_expense/domain/model/expense.dart';
import 'package:flutter/material.dart';

class ExpenseListItem extends StatelessWidget {
  final Expense expense;
  final VoidCallback onLongPress;

  const ExpenseListItem({
    super.key,
    required this.expense,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress:() => onLongPress(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.1),
              ),
              child: Icon(
                _getCategoryIcon(expense.category),
                color: AppColors.primary,
              ),
            ),
            16.hSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expense.description ?? "Expense",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    DateTimeHelper.formatDate(expense.date),
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            16.hSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  expense.category,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  "₹${expense.amount.toStringAsFixed(0)}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Food':
        return Icons.restaurant;
      case 'Transport':
        return Icons.directions_car;
      case 'Shopping':
        return Icons.shopping_bag;
      case 'Bills':
        return Icons.receipt_long;
      case 'Entertainment':
        return Icons.movie;
      default:
        return Icons.more_horiz;
    }
  }
}
