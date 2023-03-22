import 'package:flutter/material.dart';

import 'package:crop_capture/pages/constants.dart';

class SplashTextAnimation extends StatefulWidget {
  const SplashTextAnimation({Key? key}) : super(key: key);

  @override
  State<SplashTextAnimation> createState() => _SplashTextAnimationState();
}

class _SplashTextAnimationState extends State<SplashTextAnimation> {
  final String title = 'Crop Care';

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<int>(
      duration: const Duration(seconds: 2),
      builder: (BuildContext context, int value, Widget? child) {
        return Text(
          title.substring(0, value),
          style: const TextStyle(
            color: secondaryColor,
            fontSize: 40,
          ),
        );
      },
      tween: IntTween(
        begin: 0,
        end: title.length,
      ),
    );
  }
}
