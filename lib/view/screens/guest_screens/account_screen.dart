import 'package:tuncbooking/global.dart';
import 'package:tuncbooking/core/app_constants.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuncbooking/view/screens/guest_home/guest_home_screen.dart';
import 'package:tuncbooking/view/screens/host_home/host_home_screen.dart';

class AccountScreen extends StatefulWidget {
  static String routeName = "/account";

  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String _hostingTitle = 'Show my Host Dashboard';

  modifyHostingMode() async {
    if (AppConstants.currentUser.isHost!) {
      if (AppConstants.currentUser.isCurrentlyHosting!) {
        AppConstants.currentUser.isCurrentlyHosting = false;

        Get.to(const GuestHomeScreen());
      } else {
        AppConstants.currentUser.isCurrentlyHosting = true;

        Get.to(HostHomeScreen());
      }
    } else {
      await userViewModel.becomeHost(FirebaseAuth.instance.currentUser!.uid);

      AppConstants.currentUser.isCurrentlyHosting = true;

      Get.to(HostHomeScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    if (AppConstants.currentUser.isHost!) {
      if (AppConstants.currentUser.isCurrentlyHosting!) {
        _hostingTitle = 'Show my Guest Dashboard';
      } else {
        _hostingTitle = 'Show my Host Dashboard';
      }
    } else {
      _hostingTitle = 'Become a host';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 50, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //user info
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Center(
                child: Column(
                  children: [
                    //image
                    MaterialButton(
                      onPressed: () {},
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: MediaQuery.of(context).size.width / 4.5,
                        child: CircleAvatar(
                          backgroundImage:
                              AppConstants.currentUser.displayImage,
                          radius: MediaQuery.of(context).size.width / 4.6,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //name and email
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppConstants.currentUser.getFullNameOfUser(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          AppConstants.currentUser.email.toString(),
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            //buttons
            ListView(
              shrinkWrap: true,
              children: [
                //Personal Information btn
                Container(
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
                  child: MaterialButton(
                    height: MediaQuery.of(context).size.height / 9.1,
                    onPressed: () {},
                    child: const ListTile(
                      contentPadding: EdgeInsets.all(0.0),
                      leading: Text(
                        "Personal Information",
                        style: TextStyle(
                          fontSize: 18.5,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      trailing: Icon(
                        size: 34,
                        Icons.person_2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                //Change Hosting btn
                Container(
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
                  child: MaterialButton(
                    height: MediaQuery.of(context).size.height / 9.1,
                    onPressed: () {
                      modifyHostingMode();
                    },
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0.0),
                      leading: Text(
                        _hostingTitle,
                        style: const TextStyle(
                          fontSize: 18.5,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      trailing: const Icon(
                        size: 34,
                        Icons.hotel_outlined,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                //logout btn
                Container(
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
                  child: MaterialButton(
                    height: MediaQuery.of(context).size.height / 9.1,
                    onPressed: () {},
                    child: const ListTile(
                      contentPadding: EdgeInsets.all(0.0),
                      leading: Text(
                        "Log Out",
                        style: TextStyle(
                          fontSize: 18.5,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      trailing: Icon(
                        size: 34,
                        Icons.login_outlined,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
