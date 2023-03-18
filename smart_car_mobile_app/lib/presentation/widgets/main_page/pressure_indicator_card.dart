import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          Text('Tyre',
              style: GoogleFonts.lato(
                fontSize: 16,
                letterSpacing: 0.01,
                fontStyle: FontStyle.normal,
              )),
          const IconButton(
              onPressed: null,
              icon: Icon(Icons.arrow_forward,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.white70, blurRadius: 10.0)]))
        ]),
      ),
    ));
  }
}
