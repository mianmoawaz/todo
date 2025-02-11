import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo/Constants/app_icons.dart';
import 'package:todo/view/auth/signup_screen.dart';
import 'package:todo/widget/button/commonbutton.dart';
import 'package:todo/widget/fields/customtextfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController namecontroller = TextEditingController();
    final TextEditingController emailcontroller = TextEditingController();
    final TextEditingController passwordcontroller = TextEditingController();
    final TextEditingController confirmpasswordcontroller =
        TextEditingController();
    final _formkey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: const Color(0xffEDEDED),
      body: Form(
        key: _formkey, // Fixed key issue
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60, right: 340, left: 15),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  AppIcons.back,
                  size: 30,
                ),
              ),
            ),
            SizedBox(height: 50.h),
            const Text(
              'Welcome Onboard',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 35.h),
            const Text(
              'Let’s help you meet up your task',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 39.h),
            CommonTextfield(
              hintText: 'Enter your full name',
              controller: namecontroller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            SizedBox(height: 29.h),
            CommonTextfield(
              hintText: 'Enter your email address',
              controller: emailcontroller,
              validator: (value) {
                // Fixed the validator function
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            SizedBox(height: 29.h),
            CommonTextfield(
              hintText: 'Enter your password',
              controller: passwordcontroller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            SizedBox(height: 29.h),
            CommonTextfield(
              hintText: 'Confirm password',
              controller: confirmpasswordcontroller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your confirmpassword';
                }
                return null;
              },
            ),
            SizedBox(height: 95.h),
            ComonButton(
                title: 'signup',
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    Get.to(SignupScreen());
                  }
                }),
          ],
        ),
      ),
    );
  }
}
