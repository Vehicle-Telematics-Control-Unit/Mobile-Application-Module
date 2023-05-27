import 'package:get/get.dart';
import 'package:smart_car_mobile_app/controllers/authentication_controller.dart';
import 'package:smart_car_mobile_app/controllers/login_controller.dart';
import 'package:smart_car_mobile_app/controllers/notification_controller.dart';
import 'package:smart_car_mobile_app/services/web_services/user_web_services.dart';

import '../../services/notification_services/notification_manager.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => AuthenticationController());
    Get.lazyPut(() => UserWebServices());
    Get.lazyPut(() => NotificationManager());
    Get.put(NotificationController());
  }
}
