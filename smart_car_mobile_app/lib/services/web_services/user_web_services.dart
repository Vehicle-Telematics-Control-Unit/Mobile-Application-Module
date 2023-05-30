import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:smart_car_mobile_app/data/models/verify-user-command.dart';
import '../../utils/api_endpoints.dart';

import '../../data/models/user.dart';

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

  Future<dynamic> verifyEmail(VerifyUserCommand verifyUserCommand) async {
    try {
      Response response = await dio.post(ApiEndPoints.verifyMail,
          data: verifyUserCommand.toJson());
      await Future.delayed(const Duration(seconds: 2));
      return response;
    } catch (e) {
      rethrow;
    }
  }



  Future<dynamic> userLogin(String username, String password, String? notificationToken) async {
    late String? deviceId;
    User user;
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
      debugPrint("device id is $deviceId");
    } catch (e) {
      debugPrint("error in ${e.toString()}");
    }
    try {
      user = User(username: username, password: password, deviceId: deviceId,notificationToken: notificationToken);
      
      Response response =
          await dio.post(ApiEndPoints.loginUrl, data: user.toJson());
      await Future.delayed(const Duration(seconds: 2));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
