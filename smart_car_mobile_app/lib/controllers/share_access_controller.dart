import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:get/get.dart' hide Response;
import '../presentation/widgets/settings/manage_access.dart';
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
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
