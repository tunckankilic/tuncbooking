import 'dart:io';

import 'package:tuncbooking/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = "/signUp";
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _firstNameTextEditingController =
      TextEditingController();
  final TextEditingController _lastNameTextEditingController =
      TextEditingController();
  final TextEditingController _cityTextEditingController =
      TextEditingController();
  final TextEditingController _countryTextEditingController =
      TextEditingController();
  final TextEditingController _bioTextEditingController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  File? imageFileOfUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.pinkAccent,
              Colors.amber,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
        ),
        title: const Text(
          'Create New Account',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
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
            Padding(
              padding: const EdgeInsets.only(
                left: 25.0,
                right: 25,
              ),
              child: Image.asset(
                "images/signup.png",
                width: 240,
              ),
            ),
            const Text(
              "Tell us about you:",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: "Email"),
                        style: const TextStyle(
                          fontSize: 25.0,
                        ),
                        controller: _emailTextEditingController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Please write valid email";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
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
                      padding: const EdgeInsets.only(top: 20.0),
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: "First Name"),
                        style: const TextStyle(
                          fontSize: 25.0,
                        ),
                        controller: _firstNameTextEditingController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Please write your first name";
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: "Last Name"),
                        style: const TextStyle(
                          fontSize: 25.0,
                        ),
                        controller: _lastNameTextEditingController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Please write your last name";
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: "City"),
                        style: const TextStyle(
                          fontSize: 25.0,
                        ),
                        controller: _cityTextEditingController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Please write your city name";
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: "Country"),
                        style: const TextStyle(
                          fontSize: 25.0,
                        ),
                        controller: _countryTextEditingController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Please write your country";
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: "Bio"),
                        style: const TextStyle(
                          fontSize: 25.0,
                        ),
                        maxLines: 4,
                        controller: _bioTextEditingController,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: MaterialButton(
                onPressed: () async {
                  var imageFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);

                  if (imageFile != null) {
                    imageFileOfUser = File(imageFile.path);

                    setState(() {
                      imageFileOfUser;
                    });
                  }
                },
                child: imageFileOfUser == null
                    ? const Icon(Icons.add_a_photo)
                    : CircleAvatar(
                        backgroundColor: Colors.pink,
                        radius: MediaQuery.of(context).size.width / 5.0,
                        child: CircleAvatar(
                          backgroundImage: FileImage(imageFileOfUser!),
                          radius: MediaQuery.of(context).size.width / 5.2,
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 44.0, right: 80, left: 80),
              child: ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate() ||
                      imageFileOfUser == null) {
                    Get.snackbar("Field Missing",
                        "Please choose image and fill out complete sign up form.");
                    return;
                  }

                  if (_emailTextEditingController.text.isEmpty &&
                      _passwordTextEditingController.text.isEmpty) {
                    Get.snackbar("Field Missing",
                        "Please fill out complete sign up form.");
                    return;
                  }

                  userViewModel.signUp(
                    _emailTextEditingController.text.trim(),
                    _passwordTextEditingController.text.trim(),
                    _firstNameTextEditingController.text.trim(),
                    _lastNameTextEditingController.text.trim(),
                    _cityTextEditingController.text.trim(),
                    _countryTextEditingController.text.trim(),
                    _bioTextEditingController.text.trim(),
                    imageFileOfUser,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                ),
                child: const Text(
                  "Create Account",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
