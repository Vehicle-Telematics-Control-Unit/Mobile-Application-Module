import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart ' as qr_scanner;
import 'package:smart_car_mobile_app/controllers/share_access_controller.dart';

class QrScannerScreen extends StatefulWidget {
  QrScannerScreen({super.key});
  var shareAccessController = Get.find<ShareAccessController>();

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  MobileScannerController cameraController =
      MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates);

  var isLoading = false;
  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state as CameraFacing) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: MobileScanner(
                // fit: BoxFit.contain,

                startDelay: true,
                controller: cameraController,
                onDetect: (capture) {
                  debugPrint("handleBarcodeDetection");
                  handleBarcodeDetection(capture);
                },
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: ShapeDecoration(
                shape: qr_scanner.QrScannerOverlayShape(
                  borderColor: Colors.red,
                  borderRadius: 10,
                  borderLength: 20,
                  borderWidth: 5,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Text(
                'Scan the QR code to instantly grant access',
                style: GoogleFonts.lato(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> handleBarcodeDetection(BarcodeCapture capture) async {
    final List<Barcode> barcodes = capture.barcodes;
    bool qrCodeDetected = false;
    for (final barcode in barcodes) {
      final String? rawData = barcode.rawValue;
      if (rawData != null) {
        final List<String> values = rawData.split(',');
        if (values.length == 2) {
          final String token = values[0];
          final String tcuId = values[1];
          if (token.isNotEmpty || tcuId.isNotEmpty) {
            // Both token and TCU ID are present
            // Decode and print the values
            setState(() {
              isLoading = true; // Show the progress indicator
            });
            final encrypt.Key key = encrypt.Key.fromLength(32);
            final encrypt.IV iv = encrypt.IV.fromLength(16);
            final encrypt.Encrypter encrypter =
                encrypt.Encrypter(encrypt.AES(key));
            final encrypt.Encrypted encryptedToken =
                encrypt.Encrypted.fromBase64(token);
            final encrypt.Encrypted encryptedTcuId =
                encrypt.Encrypted.fromBase64(tcuId);
            final String decryptedToken =
                encrypter.decrypt(encryptedToken, iv: iv);
            final String decryptedTcuId =
                encrypter.decrypt(encryptedTcuId, iv: iv);
            debugPrint('Decoded Token: $decryptedToken');
            debugPrint('Decoded TCU ID: $decryptedTcuId');
            bool isValid = await widget.shareAccessController
                .submitRequestAccess(decryptedToken, decryptedTcuId);
          }
          // Make HTTP request to verify qrcode
          // ...
        }
      } else {
        debugPrint('Invalid qrcode format');
      }

      setState(() {
        isLoading = false; // Hide the progress indicator
      });
    }
  }
}
