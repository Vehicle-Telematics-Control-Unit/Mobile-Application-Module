// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_car_mobile_app/presentation/widgets/main_page/battery_indicator.dart';
import 'package:smart_car_mobile_app/presentation/widgets/main_page/oil_fuel_indicator.dart';
import 'package:smart_car_mobile_app/presentation/widgets/main_page/pressure_indicator_card.dart';
import '../../controllers/authentication_controller.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  AuthenticationController authenticationController =
      Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
              top: screenHeight * 0.08,
              left: screenHeight * 0.02,
              right: screenHeight * 0.02),
          child: Column(children: [
            SizedBox(
              height: screenHeight * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hello, ${authenticationController.getUserName()} !',
                  style: GoogleFonts.lato(
                      fontSize: 25,
                      letterSpacing: 0.01,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold),
                ),
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
                          const OilFuelIndicator(),
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
