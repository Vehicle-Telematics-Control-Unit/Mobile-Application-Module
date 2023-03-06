import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_car_mobile_app/controllers/authentication_controller.dart';
import 'package:smart_car_mobile_app/data/models/login-response.dart';
import 'package:smart_car_mobile_app/data/web_services/user_web_services.dart';

import 'package:smart_car_mobile_app/utils/routes.dart';

class LoginController extends GetxController {
  late final UserWebServices userWebServices;
  late final AuthenticationController authenticationController;
  final loginFormKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  late TextEditingController usernameController, passwordController;
  RxBool obscureText = true.obs;
  @override
  void onInit() {
    super.onInit();
    userWebServices = Get.put(UserWebServices());
    authenticationController = Get.put(AuthenticationController());
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Enter an username/email';
    }
    return null;
  }

  Future<void> loginUser() async {
    bool isValidate = loginFormKey.currentState!.validate();
    if (isValidate) {
      isLoading(true);
      try {
        LoginResponse loginResponse = await userWebServices.userLogin(
            usernameController.text, passwordController.text);
        if (loginResponse.token != null) {
          authenticationController.login(loginResponse.token);
          authenticationController.saveUsername(loginResponse.username);
          authenticationController.saveEmail(loginResponse.email);
          debugPrint('saved token is ${authenticationController.getToken()}');
          // debugPrint('saved email is ${loginResponse.email}');
          Get.toNamed(AppRoutes.verificationScreen);
        } else {
          Get.snackbar('login', 'problem in login');
        }
      } catch (e) {
        debugPrint(e.toString());
      } finally {
        isLoading(false);
      }
    }
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter a password';
    }
    return null;
  }
}
