import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo/view/auth/onboarding.dart';
import 'package:todo/view/auth/signup_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();
  void initState() {
    super.initState();
    // Timer for navigation after 3 seconds
    Timer(const Duration(seconds: 5), () {
      final bool onboardingply = box.read('onboarding');
      if (onboardingply) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => SignUpScreen()));
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const Onboarding()), // Replace with your target screen
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 270),
            child: Text(
              'to do',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          )),
        ],
      ),
    );
  }
}
