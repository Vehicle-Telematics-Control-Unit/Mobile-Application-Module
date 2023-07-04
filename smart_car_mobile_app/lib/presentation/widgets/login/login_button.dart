import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'package:smart_car_mobile_app/controllers/login_controller.dart';

// ignore: must_be_immutable
class LoginButton extends StatefulWidget {
  LoginButton(
      {super.key,
      required this.loginController,
      required this.screenWidth,
      required this.loginFormKey});

  LoginController loginController;
  final double screenWidth;
  GlobalKey<FormState> loginFormKey;

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.screenWidth * 0.7,
      child: ElevatedButton(
        onPressed: () {
          // loginController.loginUser();
          bool isValidate = widget.loginFormKey.currentState!.validate();
          if (isValidate) {
            widget.loginController.loginUser();
          }
        },
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(40, 40),
            backgroundColor: const Color.fromARGB(182, 227, 34, 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 15),
        child: Obx(() {
          return widget.loginController.isLoading.value
              ? SpinKitPulse(
                  color: Colors.grey[50],
                  size: 30,
                )
              : const Text('Login ');
        }),
      ),
    );
  }
}
