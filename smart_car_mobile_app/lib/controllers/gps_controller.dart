

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:smart_car_mobile_app/data/models/get-tcu-model.dart';
import 'package:smart_car_mobile_app/services/web_services/user_web_services.dart';
import 'authentication_controller.dart';

class GpsController extends GetxController {
  late AuthenticationController authenticationController;
  late LatLng _markerPosition;
  late GoogleMapController? _controller;
  late HubConnection hubConnection;

  RxSet<Marker> markers = <Marker>{}.obs;

  late UserWebServices userWebServices;

  @override
  void onInit() {
    super.onInit();
    authenticationController = Get.find<AuthenticationController>();
    userWebServices = Get.find<UserWebServices>();
  }

  void reconnectSignalR() {
    intializeSignalR();
  }

  Future<void> intializeSignalR() async {
    const serverUrl = 'https://vehicleplus.cloud/GPS';
    var authToken = authenticationController.getToken();
    const transport = HttpTransportType.webSockets;
    final options = HttpConnectionOptions(
      transport: transport,
      skipNegotiation: true,
      accessTokenFactory: () => Future.value(authToken),
    );
    hubConnection = HubConnectionBuilder().withUrl(serverUrl, options).build();

    try {
      await hubConnection.start();
      if (hubConnection.state == HubConnectionState.connected) {
        requestGPS();
        hubConnection.on('ReceiveLocation', _handleLocationUpdate);
        debugPrint('SignalR connection established.');
      } else {
        debugPrint('SignalR connection failed to start.');
      }
    } catch (ex) {
      debugPrint('Error connecting to SignalR: $ex');
    }
  }

  Future<int?> getTcuId() async {
    try {
      String token = authenticationController.getToken();
      Response response = await userWebServices.getTcuId(token);
      if (response.statusCode == 200) {
        var tcuResponse = GetTcuModel.fromJson(response.data);

        // var jsonData=
        // int tcuId = int.parse(response.data['id']);
        // authenticationController.saveTcuId(tcuId);
        debugPrint("status code of gps  is ${response.statusCode}");
        debugPrint("response data is ${tcuResponse.id}");
        authenticationController.saveTcuId(tcuResponse.id);
      }
      return null;
    } on DioException catch (e) {
      debugPrint("status code ${e.response?.statusCode}, ${e.toString()}");
      return null;
    }
  }

  void _handleLocationUpdate(List<dynamic>? arguments) {
    if (arguments == null) {
      // Invalid arguments or missing data
      return;
    }
    final lat = (arguments[0] as num).toDouble();
    final lng = (arguments[1] as num).toDouble();
    _markerPosition = LatLng(lat, lng);
    debugPrint("vehicle location is $lat and $lng");
    // Update the marker position

    final updatedMarkers = <Marker>{
      Marker(
        markerId: const MarkerId('vehicle'),
        position: _markerPosition,
        icon: BitmapDescriptor.defaultMarker,
      )
    };
    markers.value = updatedMarkers;
    debugPrint("plreaseeee gps");
    // Animate the movement of the marker
    _controller?.animateCamera(
      CameraUpdate.newLatLng(LatLng(lat, lng)),
    );
  }

  Future<void> requestGPS() async {
    try {
      var id = authenticationController.getTcuId();
      await hubConnection.invoke('RequestGPS', args: <Object>[id]);
      debugPrint('RequestGPS invoked successfully.');
    } catch (ex) {
      debugPrint('Error invoking RequestGPS: $ex');
    }
  }

  Future<void> stopStreaming() async {
    try {
      var id = authenticationController.getTcuId();
      await hubConnection.invoke('StopGPS', args: <Object>[id]);
      debugPrint('StopGPS invoked successfully.');
    } catch (ex) {
      debugPrint('Error invoking StopGPS: $ex');
    }
  }

  void goToMarker() {
    _controller?.animateCamera(CameraUpdate.newLatLng(_markerPosition));
  }

  void setMapController(GoogleMapController controller) {
    _controller = controller;
  }
}
