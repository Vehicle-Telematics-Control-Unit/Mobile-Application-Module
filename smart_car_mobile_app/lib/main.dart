import 'dart:io';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_car_mobile_app/bindings/login_bindings/login_bindings.dart';
import 'package:smart_car_mobile_app/presentation/screens/splash_screen.dart';
import 'package:smart_car_mobile_app/route_generator.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(DevicePreview(
    enabled: true,
    builder: (context) => VehiclePlus(),
  ));
  HttpOverrides.global = MyHttpOverrides();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

// ignore: must_be_immutable
class VehiclePlus extends StatelessWidget {
  VehiclePlus({super.key});
  RouteGenerator routeGenerator = RouteGenerator();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //theme: FlexThemeData.light(scheme: FlexScheme.hippieBlue),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.hippieBlue),
      themeMode: ThemeMode.dark,
      home: const SplashScreen(),
      initialBinding: LoginBinding(),
      // initialRoute: '/',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: routeGenerator.generateRoute,
    );
  }
}
