import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_car_mobile_app/controllers/authentication_controller.dart';

import '../../controllers/login_controller.dart';

// ignore: must_be_immutable
class VerificationPage extends StatefulWidget {
  VerificationPage({super.key});
  AuthenticationController authenticationController =
      Get.find<AuthenticationController>();
  final loginController = Get.find<LoginController>();
  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  late FocusNode secondPinFocusNode;
  late FocusNode thirdPinFocusNode;
  late FocusNode fourthPinFocusNode;
  final loginController = Get.find<LoginController>();
  @override
  void initState() {
    secondPinFocusNode = FocusNode();
    thirdPinFocusNode = FocusNode();
    fourthPinFocusNode = FocusNode();
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // Reset the state of the TextFields when navigating back to this screen
  //   loginController.blockOneController.clear();
  //   loginController.blockTwoController.clear();
  //   loginController.blockThreeController.clear();
  //   loginController.blockFourController.clear();
  // }

  @override
  void dispose() {
    secondPinFocusNode.dispose();
    thirdPinFocusNode.dispose();
    fourthPinFocusNode.dispose();
    super.dispose();
  }

  void nextNode(FocusNode focusNode, String value) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Column(children: [
          SizedBox(
            height: screenHeight * 0.1,
          ),
          Text('Verification code',
              style:
                  GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.bold)),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Text(
            "code has sent to",
            style: GoogleFonts.lato(
                color: Colors.grey[500], fontWeight: FontWeight.bold),
          ),
          Text(
            widget.authenticationController.getEmail(),
            style: GoogleFonts.lato(
              color: Colors.grey[500],
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.1,
          ),
          Form(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: screenHeight * 0.1,
                width: screenWidth * 0.18,
                child: TextFormField(
                  controller: loginController.blockOneController,
                  onSaved: (value) => loginController.blockOneController,
                  cursorColor: const Color.fromARGB(255, 145, 55, 55),
                  style: const TextStyle(fontSize: 24),
                  autofocus: true,
                  decoration: InputDecoration(
                      filled: true, //<-- SEE HERE
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ))),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (value) {
                    nextNode(secondPinFocusNode, value);
                  },
                ),
              ),
              SizedBox(
                height: screenHeight * 0.1,
                width: screenWidth * 0.18,
                child: TextFormField(
                  controller: loginController.blockTwoController,
                  onSaved: (value) => loginController.blockTwoController,
                  cursorColor: const Color.fromARGB(255, 145, 55, 55),
                  focusNode: secondPinFocusNode,
                  style: const TextStyle(fontSize: 24),
                  decoration: InputDecoration(
                      filled: true, //<-- SEE HERE
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ))),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (value) {
                    nextNode(thirdPinFocusNode, value);
                  },
                ),
              ),
              SizedBox(
                height: screenHeight * 0.1,
                width: screenWidth * 0.18,
                child: TextFormField(
                  controller: loginController.blockThreeController,
                  onSaved: (value) => loginController.blockThreeController,
                  cursorColor: const Color.fromARGB(255, 145, 55, 55),
                  focusNode: thirdPinFocusNode,
                  style: const TextStyle(fontSize: 24),
                  decoration: InputDecoration(
                      filled: true, //<-- SEE HERE
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ))),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (value) {
                    nextNode(fourthPinFocusNode, value);
                  },
                ),
              ),
              SizedBox(
                height: screenHeight * 0.1,
                width: screenWidth * 0.18,
                child: TextFormField(
                  controller: loginController.blockFourController,
                  onSaved: (value) => loginController.blockFourController,
                  cursorColor: const Color.fromARGB(255, 145, 55, 55),
                  focusNode: fourthPinFocusNode,
                  style: const TextStyle(fontSize: 24),
                  decoration: InputDecoration(
                      filled: true, //<-- SEE HERE
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ))),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (value) {},
                ),
              )
            ],
          )),
          SizedBox(
            height: screenHeight * 0.05,
          ),
          buildTimer(),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.loginController.verifyMail();

                  setState(() {});
                  // if it is verified then

                  // if (widget.authenticationController.isLogged.value == true) {
                  //   Get.to(() => const BottomNavBar());
                  // }
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(40, 40),
                    backgroundColor: const Color.fromARGB(182, 227, 34, 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 15),
                child: Obx(() =>
                    widget.loginController.verificationEmailIsLoading.value
                        ? SpinKitPulse(
                            color: Colors.grey[50],
                            size: 30,
                          )
                        : const Text('Verify')),
              ),
            ),
          )
        ]),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Resend code in  ',
            style: GoogleFonts.lato(
              color: Colors.grey[500],
              fontWeight: FontWeight.bold,
              fontSize: 15,
            )),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0),
          duration: const Duration(seconds: 45),
          builder: (context, value, child) => Text(
            "00:${value.toInt()}",
            style: const TextStyle(color: Color.fromARGB(182, 227, 34, 20)),
          ),
          onEnd: () {},
        )
      ],
    );
  }
}
