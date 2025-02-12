import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:todo/Constants/app_colors.dart';
import 'package:todo/Constants/app_images.dart';
import 'package:todo/view/auth/signup_screen.dart';
import 'package:todo/widget/button/commonbutton.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImages.splash),
          SizedBox(
            height: 18.h,
          ),
          Text(
            textAlign: TextAlign.center,
            'Get things done with TODo',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 18.h,
          ),
          Text(
              textAlign: TextAlign.center,
              'Lorem ipsum dolor sit amet,\nconsectetur adipisicing. Maxime\ntempore! Animi nemo aut atque\ndeleniti nihil dolorem repellendus'),
          SizedBox(
            height: 46.h,
          ),
          ComonButton(
              title: 'get started',
              onTap: () {
                Get.to(SignUpScreen());
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => LoginScreen()));
              })
        ],
      ),
    );
  }
}
