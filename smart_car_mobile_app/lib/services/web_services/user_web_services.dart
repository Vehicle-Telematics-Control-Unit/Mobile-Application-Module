import 'dart:convert';

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import 'package:smart_car_mobile_app/data/models/change-password-model.dart';
import 'package:smart_car_mobile_app/data/models/get-feature-model.dart';
import 'package:smart_car_mobile_app/data/models/resend-code-model.dart';

import 'package:smart_car_mobile_app/data/models/submit-access-model.dart';
import 'package:smart_car_mobile_app/data/models/verify-user-command.dart';
import '../../presentation/widgets/settings/access_denied.dart';
import '../../utils/api_endpoints.dart';
import '../../data/models/user.dart';

class UserWebServices extends GetConnect {
  late Dio dio;
  late String errorMessage;
  UserWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: ApiEndPoints.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 45),
      receiveTimeout: const Duration(seconds: 45),
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

  Future<dynamic> userLogin(
      String username, String password, String? notificationToken) async {
    User user;
    late String? deviceId;

    try {
      deviceId = await PlatformDeviceId.getDeviceId;
      debugPrint("device id is $deviceId");
    } catch (e) {
      debugPrint("error in ${e.toString()}");
    }
    try {
      user = User(
          username: username,
          password: password,
          deviceId: deviceId,
          notificationToken: notificationToken);

      Response response =
          await dio.post(ApiEndPoints.loginUrl, data: user.toJson());
      await Future.delayed(const Duration(seconds: 2));
      return response;
    } on DioException catch (e) {
      debugPrint("status code ${e.response?.statusCode}, ${e.toString()}");
      if (e.response?.statusCode == 401) {
        debugPrint("status code ${e.response?.statusCode}");

        Get.showSnackbar(snackBar("Wrong credentials!"));
      } else {
        Get.showSnackbar(snackBar("An error occured"));
      }
    }
  }

  Future<bool> wakeUpTCU(var authToken) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer $authToken',
      };
      Response response = await dio.post(ApiEndPoints.wakeUpTCU);
      await Future.delayed(const Duration(seconds: 2));
      if (response.statusCode == 200) {
        return true;
      }
    } on DioException catch (e) {
      debugPrint("status code ${e.response?.statusCode}, ${e.toString()}");
    }
    return false;
  }

  Future<dynamic> requestAccess(String? authToken, String? deviceId) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer $authToken',
      };
      Response response = await dio.post(ApiEndPoints.requestAccess);
      await Future.delayed(const Duration(seconds: 2));
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        Get.to(
          () => const AccessDenied(),
          transition: Transition.downToUp,
          duration: const Duration(milliseconds: 400),
        );
      } else {
        Get.to(
          () => const AccessDenied(),
          transition: Transition.downToUp,
          duration: const Duration(milliseconds: 400),
        );
      }
    }
  }

  GetSnackBar snackBar(String message) {
    return GetSnackBar(
      snackStyle: SnackStyle.GROUNDED,
      message: message,
      backgroundColor: Colors.grey.shade900,
      icon: const Icon(CupertinoIcons.exclamationmark_circle,
          color: Colors.red, size: 30),
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
      borderRadius: 10,
      shouldIconPulse: true,
    );
  }

  Future<dynamic> submitRequestAccess(
      SubmitAccessModel submitAccessModel) async {
    try {
      Response response = await dio.post(ApiEndPoints.submitAccess,
          data: submitAccessModel.toJson());
      await Future.delayed(const Duration(seconds: 2));
      return response;
    } on DioException catch (e) {
      debugPrint("status code ${e.response?.statusCode}, ${e.toString()}");

      // if (e.response?.statusCode == 500) {
      //   debugPrint("status code ${e.response?.statusCode}");

      //   Get.showSnackbar(snackBar("An error occured!"));
      // } else if (e.response?.statusCode == 419) {
      //   Get.showSnackbar(snackBar("request expired"));
      // } else {
      //   Get.showSnackbar(snackBar("Access Denied!"));
      // }
    }
  }

  Future<dynamic> changePassword(
      String currentPassword, String newPassword, String authToken) async {
    dio.options.headers = {
      'Authorization': 'Bearer $authToken',
    };
    try {
      var changePasswordModel = ChangePasswordModel(
          password: currentPassword, newPassword: newPassword);

      Response response = await dio.post(ApiEndPoints.changePassword,
          data: changePasswordModel);
      return response;
    } on DioException catch (e) {
      debugPrint("status code ${e.response?.statusCode}, ${e.toString()}");
      if (e.response?.statusCode == HttpStatus.unauthorized) {
        debugPrint("status code ${e.response?.statusCode}");

        Get.showSnackbar(
            snackBar("You are not Authorized to change password!"));
      } else if (e.response?.statusCode == HttpStatus.badRequest) {
        Get.showSnackbar(snackBar("Wrong Password!"));
      } else {
        Get.showSnackbar(snackBar("An error occured"));
      }
    }
  }

  Future<dynamic> changeUsername(String username, String authToken) async {
    dio.options.headers = {
      'Authorization': 'Bearer $authToken',
    };
    try {
      debugPrint("usernameeeeeeee $username");
      Response response = await dio.post(ApiEndPoints.changeUsername,
          data: jsonEncode(username));
      return response;
    } on DioException catch (e) {
      debugPrint("status code ${e.response?.statusCode}, ${e.toString()}");
      if (e.response?.statusCode == HttpStatus.unauthorized) {
        debugPrint("status code ${e.response?.statusCode}");

        Get.showSnackbar(
            snackBar("You are not Authorized to change username!"));
      } else if (e.response?.statusCode == HttpStatus.badRequest) {
        Get.showSnackbar(snackBar("Username already taken!"));
      } else {
        Get.showSnackbar(snackBar("An error occured"));
      }
    }
  }

  Future<dynamic> fetchFeatures(String authToken) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer $authToken',
      };
      Response response = await dio.get(
        ApiEndPoints.feature,
      );
      return response;
    } on DioException catch (e) {
      debugPrint("status code ${e.response?.statusCode}, ${e.toString()}");
      if (e.response != null &&
          e.response?.statusCode == HttpStatus.unauthorized) {
        Get.showSnackbar(snackBar("You dont have access!"));
      } else {
        Get.showSnackbar(snackBar("An error occured"));
      }
    }
  }

  Future<dynamic> activateFeature(String authToken, var id) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer $authToken',
      };
      debugPrint('feature id $id');
      var getFeatureModel = GetFeatureModel();
      getFeatureModel.featureId = id;
      Response response =
          await dio.put(ApiEndPoints.feature, data: getFeatureModel.toJson());
      return response;
    } on DioException catch (e) {
      debugPrint("status code ${e.response?.statusCode}, ${e.toString()}");
      if (e.response?.statusCode == HttpStatus.unauthorized) {
        Get.showSnackbar(snackBar("You dont have access!"));
      } else {
        Get.showSnackbar(snackBar("An error occured"));
      }
    }
  }

  Future<dynamic> deactivateFeature(String authToken, int id) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer $authToken',
      };
      debugPrint('feature id $id');
      var getFeatureModel = GetFeatureModel();
      getFeatureModel.featureId = id;
      Response response = await dio.delete(ApiEndPoints.feature,
          data: getFeatureModel.toJson());
      return response;
    } on DioException catch (e) {
      debugPrint("status code ${e.response?.statusCode}, ${e.toString()}");
      if (e.response?.statusCode == HttpStatus.unauthorized) {
        Get.showSnackbar(snackBar("You dont have access!"));
      } else {
        Get.showSnackbar(snackBar("An error occured"));
      }
    }
  }

  Future<dynamic> getTcuId(String authToken) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer $authToken',
      };

      Response response = await dio.get(
        ApiEndPoints.getTcuId,
      );
      return response;
    } on DioException catch (e) {
      debugPrint("status code ${e.response?.statusCode}, ${e.toString()}");
      Get.showSnackbar(snackBar("An error occured"));
    }
  }

  Future<dynamic> getFeatureImage(String authToken, int featureId) async {
    try {
      late Dio dio;
      BaseOptions options = BaseOptions(
        baseUrl: ApiEndPoints.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 45),
        receiveTimeout: const Duration(seconds: 45),
        headers: {
          HttpHeaders.acceptCharsetHeader: 'utf-8',
        },
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      );
      dio = Dio(options);
      dio.options.headers = {
        'Authorization': 'Bearer $authToken',
        'Accept': 'image/jpeg'
      };
      dio.options.responseType = ResponseType.bytes;
      Response response = await dio.get(
        '${ApiEndPoints.getFeatureImage}/$featureId',
      );

      return response;
    } on DioException catch (e) {
      debugPrint("status code ${e.response?.statusCode}, ${e.toString()}");
    }
  }

  Future<dynamic> logout(String authToken) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer $authToken',
      };
      Response response = await dio.post(ApiEndPoints.logout);
      await Future.delayed(const Duration(seconds: 2));
      return response;
    } on DioException catch (e) {
      debugPrint("status code ${e.response?.statusCode}, ${e.toString()}");
      if (e.response?.statusCode == HttpStatus.unauthorized) {
        debugPrint("status code ${e.response?.statusCode}");

        Get.showSnackbar(snackBar("You are not authorized"));
      } else {
        Get.showSnackbar(snackBar("An error occured"));
      }
    }
  }

  Future<dynamic> resendCode(String deviceId, String username) async {
    try {
      ResendCodeModel sendCodeModel =
          ResendCodeModel(deviceId: deviceId, username: username);
      Response response =
          await dio.post(ApiEndPoints.resendCode, data: sendCodeModel.toJson());
      await Future.delayed(const Duration(seconds: 2));
      return response;
    } on DioException catch (e) {
      debugPrint("status code ${e.response?.statusCode}, ${e.toString()}");
      if (e.response?.statusCode == HttpStatus.unauthorized) {
        debugPrint("status code ${e.response?.statusCode}");

        Get.showSnackbar(snackBar("You are not authorized"));
      } else {
        Get.showSnackbar(snackBar("An error occured"));
      }
    }
  }
}
