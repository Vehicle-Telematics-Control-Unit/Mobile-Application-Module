import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:smart_car_mobile_app/presentation/screens/tyre_pressure_screen.dart';

class PressureIndicatorCard extends StatelessWidget {
  const PressureIndicatorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
      // height: double.infinity,
      height: 60,
      width: 156,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[900],
        boxShadow: const [
          BoxShadow(color: Color.fromRGBO(141, 141, 141, 0.2), blurRadius: 1)
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 18),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: Text('Tire & Doors',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  letterSpacing: 0.01,
                  fontStyle: FontStyle.normal,
                )),
          ),
          IconButton(
              onPressed: () {
                Get.to(
                  const TyrePressureScreen(),
                  transition: Transition.downToUp,
                  duration: const Duration(milliseconds: 400),
                );
              },
              icon: const Icon(Icons.arrow_forward,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.white70, blurRadius: 10.0)]))
        ]),
      ),
    ));
  }
}
