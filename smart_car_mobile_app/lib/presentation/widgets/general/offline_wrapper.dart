import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_offline/flutter_offline.dart';

class OfflineWrapper extends StatelessWidget {
  final Widget child;
  const OfflineWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        final bool isOffline = connectivity == ConnectivityResult.none;
        if (isOffline) {
          return Stack(
            fit: StackFit.expand,
            children: [
              child,
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                left: 0.0,
                top: isOffline ? 0.0 : -60,
                right: 0.0,
                height: 60.0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  color: Colors.grey[900],
                  child: const Center(
                    child: Row(
                      children:  [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            CupertinoIcons.exclamationmark_triangle,
                            color: Colors.red,
                          ),
                        ),
                        Text('Connection Lost',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return child;
      },
      child: child,
    );
  }
}
