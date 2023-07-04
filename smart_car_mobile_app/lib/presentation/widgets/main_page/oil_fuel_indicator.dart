import 'package:flutter/material.dart';

class OilFuelIndicator extends StatelessWidget {
  const OilFuelIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
        child: Container(
            height: screenHeight * 0.26,
            width: screenWidth * 0.48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[900],
              boxShadow: const [
                BoxShadow(
                    color: Color.fromRGBO(141, 141, 141, 0.2), blurRadius: 1)
              ],
            ),
            child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 20.0, left: 18),
                  //       child: Text(
                  //         'Fuel level',
                  //         style: GoogleFonts.lato(
                  //           fontSize: 16,
                  //           letterSpacing: 0.01,
                  //           fontStyle: FontStyle.normal,
                  //         ),
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 12.0, right: 18),
                  //       child: Text('74%',
                  //           style: GoogleFonts.oswald(
                  //               fontSize: 14,
                  //               letterSpacing: 0.01,
                  //               fontStyle: FontStyle.normal,
                  //               color: const Color.fromRGBO(255, 255, 255, 0.8))),
                  //     )
                  //   ],
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(10),
                  //   child: LinearPercentIndicator(
                  //     lineHeight: 6,
                  //     percent: 0.74,
                  //     animation: true,
                  //     animationDuration: 2500,
                  //     backgroundColor: const Color.fromARGB(255, 72, 72, 72),
                  //     barRadius: const Radius.circular(7),
                  //     maskFilter: const MaskFilter.blur(BlurStyle.solid, 4.0),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 20.0, left: 18),
                      //   child: Text(
                      //     'oil level',
                      //     style: GoogleFonts.lato(
                      //       fontSize: 16,
                      //       letterSpacing: 0.01,
                      //       fontStyle: FontStyle.normal,
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 12.0, right: 18),
                      //   child: Text('30%',
                      //       style: GoogleFonts.oswald(
                      //           fontSize: 14,
                      //           letterSpacing: 0.01,
                      //           fontStyle: FontStyle.normal,
                      //           color: const Color.fromRGBO(255, 255, 255, 0.8))),
                      // )
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(10),
                  //   child: LinearPercentIndicator(
                  //     lineHeight: 6,
                  //     percent: 0.30,
                  //     animation: true,
                  //     animationDuration: 2500,
                  //     backgroundColor: const Color.fromARGB(255, 72, 72, 72),
                  //     barRadius: const Radius.circular(7),
                  //     maskFilter: const MaskFilter.blur(BlurStyle.solid, 4.0),
                  //   ),
                  // ),
                ])));
  }
}
