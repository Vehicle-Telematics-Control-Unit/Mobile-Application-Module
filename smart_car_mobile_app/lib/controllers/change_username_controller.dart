import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import '../services/web_services/user_web_services.dart';
import 'authentication_controller.dart';
import 'login_controller.dart';

class ChangeUsernameController extends GetxController {
  late TextEditingController usernameController;

  late UserWebServices userWebServices;
  late AuthenticationController authenticationController;
  late LoginController loginController;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    usernameController = TextEditingController();
    userWebServices = Get.find<UserWebServices>();
    loginController = Get.find<LoginController>();
    authenticationController = Get.find<AuthenticationController>();
  }

  @override
  void onClose() {
    usernameController.dispose();
    usernameController.clear();
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.clear();
  }

  Future<void> changeUserName() async {
    isLoading(true);
    try {
      String token = authenticationController.getToken();
      Response response =
          await userWebServices.changeUsername(usernameController.text, token);
      if (response.statusCode == 200) {
        authenticationController.saveUsername(usernameController.text);
        loginController.username.value = usernameController.text;
        usernameController.clear();
        // Update the username
        Get.showSnackbar(snackBar("Username changed!"));
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
