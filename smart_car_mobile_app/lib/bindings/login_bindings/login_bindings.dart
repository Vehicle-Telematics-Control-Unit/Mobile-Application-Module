import 'package:get/get.dart';
import 'package:smart_car_mobile_app/controllers/authentication_controller.dart';
import 'package:smart_car_mobile_app/controllers/login_controller.dart';
import 'package:smart_car_mobile_app/controllers/logout_controller.dart';
import 'package:smart_car_mobile_app/controllers/notification_controller.dart';
import 'package:smart_car_mobile_app/controllers/share_access_controller.dart';
import 'package:smart_car_mobile_app/controllers/tcu_controller.dart';
import 'package:smart_car_mobile_app/services/web_services/user_web_services.dart';

import '../../controllers/SUMS_controller.dart';
import '../../controllers/change_username_controller.dart';
import '../../controllers/edit_password_controller.dart';
import '../../controllers/gps_controller.dart';
import '../../services/notification_services/notification_manager.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.put(AuthenticationController());
    Get.put(UserWebServices());
    Get.put(() => NotificationManager());
    Get.put(NotificationController());
    Get.put(ShareAccessController());
    Get.put(AuthenticationController());
    Get.put(TcuController());
    Get.put(EditPasswordController());
    Get.put(ChangeUsernameController());
    Get.put(SUMSController());
    Get.put(GpsController());
    Get.put(LogoutController());
  }
}
