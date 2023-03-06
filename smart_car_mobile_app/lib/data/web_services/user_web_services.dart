import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:smart_car_mobile_app/data/models/login-response.dart';

import '../../utils/api_endpoints.dart';

import '../models/user.dart';

class UserWebServices extends GetConnect {
  late Dio dio;
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
    try {
      User user = User(username: username, password: password, deviceId: 2);
      debugPrint("json user ${(user.toJson()).toString()}");
      Response response =
          await dio.post(ApiEndPoints.loginUrl, data: user.toJson());
      await Future.delayed(const Duration(seconds: 2));
      if (response.statusCode == HttpStatus.ok) {
        // 200
        debugPrint('JWT is ${response.data.toString()}');
        return LoginResponse.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
