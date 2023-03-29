import 'dart:async';

import 'package:crop_capture/widgets/text_animator.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:crop_capture/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const HomePage();
          },
          transitionDuration: const Duration(milliseconds: 600),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: size * 0.3,
            width: size * 0.3,
            child: Lottie.asset(
              'assets/icons/leaf_icon.json',
              fit: BoxFit.fill,
            ),
          ),
          const SplashTextAnimation(),
        ],
      ),
    ));
  }
}
