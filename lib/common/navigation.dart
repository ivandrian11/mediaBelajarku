import 'package:flutter/material.dart';

import '../global.dart';

class Navigation {
  static intentWithData(String routeName, Object arguments) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  static intent(String routeName) {
    navigatorKey.currentState?.pushNamed(routeName);
  }

  static off(String routeName) {
    navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  static offWithData(String routeName, Object arguments) {
    navigatorKey.currentState
        ?.pushReplacementNamed(routeName, arguments: arguments);
  }

  static offAll(String routeName) {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
    );
  }

  static offAllWithData(String routeName, Object arguments) {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  static back() => navigatorKey.currentState?.pop();
}
