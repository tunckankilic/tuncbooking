import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuncbooking/view/screens/guest_home/guest_home_screen.dart';
import 'package:tuncbooking/view/screens/screens.dart';

class AppRouter {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static final routes = [
    GetPage(
      name: SplashScreen.routeName,
      page: () => const SplashScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: LoginScreen.routeName,
      page: () => const LoginScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: SignUpScreen.routeName,
      page: () => const SignUpScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: ConversationScreen.routeName,
      page: () => ConversationScreen(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: GuestHomeScreen.routeName,
      page: () => const GuestHomeScreen(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: AccountScreen.routeName,
      page: () => const AccountScreen(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: BookListingScreen.routeName,
      page: () => BookListingScreen(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: ExploreScreen.routeName,
      page: () => const ExploreScreen(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: InboxScreen.routeName,
      page: () => const InboxScreen(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: SavedListingsScreen.routeName,
      page: () => const SavedListingsScreen(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: TripsScreen.routeName,
      page: () => const TripsScreen(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: ViewPostingScreen.routeName,
      page: () => ViewPostingScreen(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: MyPostingsScreen.routeName,
      page: () => const MyPostingsScreen(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: CreatePostingScreen.routeName,
      page: () => CreatePostingScreen(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: BookingsScreen.routeName,
      page: () => const BookingsScreen(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: HostHomeScreen.routeName,
      page: () => HostHomeScreen(),
      transition: Transition.leftToRightWithFade,
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
