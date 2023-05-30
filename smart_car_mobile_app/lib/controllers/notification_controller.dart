import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/notification_model.dart';

class NotificationController extends GetxController {
  final RxList<NotificationModel> _notifications = <NotificationModel>[].obs;
  List<NotificationModel> get notifications => _notifications.toList().obs;
  RxInt unreadCount = 0.obs;
  Timer? updateTimer;

  @override
  void onInit() {
    loadNotifications();
    startUpdateTimer();

    super.onInit();
  }

  void markAllAsRead() {
    for (var notification in _notifications) {
      if (notification.isRead == false) {
        notification.isRead = true;
      }
    }
    unreadCount.value = 0;
  }

  dynamic unReadNotifications() {
    return _notifications
        .where((element) => element.isRead == false)
        .length
        .obs;
  }

  void markBatchAsSeen() {
    unreadCount.value = 0;
  }

  Future<void> clearNotifications() async {
    _notifications.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('backgroundNotifications');
    await prefs.remove('notifications');
  }

  Future<void> loadNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.reload();
    final storedNotifications = prefs.getStringList('notifications') ?? [];
    List<NotificationModel> notifications = storedNotifications
        .map((notification) =>
            NotificationModel.fromJson(jsonDecode(notification)))
        .toList();
    // final storedBackgroundNotifications =
    //     prefs.getStringList('backgroundNotifications') ?? [];
    _notifications.assignAll(notifications);
    // backgroundNotifications.assignAll(storedBackgroundNotifications);
  }

  // Example usage to add a new notification
  Future<void> addNotification(String title, String message) async {
    final updatedNotifications = [...notifications];
    // Preserve tapped state of existing notifications
    for (var existingNotification in updatedNotifications) {
      existingNotification.isTapped?.value =
          existingNotification.isTapped?.value ?? false;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.reload();
    // Create a new NotificationModel instance
    NotificationModel notification = NotificationModel(
        title: title,
        message: message,
        timestamp: DateTime.now(),
        isRead: false);
    notification.isTapped = false.obs;
    notification.updateFormattedTimeStamp(notification.timestamp);
    updatedNotifications.insert(0, notification);
    // Save the notification data to local storage
    //Retrieves the list of notifications stored in SharedPreferences using the key 'notifications'
    List<String> notificationList = prefs.getStringList('notifications') ?? [];
    List<NotificationModel> notificationModelList = notificationList
        .map((notification) =>
            NotificationModel.fromJson(jsonDecode(notification)))
        .toList();

    // Encodes the given notification object into a JSON string using jsonEncode.
    _notifications.value = notificationModelList;
    // _notifications.insert(0, notification);
    _notifications.assignAll(updatedNotifications);
    final notificationsJson =
        _notifications.map((notification) => notification.toJson()).toList();
    final notificationsStringList =
        notificationsJson.map((json) => jsonEncode(json)).toList();

    prefs.setStringList('notifications', notificationsStringList);

    unreadCount.value++;
    // debugPrint("valuee is ${unreadCount.value.toString()}");
  }

  dynamic updateReadNotificationCount() {
    return unreadCount.value = _notifications
        .where((notification) => notification.isRead == false)
        .length;
  }

  //It is called when the controller is removed from memory, typically when the associated UI is disposed or destroyed.
  @override
  void onClose() {
    super.onClose();
    // the timer is stopped and any scheduled updates are halted
    cancelUpdateTimer();
  }

  void startUpdateTimer() {
    // call back function will be triggered every 1 sec
    updateTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      // updating the formatted timestamps of the notifications.
      updateFormattedTimeStamps();
    });
  }

  void cancelUpdateTimer() {
    updateTimer?.cancel();
  }

  void updateFormattedTimeStamps() {
    for (var notification in _notifications) {
      notification.updateFormattedTimeStamp(notification.timestamp);
    }
  }
}
