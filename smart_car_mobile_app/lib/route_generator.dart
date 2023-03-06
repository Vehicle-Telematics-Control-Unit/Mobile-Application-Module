import 'package:flutter/material.dart';
import 'package:smart_car_mobile_app/data/web_services/user_web_services.dart';
import 'package:smart_car_mobile_app/presentation/screens/login_page.dart';
import 'package:smart_car_mobile_app/presentation/screens/splash_screen.dart';
import 'package:smart_car_mobile_app/presentation/screens/verification_page.dart';

class RouteGenerator {
  late UserWebServices userWebServices;
  RouteGenerator() {
    userWebServices = UserWebServices();
  }

  Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/login_page':
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );

      case '/verification_page':
        return MaterialPageRoute(builder: (_) => VerificationPage());
    }
    return null;
  }
}
