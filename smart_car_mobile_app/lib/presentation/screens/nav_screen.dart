

import 'package:flutter/material.dart';
import 'package:smart_car_mobile_app/presentation/widgets/map.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Maps()),
    );
  }
}
