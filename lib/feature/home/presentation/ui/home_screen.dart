import 'package:expense_tracker_app/core/di/di_service.dart';
import 'package:expense_tracker_app/core/helpers/app_colors.dart';
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

  @override
  void initState() {
    super.initState();
    _cubit = getIt<HomeCubit>()..loadExpenses();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
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
                  Expanded(child: _buildExpenseList(state)),
                ],
              ),
            );
          }
          return Center(child: Text("Something went wrong"));
        },
      ),
    );
  }

  Widget _buildExpenseList(HomeLoaded state) {
    if (state.expenses.isEmpty) {
      return Center(child: Text("Add a new expense to get started"));
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8),
      itemCount: state.expenses.length,
      itemBuilder: (context, index) {
        return ExpenseListItem(expense: state.expenses[index]);
      },
    );
  }
}
