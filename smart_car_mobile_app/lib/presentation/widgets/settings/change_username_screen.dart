import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_car_mobile_app/controllers/change_username_controller.dart';

class ChangeUsernameScreen extends StatefulWidget {
  const ChangeUsernameScreen({Key? key}) : super(key: key);

  @override
  State<ChangeUsernameScreen> createState() => _ChangeUsernameScreenState();
}

class _ChangeUsernameScreenState extends State<ChangeUsernameScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late ChangeUsernameController changeUsernameController;

  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    changeUsernameController = Get.find<ChangeUsernameController>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change username",
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
                TextFormField(
                  onSaved: (value) =>
                      changeUsernameController.usernameController.text = value!,
                  cursorColor: const Color.fromARGB(255, 145, 55, 55),
                  controller: changeUsernameController.usernameController,
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
                    hintText: "Change username",
                    errorStyle: const TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(182, 227, 34, 20),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      isButtonEnabled = value.isNotEmpty;
                    });
                  },
                ),
                SizedBox(height: screenHeight * 0.03),
                SizedBox(
                  width: screenWidth * 0.7,
                  child: ElevatedButton(
                    onPressed: isButtonEnabled
                        ? () {
                            changeUsernameController.changeUserName();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(40, 40),
                      backgroundColor: const Color.fromARGB(182, 227, 34, 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 15,
                    ),
                    child: Obx(
                      () {
                        return changeUsernameController.isLoading.value
                            ? SpinKitPulse(
                                color: Colors.grey[50],
                                size: 30,
                              )
                            : const Text('Save');
                      },
                    ),
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
