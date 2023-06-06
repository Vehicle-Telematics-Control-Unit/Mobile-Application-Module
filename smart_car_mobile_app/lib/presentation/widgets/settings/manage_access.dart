import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smart_car_mobile_app/controllers/share_access_controller.dart';

class ManageAcessScreen extends StatefulWidget {
  ManageAcessScreen({super.key});
  final shareAccessController = Get.find<ShareAccessController>();
  @override
  State<ManageAcessScreen> createState() => _ManageAcessScreenState();
}

class _ManageAcessScreenState extends State<ManageAcessScreen> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.09,
          ),
          Text(
            'Scan Qr Code',
            style: GoogleFonts.lato(
                fontSize: 28,
                letterSpacing: 0.01,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Text(
            "Grant access instantly by scanning this code.",
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
                fontSize: 18,
                color: Colors.grey[500],
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: screenHeight * 0.05,
          ),
          Center(
            child: QrImage(
              data:
                  '${widget.shareAccessController.token?.value},${widget.shareAccessController.token?.value}',
              version: QrVersions.auto,
              backgroundColor: Colors.white,
              size: 250.0,
            ),
          ),
        ],
      ),
    );
  }
}
