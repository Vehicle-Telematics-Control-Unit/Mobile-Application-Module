import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';


class AccessDenied extends StatelessWidget {
  const AccessDenied({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.2,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Sharing Access Prohibited: You do not have permission to share',
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.008,
            ),
            Center(
                child: ColorFiltered(
              colorFilter:
                  ColorFilter.mode(Colors.red.shade200, BlendMode.modulate),
              child: Lottie.asset('assets/13865-sign-for-error-flat-style.json',
                  height: 175, width: 175, repeat: false),
            )),
          ],
        ),
      ),
    );
  }
}
