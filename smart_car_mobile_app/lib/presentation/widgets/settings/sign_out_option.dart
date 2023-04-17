import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_car_mobile_app/presentation/widgets/settings/notifications_options.dart';

class SignOutOption extends StatelessWidget {
  const SignOutOption({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Icon(Icons.logout, color: Color.fromRGBO(255, 255, 255, 0.8)),
      SizedBox(
        width: screenWidth * 0.02,
      ),
      TextButton(
          onPressed: () {},
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Sign Out",
              style: GoogleFonts.lato(
                  fontSize: 18,
                  letterSpacing: 0.01,
                  fontStyle: FontStyle.normal,
                  color: const Color.fromRGBO(255, 255, 255, 0.8),
                  fontWeight: FontWeight.bold),
            ),
          )),
    ]);
  }
}



// Column buildAccountOptions(BuildContext context, String title, var screenWidth,
//     var screenHeight, IconData icon) {}
