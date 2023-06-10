

import 'package:flutter/material.dart';
import 'package:smart_car_mobile_app/presentation/widgets/map.dart';

class NavScreen extends StatelessWidget {
  const NavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Maps()),
    );
  }
}
