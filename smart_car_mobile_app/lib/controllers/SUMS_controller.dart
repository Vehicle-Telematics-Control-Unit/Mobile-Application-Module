import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import '../data/models/feature-model.dart';
import '../services/web_services/user_web_services.dart';
import 'authentication_controller.dart';

class SUMSController extends GetxController {
  late UserWebServices userWebServices;
  late AuthenticationController authenticationController;
  late RxList<dynamic> featuresInfo = <Feature>[].obs;
  var isLoading = false.obs;
  var isLoadingActivateFeature = false.obs;
  @override
  void onInit() {
    userWebServices = Get.find<UserWebServices>();
    authenticationController = Get.find<AuthenticationController>();

    debugPrint("i am herrrrrrrrr");
    super.onInit();
  }

  Future<dynamic> getFeatureImage(int featureId) async {
    try {
      var authToken = authenticationController.getToken();
      Response response =
          await userWebServices.getFeatureImage(authToken, featureId);
      if (response.statusCode == 200) {
        final featureImageBytes = response.data as List<int>;
        return featureImageBytes;
      }
    } on DioException catch (e) {
      debugPrint("status code ${e.response?.statusCode}, ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }

  Future<dynamic> fetchFeatures() async {
    try {
      featuresInfo.clear();
      isLoading(true);
      var authToken = authenticationController.getToken();
      Response response = await userWebServices.fetchFeatures(authToken);
      if (response != null && response.statusCode == 200) {
        final jsonResponse = response.data as List<dynamic>;

        final features = jsonResponse
            .map((data) => Feature.fromJson(data))
            .toList()
            .cast<Feature>();
        debugPrint("state of feature ${features[0].state}");
        featuresInfo.addAll(features);
      }
    } on DioException catch (e) {
      debugPrint("status code ${e.response?.statusCode}, ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }

  Future<dynamic> activateFeature(Feature feature) async {
    try {
      isLoadingActivateFeature(true);
      var authToken = authenticationController.getToken();
      Response response =
          await userWebServices.activateFeature(authToken, feature.id);
      if (response.statusCode == 200) {
        var code = response.data['code'];
        Get.showSnackbar(snackBar(code));
      }
    } on DioException catch (e) {
      debugPrint("status code ${e.response?.statusCode}, ${e.toString()}");
    } finally {
      isLoadingActivateFeature(false);
    }
  }

  Future<dynamic> deactivateFeature(Feature feature) async {
    try {
      var authToken = authenticationController.getToken();
      Response response =
          await userWebServices.deactivateFeature(authToken, feature.id);
      if (response != null && response.statusCode == 200) {
        var code = response.data['code'];
        Get.showSnackbar(snackBar(code));
      }
    } on DioException catch (e) {
      debugPrint("status code ${e.response?.statusCode}, ${e.toString()}");
    } finally {
      isLoadingActivateFeature(false);
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
}
