import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_car_mobile_app/controllers/edit_password_controller.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late EditPasswordController editPasswordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isPasswordValid = false;
  @override
  void dispose() {
    // editPasswordController
    //     .clearPasswordField();
    // editPasswordController.dispose();
    // Clear the password field when disposing of the screen
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    editPasswordController = Get.find<EditPasswordController>();
  }

  void _validateForm() {
    if (_formKey.currentState?.validate() ?? false) {
      editPasswordController.changePassword();
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Password",
          style: GoogleFonts.lato(
            fontSize: 28,
            letterSpacing: 0.01,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: screenWidth * 0.8,
          padding: EdgeInsets.only(
            left: screenHeight * 0.02,
            top: screenHeight * 0.03,
            right: screenHeight * 0.02,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.08),
                Obx(
                  () => TextFormField(
                    onSaved: (value) =>
                        editPasswordController.passwordController,
                    cursorColor: const Color.fromARGB(255, 145, 55, 55),
                    controller: editPasswordController.passwordController,
                    obscureText: editPasswordController.obscureText.value,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      hintText: "Current password",
                      errorStyle: const TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(182, 227, 34, 20),
                      ),
                      suffixIcon: Obx(() => IconButton(
                            onPressed: () {
                              editPasswordController.obscureText.value =
                                  !editPasswordController.obscureText.value;
                            },
                            icon: editPasswordController.obscureText.value
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: Colors.grey,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: Colors.white,
                                  ),
                          )),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your current password';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Obx(
                  () => TextFormField(
                    onSaved: (value) =>
                        editPasswordController.newPasswordController,
                    cursorColor: const Color.fromARGB(255, 145, 55, 55),
                    controller: editPasswordController.newPasswordController,
                    obscureText:
                        editPasswordController.newPasswordObscureText.value,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      hintText: "New password",
                      errorStyle: const TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(182, 227, 34, 20),
                      ),
                      suffixIcon: Obx(() => IconButton(
                            onPressed: () {
                              editPasswordController
                                      .newPasswordObscureText.value =
                                  !editPasswordController
                                      .newPasswordObscureText.value;
                            },
                            icon: editPasswordController
                                    .newPasswordObscureText.value
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: Colors.grey,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: Colors.white,
                                  ),
                          )),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a new password';
                      }
                      return null;
                    },
                  ),
                ),
                FlutterPwValidator(
                  width: 400,
                  height: 200,
                  minLength: 6,
                  uppercaseCharCount: 1,
                  lowercaseCharCount: 1,
                  numericCharCount: 1,
                  specialCharCount: 1,
                  onSuccess: () {
                    setState(() {
                      isPasswordValid = true;
                    });
                  },
                  onFail: () {
                    setState(() {
                      isPasswordValid = false;
                    });
                  },
                  controller: editPasswordController.newPasswordController,
                ),
                SizedBox(height: screenHeight * 0.03),
                SizedBox(
                  width: screenWidth * 0.7,
                  child: ElevatedButton(
                    onPressed: isPasswordValid ? _validateForm : null,
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(40, 40),
                      backgroundColor: const Color.fromARGB(182, 227, 34, 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 15,
                    ),
                    child: Obx(() {
                      return editPasswordController.isLoading.value
                          ? SpinKitPulse(
                              color: Colors.grey[50],
                              size: 30,
                            )
                          : const Text('Save');
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
