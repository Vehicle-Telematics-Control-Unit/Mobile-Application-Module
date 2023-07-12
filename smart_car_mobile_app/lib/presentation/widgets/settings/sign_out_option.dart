import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:smart_car_mobile_app/controllers/login_controller.dart';
import 'package:smart_car_mobile_app/controllers/logout_controller.dart';

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
  final LogoutController logoutController = Get.find<LogoutController>();
  final LoginController loginController = Get.find<LoginController>();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Icon(Icons.logout, color: Color.fromRGBO(255, 255, 255, 0.8)),
      SizedBox(
        width: widget.screenWidth * 0.02,
      ),
      InkWell(
        onTap: () {
          logoutController.logOut();

          // Get.offAll(() => const LoginPage());

          // Navigator.pushNamedAndRemoveUntil(
          //     context, '/login_page', (route) => false);
        },
        child: Obx(
          () {
            if (logoutController.isLoading.value) {
              return Shimmer(
                duration: const Duration(seconds: 5),
                interval: const Duration(seconds: 0),
                color: Colors.white, //Default value
                colorOpacity: 0, //Default value
                enabled: true, //Default value
                direction: const ShimmerDirection.fromLTRB(),
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
                ),
              );
            } else {
              return Align(
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
              );
            }
          },
        ),
      )
    ]);
  }
}



// Column buildAccountOptions(BuildContext context, String title, var screenWidth,
//     var screenHeight, IconData icon) {}
