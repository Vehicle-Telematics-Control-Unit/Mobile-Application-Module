// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/notification_controller.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with WidgetsBindingObserver {
  late int newNotificationCount;
  final NotificationController notificationController =
      Get.find<NotificationController>();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      await Future.delayed(const Duration(milliseconds: 500));
      final sharedPrefs = await SharedPreferences.getInstance();
      await sharedPrefs.reload();
      List<String> storedNotifications;
      storedNotifications =
          sharedPrefs.getStringList('backgroundNotifications') ?? [];

      final lastNotification = storedNotifications.last;
      final lastNotificationData = json.decode(lastNotification);
      final title = lastNotificationData['title'];
      final message = lastNotificationData['message'];
      debugPrint('Title: $title, Message: $message');

      setState(() {
        notificationController.addNotification(title, message);
      });
    }
  }
  // List<RemoteMessage> _notifications = [];
  // final NotificationController notificationController =
  //     Get.find<NotificationController>();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    newNotificationCount = 0;
    debugPrint("in notification");
    // ever(notificationController.notifications.obs, (_) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Future<void> backgroundMessageHandler(RemoteMessage message) async {
  //   // Handle background notification
  //   if (message.notification != null) {
  //     setState(() {
  //       _notifications.insert(0, message);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // Call markAllAsRead when entering the screen
    var screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.03,
              ),
              child: IconButton(
                  onPressed: () {
                    notificationController.deleteNotifications();
                  },
                  icon: const Icon(Icons.delete)),
            )
          ],
          title: Padding(
            padding: EdgeInsets.only(
              top: screenHeight * 0.03,
            ),
            child: Text(
              'Notifications',
              style: GoogleFonts.lato(
                  fontSize: 28,
                  letterSpacing: 0.01,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Obx(() {
          return Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.03),
            child: Scrollbar(
              thickness: 4.0,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: notificationController.notifications.length,
                separatorBuilder: (context, index) => const Divider(
                  thickness: 1,
                  height: 0,
                ),
                itemBuilder: (context, index) {
                  final message = notificationController.notifications[index];

                  notificationController.notifications[index].isRead = true;
                  notificationController.notifications[index]
                      .updateFormattedTimeStamp(notificationController
                          .notifications[index].timestamp);
                  return Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ListTile(
                        title: Text(message.title ?? "",
                            style: GoogleFonts.sourceSansPro(
                                fontSize: 18,
                                letterSpacing: 0.01,
                                color: const Color.fromRGBO(255, 255, 255, 0.8),
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          message.message ?? "",
                        ),
                        trailing: Obx(
                          () {
                            if (message.isLoading.value) {
                              return Text(message.formattedTimestamp.value,
                                  style: GoogleFonts.sourceSansPro(
                                      fontSize: 12,
                                      letterSpacing: 0.01,
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 0.6),
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold));
                            } else {
                              return Text(message.formattedTimestamp.value,
                                  style: GoogleFonts.sourceSansPro(
                                      fontSize: 14,
                                      letterSpacing: 0.01,
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 0.5),
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold));
                            }
                          },
                        ),
                        onTap: () {
                          setState(() {
                            notificationController
                                .notifications[index].isTapped?.value = true;
                          });
                        },
                        tileColor: notificationController
                                    .notifications[index].isTapped?.value ==
                                false
                            ? Colors.grey[900]
                            : Colors.transparent,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
