import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => navigatorKey.currentState;

  Future? pushNamed(String routeName) {
    return _navigator?.pushNamed(routeName);
  }

  void pop() {
    _navigator?.pop();
  }

  bool canPop() {
    return _navigator?.canPop() ?? false;
  }
}
