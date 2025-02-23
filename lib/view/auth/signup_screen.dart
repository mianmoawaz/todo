import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:todo/Constants/app_colors.dart';
import 'package:todo/Constants/app_icons.dart';
import 'package:todo/controller/auth_controller.dart';
import 'package:todo/view/auth/login_screen.dart';
import 'package:todo/view/auth/onboarding.dart';
import 'package:todo/widget/fields/customtextfield.dart';

import '../../widget/button/commonbutton.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AuthController authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: authController.isloading.value,
      child: Scaffold(
          backgroundColor: Color(0xffEDEDED),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 324, top: 32, left: 14),
                    child: GestureDetector(
                        onTap: () {
                          Get.to(Onboarding());
                        },
                        child: Icon(
                          AppIcons.back,
                          size: 40.sp,
                        )),
                  ),
                  SizedBox(
                    height: 79.h,
                  ),
                  Text(
                    'Welcome Onboard!',
                    style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.sp),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Text('Let’s help you meet up your task',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 19.5.sp,
                      )),
                  SizedBox(
                    height: 30.h,
                  ),
                  CommonTextfield(
                      validator: (value) {
                        if (value == '' || value == null) {
                          return 'Please enter your Full Name';
                        }
                        return null;
                      },
                      hintText: 'Enter your Full Name',
                      controller: authController.nameController),
                  SizedBox(
                    height: 25.h,
                  ),
                  CommonTextfield(
                      validator: (value) {
                        if (value == '' || value == null) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      hintText: 'Enter your Email address ',
                      controller: authController.emailController),
                  SizedBox(
                    height: 25.h,
                  ),
                  CommonTextfield(
                      validator: (value) {
                        if (value == '' || value == null) {
                          return 'Please enter Create a Password';
                        }
                        return null;
                      },
                      hintText: 'Create a Password',
                      controller: authController.PasswordController),
                  SizedBox(
                    height: 26.h,
                  ),
                  CommonTextfield(
                      validator: (value) {
                        if (value == '' || value == null) {
                          return 'Please enter Confirm your Password';
                        }
                        return null;
                      },
                      hintText: 'Confirm your Password',
                      controller: authController.ConfirmPasswordController),
                  SizedBox(
                    height: 98.h,
                  ),
                  Obx(
                    () => ComonButton(
                        isLoding: authController.isloading.value,
                        title: 'Sign Up ',
                        onTap: () => authController.signup(_formKey)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 80, top: 40),
                    child: Row(
                      children: [
                        Text('Already have an account ? '),
                        GestureDetector(
                            onTap: () {
                              Get.to(() => LoginScreen());
                              authController.isloading.value = false;
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                  color: AppColors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
