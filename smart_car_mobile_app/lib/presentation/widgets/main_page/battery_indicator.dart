import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BatteryIndicator extends StatelessWidget {
  const BatteryIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: double.infinity,
        // height: 250,
        width: 156,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[900],
          boxShadow: const [
            BoxShadow(color: Color.fromRGBO(141, 141, 141, 0.2), blurRadius: 1)
          ],
        ),

        // ignore: avoid_unnecessary_containers
        child: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, left: 18),
                  child: Text(
                    'Battery',
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      letterSpacing: 0.01,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 23),
              child: Center(
                child: CircularPercentIndicator(
                  radius: 35,
                  percent: 0.65,
                  animation: true,
                  animationDuration: 2500,
                  circularStrokeCap: CircularStrokeCap.round,
                  backgroundColor: const Color.fromARGB(255, 72, 72, 72),
                  lineWidth: 7,
                  maskFilter: const MaskFilter.blur(BlurStyle.solid, 4.0),
                  center: Center(
                    child: Text('65%',
                        style: GoogleFonts.oswald(
                            fontSize: 26,
                            letterSpacing: 0.01,
                            fontStyle: FontStyle.normal,
                            color: const Color.fromRGBO(255, 255, 255, 0.8))),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Divider(
                indent: 10,
                thickness: 1.5,
                endIndent: 10,
                color: Color.fromRGBO(252, 250, 250, 0.098),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                  child: Text('Remaining Battery',
                      style: GoogleFonts.lato(
                          fontSize: 12,
                          letterSpacing: 0.01,
                          fontStyle: FontStyle.normal,
                          color: const Color.fromRGBO(255, 255, 255, 0.6)))),
            ),
            Center(
                child: Text('Range',
                    style: GoogleFonts.lato(
                        fontSize: 12,
                        letterSpacing: 0.01,
                        fontStyle: FontStyle.normal,
                        color: const Color.fromRGBO(255, 255, 255, 0.6)))),
            Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(
                  child: RichText(
                      text: TextSpan(
                          style: GoogleFonts.oswald(
                              fontSize: 30,
                              letterSpacing: 0.01,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              color: const Color.fromRGBO(255, 255, 255, 0.8)),
                          children: [
                        const TextSpan(text: '354'),
                        WidgetSpan(
                          child: Transform.translate(
                            offset: const Offset(1.5, 0.0),
                            child: Text(
                              'km',
                              style: GoogleFonts.oswald(
                                  fontSize: 10,
                                  letterSpacing: 0.01,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  color:
                                      const Color.fromRGBO(255, 255, 255, 0.8)),
                            ),
                          ),
                        )
                      ])),
                ))
          ]),
        ),
        // child: Column(children: const [
        //   // Image.asset(icon),
        //   // Text(
        //   //   title,
        //   // )
        // ]),
      ),
    );
  }
}
