import 'package:tuncbooking/global.dart';
import 'package:tuncbooking/view/screens/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pinkAccent,
              Colors.amber,
            ],
            begin: FractionalOffset(0, 0),
            end: FractionalOffset(1, 0),
            stops: [0, 1],
            tileMode: TileMode.clamp,
          ),
        ),
        child: ListView(
          children: [
            Image.asset("images/logo.png"),
            const Text(
              "hello friend,\nwelcome back",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.pink,
                fontSize: 30.0,
                letterSpacing: 3,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 26.0),
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: "Email"),
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                        controller: _emailTextEditingController,
                        validator: (valueEmail) {
                          if (!valueEmail!.contains("@")) {
                            return "Please write valid email.";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 21.0),
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: "Password"),
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                        controller: _passwordTextEditingController,
                        obscureText: true,
                        validator: (valuePassword) {
                          if (valuePassword!.length < 5) {
                            return "Password must be at least 6 or more characters.";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 26.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await userViewModel.login(
                              _emailTextEditingController.text.trim(),
                              _passwordTextEditingController.text.trim(),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(SignUpScreen());
                      },
                      child: const Text(
                        "Don't have an account? Create here",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
