import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationManager {
  static final NotificationManager _instance = NotificationManager._internal();

  factory NotificationManager() {
    return _instance;
  }

  NotificationManager._internal();

   List<RemoteMessage> notifications = [];
   List<RemoteMessage> get getNotifications => notifications;
}
