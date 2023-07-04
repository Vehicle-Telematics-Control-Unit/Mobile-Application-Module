import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'package:smart_car_mobile_app/controllers/notification_controller.dart';

import 'package:smart_car_mobile_app/presentation/screens/nav_screen.dart';
import 'package:badges/badges.dart' as badges;

import '../screens/main_screen.dart';
import '../screens/notification_screen.dart';
import '../screens/settings_screen.dart';

class BottomNavBar extends StatefulWidget {
  NotificationController? notificationController;

  BottomNavBar({
    super.key,
    this.notificationController,
  });

  int count = 1;
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  static int semaphore = 0;
  List<Widget> _buildScreens() {
    return [
      MainScreen(),
      const NavScreen(),
      const NotificationScreen(),
      SettingsScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    var notificationController = Get.find<NotificationController>();
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_sharp,
            shadows: [Shadow(color: Colors.white70, blurRadius: 15.0)]),
        inactiveIcon: const Icon(Icons.home_outlined,
            shadows: [Shadow(color: Colors.white70, blurRadius: 15.0)]),
        // title: ("Home"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.white,
      ),
      PersistentBottomNavBarItem(
        // title: ("Navigation"),
        icon: const Icon(Icons.navigation_sharp,
            shadows: [Shadow(color: Colors.white70, blurRadius: 15.0)]),
        inactiveIcon: const Icon(Icons.navigation_outlined,
            shadows: [Shadow(color: Colors.white70, blurRadius: 15.0)]),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.white,
      ),
      PersistentBottomNavBarItem(
        // title: ("Notifications"),
        icon: Obx(
          () {
            notificationController.markAllAsRead();
            return const Icon(Icons.notifications,
                shadows: [Shadow(color: Colors.white70, blurRadius: 15.0)]);
          },
        ),
        inactiveIcon: Obx(() {
          debugPrint(
              'unread messagres are :${notificationController.unreadCount.value.toString()}');
          return notificationController.unreadCount.value > 0
              ? badges.Badge(
                  stackFit: StackFit.passthrough,
                  badgeContent:
                      Text(notificationController.unreadCount.value.toString()),
                  child: const Icon(Icons.notifications_outlined, shadows: [
                    Shadow(color: Colors.white70, blurRadius: 15.0)
                  ]))
              : const Icon(Icons.notifications_outlined,
                  shadows: [Shadow(color: Colors.white70, blurRadius: 15.0)]);
        }),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.white,
      ),
      PersistentBottomNavBarItem(
        // title: ("Settings"),

        icon: const Icon(Icons.settings_sharp,
            shadows: [Shadow(color: Colors.white70, blurRadius: 15.0)]),
        inactiveIcon: const Icon(Icons.settings_outlined,
            shadows: [Shadow(color: Colors.white70, blurRadius: 15.0)]),
        // inactiveIcon: const Icon(Icons.settings_outlined),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.white,
      ),
    ];
  }

  // @pragma('vm:entry-point')
  // Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //   // Initialize the FlutterLocalNotificationsPlugin
  //   final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //   // Create a new AndroidNotificationChannel
  //   const androidNotificationChannel = AndroidNotificationChannel(
  //     'default_channel_id',
  //     'Default Channel',
  //     importance: Importance.max,
  //   );

  //   // Register the AndroidNotificationChannel with the FlutterLocalNotificationsPlugin
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.createNotificationChannel(androidNotificationChannel);

  //   debugPrint("Handling a background message: ${message.messageId}");

  //   setState(() {
  //     NotificationManager().notifications.insert(0, message);
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
    debugPrint("is deleted");
  }

  @override
  void initState() {
    super.initState();
    debugPrint("all herrrre");

    // final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    // NotificationHandler.registerOnFirebase(firebaseMessaging);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (semaphore != 0) {
        return;
      }
      semaphore = 1;
      Future.delayed(const Duration(seconds: 1)).then((_) => semaphore = 0);
      // NotificationManager().notifications.insert(0, message);
      debugPrint("list to notifications");
      final notificationController = Get.find<NotificationController>();
      notificationController.addNotification(
          message.notification?.title ?? "", message.notification?.body ?? "");

      debugPrint(
          ' from foreground Title: ${message.notification?.title ?? ""}, Message: ${message.notification?.body ?? ""}');
    });
  }

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller;

    controller = PersistentTabController(initialIndex: 0);

    return PersistentTabView(
      context,
      controller: controller,
      screens: _buildScreens(),
      items: _navBarsItems(),

      confineInSafeArea: true,
      backgroundColor: CupertinoColors.darkBackgroundGray,
      navBarHeight: 70,
      // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.

      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6,

      // Choose the nav bar style with this property.
    );
  }
}
