import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_car_mobile_app/presentation/widgets/settings/notifications_options.dart';
import '../widgets/settings/account_options.dart';
import '../widgets/settings/sign_out_option.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool valNotify = true;
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
              left: screenWidth * 0.08,
              top: screenHeight * 0.08,
              right: screenWidth * 0.08),
          child: ListView(children: [
            Text(
              "Settings",
              style: GoogleFonts.lato(
                  fontSize: 28,
                  letterSpacing: 0.01,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: screenHeight * 0.08,
            ),
            InkWell(
              onTap: () {},
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
              onTap: () {},
              child: AccountOptions(
                  title: 'Manage Access',
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  icon: Icons.qr_code_scanner),
            ),
            const Divider(
              thickness: 1,
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            InkWell(
              onTap: () {},
              child: AccountOptions(
                  title: 'Shared Devices',
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  icon: Icons.groups),
            ),
            const Divider(
              thickness: 1,
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            NotificationOptions(
                title: " Allow Notifications",
                icon: Icons.notifications_active_outlined,
                screenWidth: screenWidth,
                value: valNotify,
                screenHeight: screenHeight),
            const Divider(
              thickness: 1,
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            SignOutOption(screenWidth: screenWidth)
          ]),
        ),
      ),
    );
  }
}
