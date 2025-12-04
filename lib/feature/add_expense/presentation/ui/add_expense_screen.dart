import 'package:expense_tracker_app/core/di/di_service.dart';
import 'package:expense_tracker_app/core/extensions/size_extension.dart';
import 'package:expense_tracker_app/core/helpers/app_colors.dart';
import 'package:expense_tracker_app/feature/add_expense/presentation/cubit/add_expense_cubit.dart';
import 'package:expense_tracker_app/feature/add_expense/presentation/cubit/add_expense_state.dart';
import 'package:expense_tracker_app/feature/add_expense/presentation/widget/category_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final Map<String, IconData> _iconMap = {
    'restaurant': Icons.restaurant,
    'directions_car': Icons.directions_car,
    'shopping_bag': Icons.shopping_bag,
    'receipt_long': Icons.receipt_long,
    'movie': Icons.movie,
    'more_horiz': Icons.more_horiz,
  };

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddExpenseCubit>()..loadCategories(),
      child: BlocConsumer<AddExpenseCubit, AddExpenseState>(
        listener: (context, state) {
          if (state is AddExpenseSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: Text("Add Expense"), centerTitle: true),
            body: state is AddExpenseLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Amount",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        8.vSpace,
                        TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
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
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        8.vSpace,
                        if (state is AddExpenseLoaded)
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: state.categories.map((category) {
                              return CategoryChip(
                                label: category.name,
                                icon: _iconMap[category.icon] ?? Icons.category,
                                isSelected:
                                    state.selectedCategory == category.name,
                                onTap: () => getIt<AddExpenseCubit>()
                                    .selectCategory(category.name),
                              );
                            }).toList(),
                          ),
                        24.vSpace,
                        Text(
                          "Date",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        8.vSpace,
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today,
                                  color: AppColors.primary),
                              12.hSpace,
                              Text("Today, Dec 4, 2024",
                                  style: TextStyle(fontSize: 16)),
                              Spacer(),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                        24.vSpace,
                        Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        8.vSpace,
                        TextField(
                          controller: _descriptionController,
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
                            onPressed: () {
                              getIt<AddExpenseCubit>().saveExpense(
                                    amountText: _amountController.text,
                                    date: DateTime.now(),
                                    descriptionText:
                                        _descriptionController.text,
                                  );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              "Save Expense",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
