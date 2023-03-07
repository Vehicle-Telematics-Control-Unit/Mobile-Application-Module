import 'dart:io';

import 'package:platform_device_id/platform_device_id.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import '../../presentation/widgets/login/alert_dialog.dart';
import '../../utils/api_endpoints.dart';

import '../models/user.dart';

class UserWebServices extends GetConnect {
  late Dio dio;
  late String errorMessage;
  UserWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: ApiEndPoints.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        HttpHeaders.acceptCharsetHeader: 'utf-8',
      },
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    );
    dio = Dio(options);
  }

  Future<dynamic> userLogin(String username, String password) async {
    late String? deviceId;
    User user;
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
      debugPrint("device id is $deviceId");
    } catch (e) {
      debugPrint("error in ${e.toString()}");
    }
    try {
      user = User(username: username, password: password, deviceId: deviceId);
      debugPrint("json user ${(user.toJson()).toString()}");
      Response response =
          await dio.post(ApiEndPoints.loginUrl, data: user.toJson());
      await Future.delayed(const Duration(seconds: 2));
      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        debugPrint("status code ${e.response?.statusCode}");
        if (e.response?.data["errorCode"] == -1) {
          Get.dialog(const LoginDialogAlert(errorMessage: 'Invalid email'));
        } else if (e.response?.data["errorCode"] == -2) {
          Get.dialog(const LoginDialogAlert(errorMessage: 'Invalid password'));
        }
      }
    }
  }
}
