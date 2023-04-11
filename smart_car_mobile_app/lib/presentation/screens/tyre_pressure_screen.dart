// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/main_page/tyre_pressure_status.dart';

class TyrePressureScreen extends StatefulWidget {
  const TyrePressureScreen({super.key});

  @override
  State<TyrePressureScreen> createState() => _TyrePressureScreenState();
}

class _TyrePressureScreenState extends State<TyrePressureScreen>
    with TickerProviderStateMixin {
  late AnimationController lockAnimationController;

  late Animation<double> animationLock1;
  late Animation<double> animationLock2;
  late Animation<double> animationLock3;
  late Animation<double> animationLock4;

  late List<Animation<double>> lockAnimations;

  void setUpLockAnimation() {
    lockAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    animationLock1 = CurvedAnimation(
        parent: lockAnimationController, curve: const Interval(0.30, 0.5));
    animationLock2 = CurvedAnimation(
        parent: lockAnimationController, curve: const Interval(0.5, 0.66));
    animationLock3 = CurvedAnimation(
        parent: lockAnimationController, curve: const Interval(0.66, 0.82));
    animationLock4 = CurvedAnimation(
        parent: lockAnimationController, curve: const Interval(0.82, 1));
  }

  @override
  void initState() {
    setUpLockAnimation();
    lockAnimationController.forward();
    lockAnimations = [
      animationLock1,
      animationLock2,
      animationLock3,
      animationLock4
    ];
    super.initState();
  }

  @override
  void dispose() {
    lockAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: lockAnimationController,
        builder: (context, _) {
          return Scaffold(
            body: SafeArea(child: LayoutBuilder(
              builder: (context, constrains) {
                return Stack(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text('Tyre pressure',
                    //       textAlign: TextAlign.center,
                    //       style: GoogleFonts.lato(
                    //           fontSize: 30,
                    //           letterSpacing: 0.01,
                    //           fontStyle: FontStyle.normal,
                    //           color: const Color.fromRGBO(255, 255, 255, 0.8))),
                    // ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: constrains.maxHeight * 0.17),
                      child: Center(
                        child: Image.asset(
                          "assets/images/car_top2.png",
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Positioned(
                      top: constrains.maxHeight * 0.3,
                      left: constrains.maxWidth * 0.04,
                      child: PressureStatus(
                        tyrePressure: '30.0',
                        tyreTemp: '22C',
                      ),
                    ),
                    Positioned(
                        top: constrains.maxHeight * 0.4,
                        left: constrains.maxWidth * 0.04,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ScaleTransition(
                            scale: lockAnimations[0],
                            child: SvgPicture.asset(
                              "assets/images/door_lock.svg",
                              height: 35,
                              width: 35,
                            ),
                          ),
                        )),

                    Positioned(
                      bottom: constrains.maxHeight * 0.3,
                      left: constrains.maxWidth * 0.04,
                      child: Column(
                        children: [
                          PressureStatus(tyrePressure: '30.0', tyreTemp: '23C'),
                        ],
                      ),
                    ),
                    Positioned(
                        bottom: constrains.maxHeight * 0.4,
                        left: constrains.maxWidth * 0.04,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ScaleTransition(
                            scale: lockAnimations[2],
                            child: SvgPicture.asset(
                              "assets/images/door_lock.svg",
                              height: 35,
                              width: 35,
                            ),
                          ),
                        )),
                    Positioned(
                      top: constrains.maxHeight * 0.3,
                      right: constrains.maxWidth * 0.04,
                      child:
                          PressureStatus(tyrePressure: '29.0', tyreTemp: '22C'),
                    ),
                    Positioned(
                        top: constrains.maxHeight * 0.4,
                        right: constrains.maxWidth * 0.04,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ScaleTransition(
                            scale: lockAnimations[1],
                            child: SvgPicture.asset(
                              "assets/images/door_lock.svg",
                              height: 35,
                              width: 35,
                            ),
                          ),
                        )),

                    Positioned(
                      bottom: constrains.maxHeight * 0.3,
                      right: constrains.maxWidth * 0.04,
                      child:
                          PressureStatus(tyrePressure: '31.0', tyreTemp: '22C'),
                    ),
                    Positioned(
                        bottom: constrains.maxHeight * 0.4,
                        right: constrains.maxWidth * 0.04,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ScaleTransition(
                            scale: lockAnimations[3],
                            child: SvgPicture.asset(
                              "assets/images/door_unlock.svg",
                              height: 35,
                              width: 35,
                            ),
                          ),
                        )),
                  ],
                );
              },
            )),
            appBar: AppBar(),
          );
        });
  }
}
