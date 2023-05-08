import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smart_car_mobile_app/controllers/login_controller.dart';

import '../widgets/login/email_field.dart';
import '../widgets/login/login_button.dart';
import '../widgets/login/logo_area.dart';
import '../widgets/login/password_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginController = Get.put(LoginController());
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final RxBool btnActive = false.obs;

  @override
  void dispose() {
    super.dispose();
  }

 

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
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: loginFormKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      LogoArea(
                          screenHeight: screenHeight, screenWidth: screenWidth),
                      SizedBox(
                        height: screenHeight * 0.001,
                      ),
                      // email text field
                      EmailField(loginController: loginController),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      // password text field
                      PasswordField(loginController: loginController),
                      // login button
                      SizedBox(
                        height: screenHeight * 0.04,
                      ),
                      LoginButton(
                          loginController: loginController,
                          screenWidth: screenWidth,
                          loginFormKey: loginFormKey),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
