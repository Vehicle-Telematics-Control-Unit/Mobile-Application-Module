import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:smart_car_mobile_app/presentation/screens/login_page.dart';
import 'package:smart_car_mobile_app/presentation/screens/qr_scanner_screen.dart';
import 'package:smart_car_mobile_app/presentation/screens/splash_screen.dart';
import 'package:smart_car_mobile_app/presentation/screens/verification_page.dart';
import 'package:smart_car_mobile_app/presentation/widgets/buttom_nav_bar.dart';
import 'package:smart_car_mobile_app/presentation/widgets/settings/access_denied.dart';
import 'package:smart_car_mobile_app/presentation/widgets/settings/manage_access.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.splashScreen, page: () => const SplashScreen()),
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => const LoginPage(),
    ),
    GetPage(name: AppRoutes.verificationScreen, page: () => VerificationPage()),
    GetPage(name: AppRoutes.bottomNavBar, page: () => BottomNavBar()),
    GetPage(name: AppRoutes.manageAcessScreen, page: () => ManageAcessScreen()),
    GetPage(name: AppRoutes.accessDenied, page: () => const AccessDenied()),
    GetPage(
        name: AppRoutes.qrScannerScreen, page: () =>  QrScannerScreen()),
  ];
}

class AppRoutes {
  static const splashScreen = '/';
  static const loginScreen = '/login_page';
  static const verificationScreen = '/verification_page';
  static const bottomNavBar = '/bottom_nav_bar';
  static const accessDenied = '/access_denied';
  static const manageAcessScreen = '/manage_access_page';
  static const qrScannerScreen = '/qr_scanner_screen';
}
