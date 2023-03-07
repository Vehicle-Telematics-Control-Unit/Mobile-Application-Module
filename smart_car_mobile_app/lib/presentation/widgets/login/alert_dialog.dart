import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:google_fonts/google_fonts.dart';

class LoginDialogAlert extends StatelessWidget {
  const LoginDialogAlert({
    super.key,
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 44, 44, 44),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      content: SizedBox(
          height: 20,
          width: 40,
          // padding: const EdgeInsets.all(4.0),
          child: Center(
              child: Text(
            errorMessage,
            style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold),
          ))),
      actions: [
        const Divider(
          color: Colors.grey,
          thickness: 0.2,
          indent: 0,
          endIndent: 0,
          height: 0.3,
        ),
        TextButton(
          style: TextButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 198, 54, 44)),
          onPressed: () => Get.back(),
          child: Center(
              child: Text(
            "OK",
            style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
          )),
        )
      ],
      shadowColor: Colors.white10,
    );
  }
}
