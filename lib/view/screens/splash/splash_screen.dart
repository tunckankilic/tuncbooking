import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tuncbooking/core/core.dart';
import 'package:tuncbooking/view/screens/screens.dart';

class SplashScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      );
  static const String routeName = "/";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushNamed(LoginScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: Styles.splashGradient(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Assets.splash),
              Padding(
                padding: EdgeInsets.only(top: Gaps.g18),
                child: Text(
                  Texts.splashText,
                  style: Styles.splashTS,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
