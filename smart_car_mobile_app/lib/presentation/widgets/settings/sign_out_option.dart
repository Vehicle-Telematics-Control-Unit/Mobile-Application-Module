import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:smart_car_mobile_app/controllers/login_controller.dart';
import 'package:smart_car_mobile_app/presentation/screens/login_page.dart';

import '../../../controllers/authentication_controller.dart';

class SignOutOption extends StatefulWidget {
  const SignOutOption({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  State<SignOutOption> createState() => _SignOutOptionState();
}

class _SignOutOptionState extends State<SignOutOption> {
  final AuthenticationController authenticationController =
      Get.find<AuthenticationController>();
  final LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Icon(Icons.logout, color: Color.fromRGBO(255, 255, 255, 0.8)),
      SizedBox(
        width: widget.screenWidth * 0.02,
      ),
      TextButton(
          onPressed: () {
            loginController.logout();
            Get.offAll(() =>   const LoginPage());
            loginController.usernameController.text = '';
            loginController.passwordController.text = '';
            setState(() {});
            // Get.offAll(() => LoginPage());
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>   const LoginPage()),
            );
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Sign Out",
              style: GoogleFonts.lato(
                  fontSize: 18,
                  letterSpacing: 0.01,
                  fontStyle: FontStyle.normal,
                  color: const Color.fromRGBO(255, 255, 255, 0.8),
                  fontWeight: FontWeight.bold),
            ),
          )),
    ]);
  }
}



// Column buildAccountOptions(BuildContext context, String title, var screenWidth,
//     var screenHeight, IconData icon) {}
