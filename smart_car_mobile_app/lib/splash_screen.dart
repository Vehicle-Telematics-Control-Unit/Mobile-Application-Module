import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

import 'package:smart_car_mobile_app/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5)).then((value) {
      Navigator.of(context)
          .pushReplacement(CupertinoPageRoute(builder: (ctx) => LoginPage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Container(
            margin: EdgeInsets.only(
                left: screenWidth / 15, right: screenWidth / 15),
            child: Positioned(
              height: screenHight / 2,
              child: Image.asset(
                'assets/images/Logo.png',
                height: screenHight / 2,
              ),
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
