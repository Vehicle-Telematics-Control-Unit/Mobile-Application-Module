import 'package:flutter/material.dart';
import 'package:smart_car_mobile_app/verification_page.dart';

class LoginPage extends StatefulWidget {
  final TextEditingController controller =
      TextEditingController(); // to control text field
  LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var obscureText = true;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Container(
                    height: screenHeight / 2,
                    margin: EdgeInsets.only(
                        left: screenWidth / 15, right: screenWidth / 15),
                    child: Image.asset(
                      'assets/images/Logo.png',
                    ),
                  ),
                ),

                SizedBox(
                  height: screenHeight * 0.001,
                ),
                // email text field
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextField(
                    cursorColor: Color.fromARGB(255, 145, 55, 55),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        filled: true, //<-- SEE HERE
                        fillColor: Colors.grey[900],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        hintText: "Email",
                        prefixIcon:
                            const Icon(Icons.mail, color: Colors.white)),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                // password text field
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextField(
                    cursorColor: Color.fromARGB(255, 145, 55, 55),
                    controller: widget.controller,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                        filled: true, //<-- SEE HERE
                        fillColor: Colors.grey[900],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        hintText: "Password",
                        prefixIcon: const Icon(Icons.lock, color: Colors.white),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          icon: obscureText
                              ? const Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                )
                              // ignore: dead_code
                              : const Icon(
                                  Icons.visibility,
                                  color: Colors.white,
                                ),
                        )),
                  ),
                ),

                // login button
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                SizedBox(
                  width: screenWidth * 0.7,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VerificationPage()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(182, 227, 34, 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 15),
                    child: const Text('Log In '),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
