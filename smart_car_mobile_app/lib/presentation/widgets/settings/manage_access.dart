import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
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
        // Generate a secret key for encryption
    final key = encrypt.Key.fromLength(32); // 32-byte key length
    final iv = encrypt.IV.fromLength(16); // 16-byte initialization vector (IV) to add randomnesss to encryption
    // Encrypt the token and TCU ID values
    final encrypt.Encrypter encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypt.Encrypted encryptedToken = encrypter.encrypt(widget.shareAccessController.token?.value ?? '', iv: iv);
    final encrypt.Encrypted encryptedTcuId = encrypter.encrypt(widget.shareAccessController.tcuId!.value.toString() , iv: iv);

    // Encode the encrypted values as a string for the QR code data
    final String encodedToken = encryptedToken.base64;
    final String encodedTcuId = encryptedTcuId.base64;
    final String encodedData = '$encodedToken,$encodedTcuId';

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
            child: QrImageView(
              data:
                 encodedData,
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
