import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:smart_car_mobile_app/controllers/authentication_controller.dart';
import 'package:smart_car_mobile_app/presentation/screens/main_screen.dart';
import 'package:smart_car_mobile_app/presentation/screens/login_page.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationController authenticationController =
        Get.find<AuthenticationController>();
    return Obx(() => authenticationController.isLogged.value
        ? const MainScreen()
        : LoginPage());
  }
}
