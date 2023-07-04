import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/web_services/user_web_services.dart';
import 'authentication_controller.dart';

class TcuController extends GetxController {
  late UserWebServices userWebServices;
  late AuthenticationController authenticationController;
  @override
  void onInit() {
    userWebServices = Get.find<UserWebServices>();
    authenticationController = Get.find<AuthenticationController>();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<dynamic> wakeUpTCU() async {
    var authToken = authenticationController.getToken();
    bool isAllowed = await userWebServices.wakeUpTCU(authToken);
    if(isAllowed==true){
      Get.showSnackbar(snackBar("Vehicle Powered On"));
    }else{
       Get.showSnackbar(snackBar("You don't have access to power on vehicle!"));
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
