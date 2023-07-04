// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_car_mobile_app/presentation/widgets/main_page/battery_indicator.dart';
import 'package:smart_car_mobile_app/presentation/widgets/main_page/pressure_indicator_card.dart';
import '../../controllers/authentication_controller.dart';
import '../../controllers/login_controller.dart';
import '../widgets/main_page/car_status.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  AuthenticationController authenticationController =
      Get.find<AuthenticationController>();
  LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(
            top: screenHeight * 0.03,
          ),
          child: Obx(() {
            debugPrint('Username value: ${loginController.username.value}');
            return Text(
              'Hello, ${loginController.username.value}!',
              style: GoogleFonts.lato(
                fontSize: 28,
                letterSpacing: 0.01,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
              ),
            );
          }),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
              top: screenHeight * 0.03,
              left: screenHeight * 0.02,
              right: screenHeight * 0.02),
          child: Column(children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // const CircleAvatar(
                //   backgroundColor: Color.fromARGB(255, 192, 190, 190),
                //   radius: 25,
                // )
              ],
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Expanded(
              child:
                  ListView(physics: const BouncingScrollPhysics(), children: [
                Center(
                  child: Image.asset(
                    'assets/images/tesla2.png',
                    scale: 1.5,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Text(
                  'Car Information',
                  style: GoogleFonts.sourceSansPro(
                      fontSize: 18,
                      letterSpacing: 0.01,
                      color: const Color.fromRGBO(255, 255, 255, 0.8),
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Text(
                    'last updated today 08:30:00',
                    style: GoogleFonts.sourceSansPro(
                        fontSize: 12,
                        letterSpacing: 0.01,
                        color: const Color.fromRGBO(255, 255, 255, 0.6),
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                SizedBox(
                  height: screenHeight * 0.35,
                  child: Row(
                    children: [
                      const BatteryIndicator(),
                      SizedBox(
                        width: screenWidth * 0.03,
                      ),
                      Column(
                        children: [
                          const PressureIndicatorCard(),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          const CarStatus(),
                        ],
                      )
                    ],
                  ),
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
