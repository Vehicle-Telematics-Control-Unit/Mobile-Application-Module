import 'package:flutter/material.dart';
import 'package:smart_car_mobile_app/presentation/widgets/settings/manage_access.dart';
import 'package:smart_car_mobile_app/services/web_services/user_web_services.dart';
import 'package:smart_car_mobile_app/presentation/screens/login_page.dart';
import 'package:smart_car_mobile_app/presentation/screens/splash_screen.dart';
import 'package:smart_car_mobile_app/presentation/screens/verification_page.dart';
import 'package:smart_car_mobile_app/presentation/widgets/buttom_nav_bar.dart';

class RouteGenerator {
  late UserWebServices userWebServices;
  RouteGenerator() {
    userWebServices = UserWebServices();
  }

  Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/login_page':
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );

      case '/verification_page':
        return MaterialPageRoute(builder: (_) => VerificationPage());
      case '/bottom_nav_bar':
        return MaterialPageRoute(builder: (_) =>  BottomNavBar());
      case '/manage_access_page':
        return  MaterialPageRoute(builder: (_) =>   ManageAcessScreen());
    }
    return null;
  }
}
