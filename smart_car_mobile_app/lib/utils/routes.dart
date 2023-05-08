import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:smart_car_mobile_app/presentation/screens/login_page.dart';
import 'package:smart_car_mobile_app/presentation/screens/splash_screen.dart';
import 'package:smart_car_mobile_app/presentation/screens/verification_page.dart';
import 'package:smart_car_mobile_app/presentation/widgets/buttom_nav_bar.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.splashScreen, page: () => const SplashScreen()),
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => const LoginPage(),
    ),
    GetPage(name: AppRoutes.verificationScreen, page: () => VerificationPage()),
    GetPage(name: AppRoutes.bottomNavBar, page: () => const BottomNavBar())
  ];
}

class AppRoutes {
  static const splashScreen = '/';
  static const loginScreen = '/login_page';
  static const verificationScreen = '/verification_page';
  static const bottomNavBar = '/bottom_nav_bar';
}
