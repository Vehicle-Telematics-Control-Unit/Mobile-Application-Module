
import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_car_mobile_app/controllers/tcu_controller.dart';

class CarStatus extends StatefulWidget {
  const CarStatus({super.key});

  @override
  State<CarStatus> createState() => _CarStatusState();
}

class _CarStatusState extends State<CarStatus> {
  bool isPressed = false;
  var tcuController = Get.find<TcuController>();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
        child: Container(
            height: screenHeight * 0.26,
            width: screenWidth * 0.48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[900],
              boxShadow: const [
                BoxShadow(color: Color.fromRGBO(28, 17, 17, 0.2), blurRadius: 1)
              ],
            ),
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.05),
                      child: Center(
                          child: Text('Power On Vehicle',
                              style: GoogleFonts.lato(
                                  fontSize: 14,
                                  letterSpacing: 0.01,
                                  fontStyle: FontStyle.normal,
                                  color: const Color.fromRGBO(
                                      255, 255, 255, 0.6)))),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.02),
                        child: ClayContainer(
                          color: Colors.grey.shade900,
                          borderRadius: screenHeight * 0.5,
                          depth: 7,
                          height: screenHeight * 0.09,
                          width: screenHeight * 0.09,
                          emboss: isPressed,
                          spread: 3,
                          child: IconButton(
                            icon: const Icon(
                              size: 30,
                              Icons.power_settings_new,
                              color: Color.fromRGBO(255, 255, 255, 0.6),
                            ),
                            onPressed: () {
                              tcuController.wakeUpTCU();
                              setState(() {
                                isPressed = !isPressed;
                              });
                              // Delay the resetting of isPressed to true for a certain duration
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                setState(() {
                                  isPressed = !isPressed;
                                });
                              });
                            },
                          ),
                        ),
                      ),
                    )
                  ]),
            )));
  }
}
