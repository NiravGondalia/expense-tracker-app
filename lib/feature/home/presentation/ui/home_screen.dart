import 'package:expense_tracker_app/core/di/di_service.dart';
import 'package:expense_tracker_app/core/extensions/size_extension.dart';
import 'package:expense_tracker_app/core/helpers/app_colors.dart';
import 'package:expense_tracker_app/core/navigation/app_routes.dart';
import 'package:expense_tracker_app/core/navigation/navigation_service.dart';
import 'package:expense_tracker_app/feature/home/presentation/cubit/home_cubit.dart';
import 'package:expense_tracker_app/feature/home/presentation/cubit/home_state.dart';
import 'package:expense_tracker_app/feature/home/presentation/widget/expense_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeCubit _cubit;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cubit = getIt<HomeCubit>()..loadExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is HomeError) {
            return Center(child: Text(state.message));
          }
          if (state is HomeLoaded) {
            return Scaffold(
              body: Column(
                children: [
                  Container(
                    width: double.infinity,
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
                            "₹${state.totalSpent.toStringAsFixed(0)}",
                            style: TextStyle(color: Colors.white, fontSize: 40),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) => _cubit.searchExpenses(value),
                            decoration: InputDecoration(
                              hintText: "Search expenses...",
                              prefixIcon: Icon(Icons.search),
                              suffixIcon: InkWell(
                                child: Icon(Icons.cancel_outlined),
                                onTap: () {
                                  _searchController.clear();
                                  _cubit.loadExpenses();
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                        16.hSpace,
                        ElevatedButton(
                          onPressed: () =>
                              _showFilterBottomSheet(context, state),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: state.selectedCategory != null
                                ? AppColors.primary
                                : null,
                          ),
                          child: Icon(
                            Icons.filter_alt,
                            color: state.selectedCategory != null
                                ? Colors.white
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: _buildExpenseList(state)),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () =>
                    getIt<NavigationService>().pushNamed(AppRoutes.addExpense),
                child: Icon(Icons.add),
              ),
            );
          }
          return Center(child: Text("Something went wrong"));
        },
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context, HomeLoaded state) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Filter by Category",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  if (state.selectedCategory != null)
                    TextButton(
                      onPressed: () {
                        _cubit.filterByCategory(null);
                        Navigator.pop(context);
                      },
                      child: Text("Clear"),
                    ),
                ],
              ),
              16.vSpace,
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: state.categories.map((category) {
                  final isSelected = state.selectedCategory == category.name;
                  return ChoiceChip(
                    label: Text(category.name),
                    selected: isSelected,
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                    onSelected: (_) {
                      _cubit.filterByCategory(category.name);
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
              ),
              16.vSpace,
            ],
          ),
        );
      },
    );
  }

  Widget _buildExpenseList(HomeLoaded state) {
    if (state.expenses.isEmpty) {
      return Center(child: Text("Add a new expense to get started"));
    }

    if (state.filteredExpenses.isEmpty) {
      return Center(child: Text("No expenses found"));
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8),
      itemCount: state.filteredExpenses.length,
      itemBuilder: (context, index) {
        return ExpenseListItem(expense: state.filteredExpenses[index]);
      },
    );
  }
}
