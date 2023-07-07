import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:signalr_core/signalr_core.dart';

import 'package:smart_car_mobile_app/controllers/authentication_controller.dart';

import '../../controllers/gps_controller.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  var gpsController = Get.find<GpsController>();
  var authenticationController = Get.find<AuthenticationController>();
  late var tcuId;
  // late LatLng _markerPosition;
  @override
  void initState() {
    // Trigger the RequestGPS method when the screen is loaded
    super.initState();
    getTcuId();

    debugPrint("i am in mapsss");
    // intializeSignalR();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isConnected = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Obx(
        () {
          final markers = gpsController.markers;
          return Stack(
            children: [
              Positioned.fill(
                child: Container(
                  color: Colors.transparent,
                ),
              ),
              Center(
                child: SizedBox(
                  width: width,
                  height: height * 1.5,
                  child: Stack(
                    children: [
                      GoogleMap(
                        mapType: MapType.hybrid,
                        markers: Set<Marker>.from(markers),
                        minMaxZoomPreference:
                            const MinMaxZoomPreference(10, 20),
                        initialCameraPosition: const CameraPosition(
                          target: LatLng(0, 0),
                          zoom: 20,
                        ),
                        onMapCreated: (controller) {
                          gpsController.setMapController(controller);
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
                        ),
                      ),
                      Positioned(
                        bottom: height * 0.5,
                        right: width * 0.01,
                        child: FloatingActionButton(
                          backgroundColor: Colors.grey.shade900,
                          onPressed: gpsController.stopStreaming,
                          child: const Icon(
                            Icons.stop,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _goToMarker() {
    gpsController.goToMarker();
  }

  void getTcuId() {
    tcuId = gpsController.getTcuId();
    authenticationController.saveTcuId(tcuId);
  }
}
