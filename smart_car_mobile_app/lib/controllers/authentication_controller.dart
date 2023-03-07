import 'package:get/get.dart';
import 'package:smart_car_mobile_app/data/web_services/cache_manager_service.dart';

class AuthenticationController extends GetxController with CasheManagerService {
  final isLogged = false.obs;

  void logOut() {
    isLogged.value = false;
    removeToken();
  }

  void login(String? token) {
    // isLogged.value = true;
    saveToken(token);
  }

  void checkLoginStatus() {
    final token = getToken();
    if (token != null) {
      isLogged.value = true;
    }
  }

 
}
