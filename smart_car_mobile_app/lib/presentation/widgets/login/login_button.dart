import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'package:smart_car_mobile_app/controllers/login_controller.dart';

// ignore: must_be_immutable
class LoginButton extends StatelessWidget {
  LoginButton({
    super.key,
    required this.loginController,
    required this.screenWidth,
  });

  LoginController loginController;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth * 0.7,
      child: ElevatedButton(
        onPressed: () {
          loginController.loginUser();
          // setState(() {
          //   if (_formkey.currentState!.validate()) {
          //     Navigator.of(context).pushNamed('/verification_page');
          //   }
          // });
        },
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(40, 40),
            backgroundColor: const Color.fromARGB(182, 227, 34, 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 15),
        child: Obx(() => loginController.isLoading.value
            ? SpinKitPulse(
                color: Colors.grey[50],
                size: 30,
              )
            : const Text('Log In ')),
      ),
    );
  }
}
