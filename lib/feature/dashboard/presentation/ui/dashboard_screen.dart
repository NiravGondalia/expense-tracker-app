import 'package:expense_tracker_app/core/di/di_service.dart';
import 'package:expense_tracker_app/feature/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:expense_tracker_app/feature/home/presentation/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardCubit>(
      create: (context) => getIt<DashboardCubit>(),
      child: BlocBuilder<DashboardCubit, int>(
        builder: (context, currentIndex) {
          return Scaffold(
            body: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [HomeScreen(), SizedBox()],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              elevation: 10,
              onTap: (index) {
                getIt<DashboardCubit>().checkAndChangePage(index, () {
                  _pageController.animateToPage(
                    index,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: "New Expense",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
