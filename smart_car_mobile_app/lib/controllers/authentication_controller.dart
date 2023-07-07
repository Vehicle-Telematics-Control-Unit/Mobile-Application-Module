import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smart_car_mobile_app/services/web_services/cache_manager_service.dart';

class AuthenticationController extends GetxController with CasheManagerService {
  final isLogged = false.obs;

  
  void logOut() {
    isLogged.value = false;
    saveLoginStatus(false);
    debugPrint('is loggin rom sign out ${getLoginStatus()}');
    // removeToken();
  }

  // void login(String? token) {
  //   // isLogged.value = true;
  //   saveToken(token);
  // }

  void checkLoginStatus() {
    final token = getToken();
    isLogged.value = true;
  }

  
}
