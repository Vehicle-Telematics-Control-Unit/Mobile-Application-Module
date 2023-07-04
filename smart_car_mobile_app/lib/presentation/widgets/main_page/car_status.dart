import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: screenHeight * 0.02, left: screenHeight * 0.02),
                      child: Text(
                        'Connection status',
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          letterSpacing: 0.01,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.02, right: screenHeight * 0.02),
                    child: const Icon(
                      CupertinoIcons.wifi_slash,
                      color: Color.fromRGBO(255, 255, 255, 0.6),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.016),
                child: const Divider(
                  indent: 10,
                  thickness: 1.5,
                  endIndent: 10,
                  color: Color.fromRGBO(252, 250, 250, 0.098),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.01),
                child: Center(
                    child: Text('Power On Vehicle',
                        style: GoogleFonts.lato(
                            fontSize: 14,
                            letterSpacing: 0.01,
                            fontStyle: FontStyle.normal,
                            color: const Color.fromRGBO(255, 255, 255, 0.6)))),
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
                        Future.delayed(const Duration(milliseconds: 500), () {
                          setState(() {
                            isPressed = !isPressed;
                          });
                        });
                      },
                    ),
                  ),
                ),
              )
            ])));
  }
}
