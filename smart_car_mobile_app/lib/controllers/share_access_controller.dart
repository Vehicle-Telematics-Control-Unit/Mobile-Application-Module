import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/src/mobile_scanner_controller.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:get/get.dart' hide Response;
import 'package:smart_car_mobile_app/data/models/submit-access-model.dart';
import 'package:smart_car_mobile_app/presentation/widgets/buttom_nav_bar.dart';
import 'package:smart_car_mobile_app/presentation/widgets/settings/access_denied.dart';
import '../data/models/login-response.dart';
import '../presentation/widgets/settings/manage_access.dart';
import '../services/notification_services/notification_handler.dart';
import '../services/web_services/user_web_services.dart';

import '../utils/routes.dart';
import 'authentication_controller.dart';

class ShareAccessController extends GetxController {
  late UserWebServices userWebServices;
  late AuthenticationController authenticationController =
      Get.find<AuthenticationController>();
  RxString? token = ''.obs;
  RxInt? tcuId = 0.obs;
  var isLoading = false.obs;
  var submitAccessIsLoading = false.obs;

  @override
  void onInit() {
    userWebServices = Get.find<UserWebServices>();
    super.onInit();
  }

  Future<void> requestAccess() async {
    isLoading(true);
    try {
      String? autToken = authenticationController.getToken();

      String? deviceId = await PlatformDeviceId.getDeviceId;
      Response response =
          await userWebServices.requestAccess(autToken, deviceId);

      if (response != null && response.statusCode == 200) {
        token?.value = response.data['token'];
        tcuId?.value = response.data['tcuId'];
        debugPrint("token is ${token?.value} and tcuid is ${tcuId?.value}");
        Get.to(
          () => ManageAcessScreen(),
          transition: Transition.downToUp,
          duration: const Duration(milliseconds: 400),
        ); // manage access screen
      } else {
        Get.to(
          () => const AccessDenied(),
          transition: Transition.downToUp,
          duration: const Duration(milliseconds: 400),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<bool> submitRequestAccess(
    String token,
    String tcuId,
  
  ) async {
    submitAccessIsLoading(true);
    late String? deviceId;

    try {
      deviceId = await PlatformDeviceId.getDeviceId;
      debugPrint("device id is $deviceId");
    } catch (e) {
      debugPrint("error in ${e.toString()}");
    }
    try {
      final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      String? notificationToken;
      // register device on Firebase and retrive token
      notificationToken =
          await NotificationHandler.registerOnFirebase(firebaseMessaging);

      Response response = await userWebServices.submitRequestAccess(
          SubmitAccessModel(
              token: token,
              deviceId: deviceId,
              tcuId: tcuId,
              notificationToken: notificationToken));
      if (response != null && response.statusCode == 200) {
        
        debugPrint('finalllyyyyyyyy');
        var loginResponse = LoginResponse.fromJson(response.data);
        if (loginResponse.token != null) {
          authenticationController.saveToken(loginResponse.token);
          authenticationController.saveUsername(loginResponse.username);
          authenticationController.saveEmail(loginResponse.email);
          authenticationController.isLogged.value = true;
          debugPrint('saved token is ${authenticationController.getToken()}');
          debugPrint('not token is ${notificationToken}');
          Get.offAll(BottomNavBar()); // Nav Button
          return true;
        }
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      submitAccessIsLoading(false);
    }
  }
}
