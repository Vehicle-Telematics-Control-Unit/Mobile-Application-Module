import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:smart_car_mobile_app/presentation/screens/nav_screen.dart';

import '../screens/main_screen.dart';
import '../screens/notification_screen.dart';
import '../screens/settings_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  List<Widget> _buildScreens() {
    return [
      MainScreen(),
      const NavScreen(),
      const NotificationScreen(),
      const SettingsScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
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
        icon: const Icon(Icons.notifications,
            shadows: [Shadow(color: Colors.white70, blurRadius: 15.0)]),
        inactiveIcon: const Icon(Icons.notifications_outlined,
            shadows: [Shadow(color: Colors.white70, blurRadius: 15.0)]),
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
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
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
