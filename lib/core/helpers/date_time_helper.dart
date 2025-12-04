import 'package:flutter/material.dart';

class DateTimeHelper {
  DateTimeHelper._();

  static String formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final now = DateTime.now();
    final isToday =
        date.day == now.day && date.month == now.month && date.year == now.year;
    final prefix = isToday ? 'Today, ' : '';
    return '$prefix${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  static Future<DateTime?> showDatePickerDialog(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
  }
}
