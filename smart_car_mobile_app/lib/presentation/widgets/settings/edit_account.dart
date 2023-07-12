import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:smart_car_mobile_app/presentation/widgets/settings/change_password_screen.dart';

import '../../../controllers/authentication_controller.dart';
import 'account_options.dart';
import 'change_username_screen.dart';

class EditAccount extends StatefulWidget {
  EditAccount({super.key});
  var authenticationController = Get.find<AuthenticationController>();
  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Account",
          style: GoogleFonts.lato(
              fontSize: 28,
              letterSpacing: 0.01,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Container(
          width: screenWidth * 0.8,
          padding: EdgeInsets.only(
              left: screenHeight * 0.02,
              top: screenHeight * 0.03,
              right: screenHeight * 0.02),
          child: ListView(children: [
            SizedBox(
              height: screenHeight * 0.08,
            ),
            InkWell(
              onTap: () {
                Get.to(const ChangeUsernameScreen());
              },
              child: AccountOptions(
                  title: 'Username',
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  icon: Icons.person),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.0001,
                  left: screenWidth * 0.09,
                  bottom: screenHeight * 0.005),
              child: Text(
                widget.authenticationController.getUserName(),
                style: GoogleFonts.lato(
                    color: const Color.fromRGBO(255, 255, 255, 0.8),
                    fontSize: 19,
                    letterSpacing: 0.01,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            InkWell(
              onTap: () {
                Get.to(const ChangePasswordScreen(),
                    transition: Transition.downToUp,
                    duration: const Duration(milliseconds: 400));
              },
              child: AccountOptions(
                  title: 'Change password',
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  icon: Icons.lock),
            ),
            const Divider(
              thickness: 1,
            ),
          ]),
        ),
      ),
    );
  }
}
