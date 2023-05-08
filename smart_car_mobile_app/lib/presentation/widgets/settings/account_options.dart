import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class AccountOptions extends StatelessWidget {
  final IconData icon;
  final String title;
  // ignore: prefer_typing_uninitialized_variables
  final  screenWidth;
   // ignore: prefer_typing_uninitialized_variables
  final  screenHeight;
  const AccountOptions(
      {Key? key,
      required this.title,
      required this.icon,
      required this.screenWidth,
      required this.screenHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: const Color.fromRGBO(255, 255, 255, 0.8)),
            SizedBox(
              width: screenWidth * 0.02,
            ),
            Text(
              title,
              style: GoogleFonts.lato(
                  fontSize: 18,
                  letterSpacing: 0.01,
                  fontStyle: FontStyle.normal,
                  color: const Color.fromRGBO(255, 255, 255, 0.8),
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Icon(
              CupertinoIcons.chevron_forward,
              color: Colors.grey.shade600,
            )
          ],
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
      ],
    );
  }
}
