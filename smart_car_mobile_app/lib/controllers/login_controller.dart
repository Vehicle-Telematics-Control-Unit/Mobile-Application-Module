import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:platform_device_id/platform_device_id.dart';
import 'package:smart_car_mobile_app/controllers/authentication_controller.dart';
import 'package:smart_car_mobile_app/data/models/login-response.dart';
import 'package:smart_car_mobile_app/data/models/verify-user-command.dart';
import 'package:smart_car_mobile_app/services/web_services/user_web_services.dart';
import 'package:smart_car_mobile_app/utils/routes.dart';

import '../services/notification_services/notification_handler.dart';

class LoginController extends GetxController {
  late UserWebServices userWebServices;
  RxString username = ''.obs;
  late AuthenticationController authenticationController;
  // GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  var verificationEmailIsLoading = false.obs;
  late TextEditingController usernameController,
      passwordController,
      blockOneController,
      blockTwoController,
      blockThreeController,
      blockFourController;
  RxBool obscureText = true.obs;
  @override
  void onInit() {
    super.onInit();
    userWebServices = Get.find<UserWebServices>();
    authenticationController = Get.find<AuthenticationController>();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    blockOneController = TextEditingController();
    blockTwoController = TextEditingController();
    blockThreeController = TextEditingController();
    blockFourController = TextEditingController();
  }

  void clearVerifField() {
    blockOneController.clear();
    blockTwoController.clear();
    blockThreeController.clear();
    blockFourController.clear();
  }

  void clearField() {
    passwordController.clear();
    usernameController.clear();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    blockOneController.dispose();
    blockTwoController.dispose();
    blockThreeController.dispose();
    blockFourController.dispose();
    super.dispose();
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Enter an username/email';
    }
    return null;
  }

  Future<void> loginUser() async {
    // bool isValidate = loginFormKey.currentState!.validate();

    isLoading(true);
    try {
      final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      String? notificationToken;
      // register device on Firebase and retrive token
      notificationToken =
          await NotificationHandler.registerOnFirebase(firebaseMessaging);
      Response response = await userWebServices.userLogin(
          usernameController.text, passwordController.text, notificationToken);

      if (response.statusCode == 200) {
        // 200
        if (response.data['message'] == "otp code sent") {
          authenticationController.saveEmail(response.data['email']);
          authenticationController.saveDeviceId(response.data['deviceId']);
          Get.toNamed(AppRoutes.verificationScreen);
        } else {
          var loginResponse = LoginResponse.fromJson(response.data);
          if (loginResponse.token != null) {
            authenticationController.saveToken(loginResponse.token);
            authenticationController.saveUsername(loginResponse.username);
            username.value = loginResponse.username!;
            debugPrint('Username value in response: ${username.value}');
            authenticationController.saveEmail(loginResponse.email);
            authenticationController.saveLoginStatus(true);
            authenticationController.isLogged.value = true;
            usernameController.clear();
            passwordController.clear();
            debugPrint('saved token is ${authenticationController.getToken()}');
            Get.to(AppRoutes.bottomNavBar); // Nav Button
          }
        }
      }
    } on DioException catch (e) {
      debugPrint("status code ${e.response?.statusCode}, ${e.toString()}");
      if (e.response?.statusCode == 401) {
        debugPrint("status code ${e.response?.statusCode}");
        Get.showSnackbar(snackBar("Wrong credentials"));
      } else {
        Get.showSnackbar(snackBar("An error occured"));
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> verifyMail() async {
    verificationEmailIsLoading(true);
    try {
      final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      String? notificationToken;
      // register device on Firebase and retrive token
      notificationToken =
          await NotificationHandler.registerOnFirebase(firebaseMessaging);

      debugPrint("notificationToken is $notificationToken");
      // String? deviceId = await PlatformDeviceId.getDeviceId;
      String? otpCode = blockOneController.text +
          blockTwoController.text +
          blockThreeController.text +
          blockFourController.text;
      VerifyUserCommand verifyUserCommand = VerifyUserCommand(
          deviceId: await PlatformDeviceId.getDeviceId,
          userEmail: authenticationController.getEmail(),
          token: otpCode,
          notificationToken: notificationToken);
      debugPrint('user token is ${verifyUserCommand.token}');
      Response response = await userWebServices.verifyEmail(verifyUserCommand);
      if (response.statusCode == 200) {
        var loginResponse = LoginResponse.fromJson(response.data);
        if (loginResponse.token != null) {
          authenticationController.saveToken(loginResponse.token);
          authenticationController.saveUsername(loginResponse.username);
          username.value = loginResponse.username!;
          debugPrint('Username value in response: ${username.value}');
          authenticationController.saveEmail(loginResponse.email);
          authenticationController.saveLoginStatus(true);
          debugPrint(
              "is logged in controller:  ${authenticationController.getLoginStatus()}");
          authenticationController.isLogged.value = true;
          debugPrint('saved token is ${authenticationController.getToken()}');

          Get.toNamed(AppRoutes.bottomNavBar); // Nav Button
          blockOneController.text = '';
          blockTwoController.text = '';
          blockThreeController.text = '';
          blockFourController.text = '';
        }
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 401 ||
          e.response?.statusCode == 419) {
        debugPrint(e.toString());
        Get.showSnackbar(snackBar("Invalid Token"));
      } else {
        debugPrint(e.toString());
        Get.showSnackbar(snackBar("Something went wrong!"));
      }
    } finally {
      verificationEmailIsLoading(false);
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

  Future<void> logout() async {
    authenticationController.logOut();
    authenticationController.removeUsername();
    authenticationController.removeEmail();
    authenticationController.removeToken();
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter a password';
    }
    return null;
  }
}
