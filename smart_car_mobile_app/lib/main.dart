import 'dart:convert';
import 'dart:io';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_car_mobile_app/bindings/login_bindings/login_bindings.dart';
import 'package:smart_car_mobile_app/presentation/screens/splash_screen.dart';
import 'package:smart_car_mobile_app/route_generator.dart';
import 'data/models/notification_model.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  // Initialize the FlutterLocalNotificationsPlugin
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // Create a new AndroidNotificationChannel
  const androidNotificationChannel = AndroidNotificationChannel(
    'default_channel_id',
    'Default Channel',
    importance: Importance.max,
  );

  // Register the AndroidNotificationChannel with the FlutterLocalNotificationsPlugin
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(androidNotificationChannel);

  debugPrint("Handling a background message: ${message.messageId}");

  await _saveNotification(message);
  // final notificationController = Get.find<NotificationController>();
  // notificationController.addNotification(
  //     message.notification?.title ?? "", message.notification?.body ?? "");

  //  addNotification(message.notification?.title ?? '', message.notification?.body ?? '');
}

Future<void> _saveNotification(RemoteMessage message) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // await prefs.reload();
  List<String> notifications =
      prefs.getStringList('backgroundNotifications') ?? <String>[];
  NotificationModel notification = NotificationModel(
    title: message.notification?.title,
    message: message.notification?.body,
    timestamp: DateTime.now(),
  );

  notifications.add(jsonEncode(notification.toJson()));
  await prefs.setStringList('backgroundNotifications', notifications);
}

Future<void> main() async {
  await GetStorage.init();

  // Initialize Firebase
  WidgetsFlutterBinding
      .ensureInitialized(); //ensures that the widgets framework is properly initialized before continuing execution.
  Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

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
class VehiclePlus extends StatefulWidget {
  VehiclePlus({super.key});

  @override
  State<VehiclePlus> createState() => _VehiclePlusState();
}

class _VehiclePlusState extends State<VehiclePlus>  {
  RouteGenerator routeGenerator = RouteGenerator();

  @override
  void initState() {
    super.initState();
    
  }

  @override
  void dispose() {
    
    super.dispose();
  }



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
