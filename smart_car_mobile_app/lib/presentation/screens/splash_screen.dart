import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';


import '../../controllers/authentication_controller.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  final AuthenticationController authenticationController =
      Get.find<AuthenticationController>();
  late final Future intialize;

  @override
  void initState() {
    super.initState();
    intialize = intializeSettings();
  }

  Future<void> intializeSettings() async {
    authenticationController.checkLoginStatus();
    await Future.delayed(const Duration(seconds: 3));
  }

  // @override
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHight = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: intialize,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return splashView(screenWidth, screenHight);
          } else {
            // return const OnBoard();
            return const LoginPage();
          }
        });
  }

  Scaffold splashView(double screenWidth, double screenHight) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Container(
            margin: EdgeInsets.only(
                left: screenWidth / 15, right: screenWidth / 15),
            child: Image.asset(
              'assets/images/Logo.png',
              height: screenHight / 2,
            ),
          )),
          const SizedBox(
            height: 30,
          ),
          const SpinKitThreeBounce(
            color: Color.fromARGB(182, 227, 34, 20),
            size: 30.0,
          ),
        ],
      ),
    );
  }
}
