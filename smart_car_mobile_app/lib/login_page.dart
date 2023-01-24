// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

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
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        hintText: "Email",
                        prefixIcon: Icon(Icons.mail, color: Colors.white)),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                // password text field
                Padding(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: TextField(
                    controller: widget.controller,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock, color: Colors.white),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          icon: obscureText
                              ? Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                )
                              // ignore: dead_code
                              : Icon(
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
                Container(
                  width: screenWidth * 0.7,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(182, 227, 34, 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 15),
                    child: Text('Log In '),
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
