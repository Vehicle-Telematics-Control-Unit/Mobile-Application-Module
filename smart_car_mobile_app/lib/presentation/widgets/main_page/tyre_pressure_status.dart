import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class PressureStatus extends StatelessWidget {
  late String tyrePressure, tyreTemp;
  PressureStatus({
    Key? key,
    required this.tyrePressure,
    tyreTemp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
            text: TextSpan(
                style: GoogleFonts.oswald(
                    fontSize: 26,
                    letterSpacing: 0.01,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    color: const Color.fromRGBO(255, 255, 255, 0.8)),
                children: [
              TextSpan(text: tyrePressure),
              WidgetSpan(
                child: Transform.translate(
                  offset: const Offset(1.5, 0.0),
                  child: Text(
                    'psi',
                    style: GoogleFonts.oswald(
                        fontSize: 10,
                        letterSpacing: 0.01,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        color: const Color.fromRGBO(255, 255, 255, 0.8)),
                  ),
                ),
              )
            ])),
      ],
    );
  }
}