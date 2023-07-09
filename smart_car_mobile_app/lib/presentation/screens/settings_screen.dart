import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:smart_car_mobile_app/presentation/widgets/settings/edit_account.dart';


import '../../controllers/share_access_controller.dart';

import '../widgets/settings/account_options.dart';
import '../widgets/settings/sign_out_option.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});
  final shareAccessController = Get.find<ShareAccessController>();
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  bool valNotify = true;
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
            "Settings",
            style: GoogleFonts.lato(
                fontSize: 28,
                letterSpacing: 0.01,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
              left: screenHeight * 0.02,
              top: screenHeight * 0.03,
              right: screenHeight * 0.02),
          child: ListView(children: [
            SizedBox(
              height: screenHeight * 0.08,
            ),
            InkWell(
              onTap: () {
                Get.to(() => EditAccount(),
                    transition: Transition.downToUp,
                    duration: const Duration(milliseconds: 400));
              },
              child: AccountOptions(
                  title: 'Edit Account',
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  icon: Icons.person),
            ),
            const Divider(
              thickness: 1,
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            InkWell(
              onTap: () {
                widget.shareAccessController.requestAccess();
              },
              child: Obx(
                () {
                  if (widget.shareAccessController.isLoading.value) {
                    return Shimmer(
                      duration: const Duration(seconds: 5), //Default value
                      interval: const Duration(
                          seconds: 0), //Default value: Duration(seconds: 0)
                      color: Colors.white, //Default value
                      colorOpacity: 0, //Default value
                      enabled: true, //Default value
                      direction: const ShimmerDirection.fromLTRB(),
                      child: AccountOptions(
                        title: 'Manage Access',
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        icon: Icons.qr_code_scanner,
                      ),
                    );
                  } else {
                    return AccountOptions(
                      title: 'Manage Access',
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      icon: Icons.qr_code_scanner,
                    );
                  }
                },
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            // InkWell(
            //   onTap: () {},
            //   child: AccountOptions(
            //       title: 'Shared Devices',
            //       screenWidth: screenWidth,
            //       screenHeight: screenHeight,
            //       icon: Icons.groups),
            // ),
            // const Divider(
            //   thickness: 1,
            // ),
            // SizedBox(
            //   height: screenHeight * 0.03,
            // ),
            // NotificationOptions(
            //     title: " Allow Notifications",
            //     icon: Icons.notifications_active_outlined,
            //     screenWidth: screenWidth,
            //     value: valNotify,
            //     screenHeight: screenHeight),
            // const Divider(
            //   thickness: 1,
            // ),
            // SizedBox(
            //   height: screenHeight * 0.03,
            // ),
            SignOutOption(screenWidth: screenWidth)
          ]),
        ),
      ),
    );
  }
}
