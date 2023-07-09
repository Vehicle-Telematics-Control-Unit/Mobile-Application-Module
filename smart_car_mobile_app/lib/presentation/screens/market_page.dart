


import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:smart_car_mobile_app/data/models/feature-model.dart';

import '../../controllers/SUMS_controller.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  final sumsController = Get.find<SUMSController>();

  @override
  void initState() {
    super.initState();
    // fetchFeatures();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(
            top: screenHeight * 0.03,
          ),
          child: Text(
            "Market Place",
            style: GoogleFonts.lato(
              fontSize: 28,
              letterSpacing: 0.01,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(screenWidth * 0.02),
          child: Obx(
            () {
              if (sumsController.isLoading.value) {
                return const Center(
                  child: SpinKitCircle(
                    color: Color.fromARGB(182, 227, 34, 20),
                    size: 50.0,
                  ),
                );
              }
              final featuresInfo = sumsController.featuresInfo;
              return RefreshIndicator(
                color: Colors.grey.shade500,
                onRefresh: sumsController.fetchFeatures,
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: featuresInfo.length,
                  itemBuilder: (context, index) {
                    Feature feature = featuresInfo[index];
                    return Card(
                      color: Colors.grey.shade900,
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: Row(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: FutureBuilder<dynamic>(
                                  future: sumsController
                                      .getFeatureImage(feature.id),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (snapshot.hasError) {
                                      return const Text('Error loading image');
                                    } else if (snapshot.hasData) {
                                      final featureImageBytes = snapshot.data;

                                      return Image.memory(
                                        featureImageBytes,
                                        width: screenHeight * 0.15,
                                        height: screenWidth * 0.2,
                                        fit: BoxFit.fill,
                                      );
                                    } else {
                                      return const Text('No image available');
                                    }
                                  },
                                )),
                            SizedBox(width: screenWidth * 0.03),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    feature.name,
                                    style: GoogleFonts.lato(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromRGBO(
                                        255,
                                        255,
                                        255,
                                        0.8,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  Text(
                                    feature.description,
                                    style: GoogleFonts.lato(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromRGBO(
                                        255,
                                        255,
                                        255,
                                        0.6,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.05),
                            if (feature.state == 1)
                              InkWell(
                                onTap: () {
                                  sumsController.deactivateFeature(feature);
                                },
                                child: Container(
                                  width: 70,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade800,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Obx(() {
                                      if (sumsController
                                          .isLoadingActivateFeature.value) {
                                        return Shimmer(
                                          duration: const Duration(
                                              seconds: 5), //Default value
                                          interval: const Duration(
                                              seconds:
                                                  0), //Default value: Duration(seconds: 0)
                                          color: Colors.white, //Default value
                                          colorOpacity: 0, //Default value
                                          enabled: true, //Default value
                                          direction:
                                              const ShimmerDirection.fromLTRB(),
                                          child: const Text(
                                            'Uninstall',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      }
                                      return const Text(
                                        'Uninstall',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              )
                            else if (feature.state == 0)
                              InkWell(
                                onTap: () {
                                  sumsController.activateFeature(feature);
                                },
                                child: Container(
                                  width: 70,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade800,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Obx(() {
                                      if (sumsController
                                          .isLoadingActivateFeature.value) {
                                        return Shimmer(
                                          duration: const Duration(
                                              seconds: 5), //Default value
                                          interval: const Duration(
                                              seconds:
                                                  0), //Default value: Duration(seconds: 0)
                                          color: Colors.white, //Default value
                                          colorOpacity: 0, //Default value
                                          enabled: true, //Default value
                                          direction:
                                              const ShimmerDirection.fromLTRB(),
                                          child: const Text(
                                            'Get',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      }
                                      return const Text(
                                        'Get',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              )
                            else if (feature.state == 2)
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width: 70,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade800,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Pending install',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                              )
                            else if (feature.state == 3)
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width: 70,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade800,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'pending update',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
