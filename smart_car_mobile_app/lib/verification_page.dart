import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  late FocusNode secondPinFocusNode;
  late FocusNode thirdPinFocusNode;
  late FocusNode fourthPinFocusNode;

  @override
  void initState() {
    secondPinFocusNode = FocusNode();
    thirdPinFocusNode = FocusNode();
    fourthPinFocusNode = FocusNode();
    super.initState();
  }

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
    
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Column(children: [
          const SizedBox(
            height: 70,
          ),
          Text('Verification code',
              style:
                  GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 20,
          ),
          Text(
            "code has sent to",
            style: GoogleFonts.lato(
                color: Colors.grey[500], fontWeight: FontWeight.bold),
          ),
          Text(
            "nada.eletr@gmail.com",
            style: GoogleFonts.lato(
              color: Colors.grey[500],
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Form(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 68,
                width: 64,
                child: TextFormField(
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
                height: 68,
                width: 64,
                child: TextFormField(
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
                height: 68,
                width: 64,
                child: TextFormField(
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
                height: 68,
                width: 64,
                child: TextFormField(
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
          const SizedBox(
            height: 40,
          ),
          buildTimer(),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(40, 40),
                    backgroundColor: const Color.fromARGB(182, 227, 34, 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 15),
                child: Text(' Verify ',
                    style: GoogleFonts.lato(
                        fontSize: 15, fontWeight: FontWeight.bold)),
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
          duration: const Duration(seconds: 30),
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
