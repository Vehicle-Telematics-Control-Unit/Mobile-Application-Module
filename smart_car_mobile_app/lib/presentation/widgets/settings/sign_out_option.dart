import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';


import '../../../controllers/authentication_controller.dart';

class SignOutOption extends StatelessWidget {
  final AuthenticationController authenticationController =
      Get.find<AuthenticationController>();
  SignOutOption({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Icon(Icons.logout, color: Color.fromRGBO(255, 255, 255, 0.8)),
      SizedBox(
        width: screenWidth * 0.02,
      ),
      TextButton(
          onPressed: () {
            authenticationController.logOut();
            authenticationController.removeUsername();
            authenticationController.removeEmail();
            // Get.offAll(() => LoginPage());
            Get.offAllNamed("/login_page");
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
