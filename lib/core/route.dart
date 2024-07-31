import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuncbooking/view/screens/screens.dart';

class AppRouter {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static final routes = [
    GetPage(
      name: SplashScreen.routeName,
      page: () => SplashScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: LoginScreen.routeName,
      page: () => LoginScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: SignUpScreen.routeName,
      page: () => SignUpScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: ConversationScreen.routeName,
      page: () => ConversationScreen(),
      transition: Transition.downToUp,
    ),
    // Diğer sayfaları buraya ekleyin
  ];

  static void navigateTo(String routeName, {Object? arguments}) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  static void pushReplacementTo(String routeName, {Object? arguments}) {
    navigatorKey.currentState
        ?.pushReplacementNamed(routeName, arguments: arguments);
  }

  static void popUntil(String routeName) {
    navigatorKey.currentState?.popUntil(ModalRoute.withName(routeName));
  }

  static void pop() {
    navigatorKey.currentState?.pop();
  }
}
