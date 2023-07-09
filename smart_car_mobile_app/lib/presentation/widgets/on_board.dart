import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_car_mobile_app/controllers/authentication_controller.dart';

import 'package:smart_car_mobile_app/presentation/screens/login_page.dart';
import 'package:smart_car_mobile_app/presentation/widgets/buttom_nav_bar.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("iam on board");
    AuthenticationController authenticationController =
        Get.find<AuthenticationController>();
    var isLoggedIn = authenticationController.getLoginStatus();
    debugPrint("is logged:  $isLoggedIn");
    if (isLoggedIn == true) {
      return BottomNavBar();
    } else {
      return const LoginPage();
    }
  }
}
