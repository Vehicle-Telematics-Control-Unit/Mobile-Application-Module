
import 'package:flutter/material.dart';

class LogoArea extends StatelessWidget {
  const LogoArea({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topCenter,
      child: Container(
        height: screenHeight / 2,
        margin:
            EdgeInsets.only(left: screenWidth / 15, right: screenWidth / 15),
        child: Image.asset(
          'assets/images/Logo.png',
        ),
      ),
    );
  }
}
