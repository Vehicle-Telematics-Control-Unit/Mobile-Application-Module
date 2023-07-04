import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:smart_car_mobile_app/controllers/authentication_controller.dart';

import '../services/web_services/user_web_services.dart';

class EditPasswordController extends GetxController {
  late TextEditingController passwordController, newPasswordController;
  late UserWebServices userWebServices;
  late AuthenticationController authenticationController;
  RxBool obscureText = true.obs;
  RxBool isLoading = false.obs;
  RxBool newPasswordObscureText = true.obs;

  @override
  void onInit() {
    super.onInit();
    passwordController = TextEditingController();
    newPasswordController = TextEditingController();
    userWebServices = Get.find<UserWebServices>();
    authenticationController = Get.find<AuthenticationController>();
  }

  @override
  void onClose() {
    passwordController.dispose();
    newPasswordController.dispose();

    super.onClose();
  }

  void clearPasswordField() {
    passwordController.clear();
    newPasswordController.clear();
  }

  @override
  void dispose() {
    clearPasswordField();
    super.dispose();
  }

  Future<void> changePassword() async {
    isLoading(true);
    try {
      String token = authenticationController.getToken();
      Response response = await userWebServices.changePassword(
          passwordController.text, newPasswordController.text, token);
      if (response != null && response.statusCode == 200) {
        Get.showSnackbar(snackBar("Password Changed!"));
        clearPasswordField();
      }
    } on DioException catch (e) {
      debugPrint("status code ${e.response?.statusCode}, ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }

  GetSnackBar snackBar(String message) {
    return GetSnackBar(
      snackStyle: SnackStyle.GROUNDED,
      message: message,
      backgroundColor: Colors.grey.shade900,
      icon: const Icon(CupertinoIcons.exclamationmark_circle,
          color: Colors.red, size: 30),
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
      borderRadius: 10,
      shouldIconPulse: true,
    );
  }
}
