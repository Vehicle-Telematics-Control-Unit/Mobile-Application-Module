import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class NotificationOptions extends StatefulWidget {
  final IconData icon;
  final String title;
  final screenWidth;
  final screenHeight;
  bool value;
  NotificationOptions(
      {Key? key,
      required this.title,
      required this.icon,
      required this.screenWidth,
      required this.value,
      required this.screenHeight})
      : super(key: key);

  @override
  State<NotificationOptions> createState() => _NotificationOptionsState();
}

class _NotificationOptionsState extends State<NotificationOptions> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(widget.icon, color: const Color.fromRGBO(255, 255, 255, 0.8)),
            SizedBox(
              width: widget.screenWidth * 0.02,
            ),
            Text(
              widget.title,
              style: GoogleFonts.lato(
                  fontSize: 18,
                  letterSpacing: 0.01,
                  fontStyle: FontStyle.normal,
                  color: const Color.fromRGBO(255, 255, 255, 0.8),
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Transform.scale(
              scale: 0.8,
              child: Switch(
                activeColor: Colors.red,
                onChanged: (bool newVal) {
                  onChangeMethod(newVal);
                },
                value: widget.value,
              ),
            )
          ],
        ),
        SizedBox(
          height: widget.screenHeight * 0.02,
        ),
      ],
    );
  }

  void onChangeMethod(bool newVal) {
    setState(() {
      widget.value = newVal;
    });
  }
}
