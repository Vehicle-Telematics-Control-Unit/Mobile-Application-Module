import 'package:get/get.dart';

class NotificationModel extends GetxController {
  String? title;
  String? message;
  DateTime? timestamp;
  bool? isRead;
  RxString formattedTimestamp;
  RxBool isLoading = false.obs;
  RxBool? isTapped = false.obs;

  NotificationModel(
      {this.title, this.message, this.timestamp, this.isRead, this.isTapped})
      : formattedTimestamp = ''.obs;

  // Convert the notification model to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'message': message,
      'timestamp': timestamp.toString(),
      'isTapped': isTapped?.value
    };
  }

  void updateFormattedTimeStamp(DateTime? timeStamp) {
    isLoading.value = true;
    final now = DateTime.now();
    final difference = now.difference(timeStamp!);

    if (difference.inSeconds < 60) {
      formattedTimestamp.value = 'now';
    } else if (difference.inMinutes < 60) {
      formattedTimestamp.value = '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      formattedTimestamp.value = '${difference.inHours}h';
    } else if (difference.inDays < 7) {
      formattedTimestamp.value = '${difference.inDays}d';
    } else if (difference.inDays < 30) {
      formattedTimestamp.value = '${(difference.inDays / 7).floor()}w';
    } else {
      formattedTimestamp.value = '${(difference.inDays / 30).floor()}m';
    }
    isLoading.value = false;
  }

  // Create a notification model from a JSON object
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
        title: json['title'],
        message: json['message'],
        timestamp: DateTime.parse(json['timestamp']),
        isTapped: RxBool(json['isTapped']));
  }
}
