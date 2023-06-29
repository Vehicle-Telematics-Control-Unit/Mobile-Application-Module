import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:signalr_core/signalr_core.dart';

import 'package:smart_car_mobile_app/controllers/authentication_controller.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  var authenticationController = Get.find<AuthenticationController>();

  late LatLng _markerPosition;
  @override
  void initState() {
    // Trigger the RequestGPS method when the screen is loaded
    super.initState();

    debugPrint("i am in mapsss");
    intializeSignalR();
    loadMapStyle();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadMapStyle() async {
    String style = await DefaultAssetBundle.of(context)
        .loadString('assets/map_styles.json');
    _controller.setMapStyle(style);
  }

  late GoogleMapController _controller; // map controller to control map
  late HubConnection hubConnection;
  Set<Marker> markers = {};

  bool isConnected = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.width;
    return Scaffold(
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          if (!isConnected && connectivity != ConnectivityResult.none) {
            _reconnectSignalR(); // Reconnect to SignalR when internet is restored
            isConnected = true;
          } else if (connectivity == ConnectivityResult.none) {
            isConnected = false;
          }
          return child;
        },
        child: Stack(children: [
          Positioned.fill(
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Center(
            child: SizedBox(
              width: width,
              height: height * 1.5,
              child: Stack(children: [
                GoogleMap(
                  mapType: MapType.hybrid,

                  markers: markers, // type of map we want
                  minMaxZoomPreference: const MinMaxZoomPreference(10, 20),
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(0, 0),
                    zoom: 20,
                  ),
                  onMapCreated: (controller) {
                    _controller = controller;
                  },
                ),
                Positioned(
                    bottom: height * 0.3,
                    right: width * 0.01,
                    child: FloatingActionButton(
                      backgroundColor: Colors.red,
                      onPressed: _goToMarker,
                      child: const Icon(
                        Icons.location_on,
                      ),
                    )),
              ]),
            ),
          ),
        ]),
      ),
    );
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
    setState(() {
      markers = {
        Marker(
          markerId: const MarkerId('vehicle'),
          position: _markerPosition,
        )
      };
    });
    debugPrint("plreaseeee gps");
    // Animate the movement of the marker
    _controller.animateCamera(
      CameraUpdate.newLatLng(LatLng(lat, lng)),
    );
  }

  Future<void> requestGPS() async {
    try {
      await hubConnection.invoke('RequestGPS', args: <Object>[1]);
      debugPrint('RequestGPS invoked successfully.');
    } catch (ex) {
      debugPrint('Error invoking RequestGPS: $ex');
    }
  }

  void _goToMarker() {
    _controller.animateCamera(CameraUpdate.newLatLng(_markerPosition));
  }

  void _reconnectSignalR() {
    intializeSignalR();
  }
}
