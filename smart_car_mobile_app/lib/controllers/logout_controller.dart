import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:smart_car_mobile_app/controllers/login_controller.dart';

import '../bindings/login_bindings/login_bindings.dart';
import '../presentation/screens/login_page.dart';
import '../services/web_services/user_web_services.dart';
import 'authentication_controller.dart';

class LogoutController extends GetxController {
  late UserWebServices userWebServices;
  late AuthenticationController authenticationController;
  late LoginController loginController;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    userWebServices = Get.find<UserWebServices>();
    authenticationController = Get.find<AuthenticationController>();
    loginController = Get.find<LoginController>();
  }

  Future<void> logOut() async {
    isLoading(true);
    try {
      var authToken = authenticationController.getToken();
      Response response = await userWebServices.logout(authToken);
      if (response.statusCode == 200) {
        loginController.logout();
        loginController.usernameController.clear();
        loginController. passwordController.clear();
        Get.offAll(const LoginPage(), binding: LoginBinding());
      }
    } on DioException catch (e) {
      debugPrint("status code ${e.response?.statusCode}, ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }
}
