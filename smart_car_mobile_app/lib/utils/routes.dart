import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:smart_car_mobile_app/presentation/screens/login_page.dart';
import 'package:smart_car_mobile_app/presentation/screens/splash_screen.dart';
import 'package:smart_car_mobile_app/presentation/screens/verification_page.dart';



class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.splashScreen, page: () => SplashScreen()),
    GetPage(
        name: AppRoutes.loginScreen,
        page: () => LoginPage(),
       ),
    GetPage(
        name: AppRoutes.verificationScreen,
        page: () =>  VerificationPage())
  ];
}

class AppRoutes {
  static const splashScreen = '/';
  static const loginScreen = '/login_page';
  static const verificationScreen = '/verification_page';
}
