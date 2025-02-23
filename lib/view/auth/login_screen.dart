import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo/Constants/app_colors.dart';
import 'package:todo/Constants/app_icons.dart';
import 'package:todo/Constants/app_images.dart';
import 'package:todo/controller/auth_controller.dart';
import 'package:todo/view/auth/forgotpassword.dart';
import 'package:todo/view/auth/signup_screen.dart';
import 'package:todo/widget/button/commonbutton.dart';
import 'package:todo/widget/fields/customtextfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController authController = Get.put(AuthController());
  RxBool isloading = false.obs;

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: authController.isloading.value,
      child: Scaffold(
          backgroundColor: Color(0xffEDEDED),
          body: Form(
              key: _formkey,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60, right: 300),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(SignUpScreen());
                      },
                      child: Icon(
                        AppIcons.back,
                        size: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'Welcome Back!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 35.h,
                  ),
                  Image.asset(AppImages.young),
                  SizedBox(
                    height: 15.h,
                  ),
                  CommonTextfield(
                    hintText: 'Enter your email address',
                    controller: authController.emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 29.h,
                  ),
                  CommonTextfield(
                    hintText: 'Confirm password',
                    controller: authController.PasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your confirmpassword';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(Forgotpassword());
                    },
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.green),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Obx(
                    () => ComonButton(
                      isLoding: authController.isloading.value,
                      title: 'sign in',
                      onTap: () => authController.login(_formkey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 80),
                    child: Row(
                      children: [
                        Text(
                          'Dont have an account ?',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black),
                        ),
                        SizedBox(
                          height: 41.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(SignUpScreen());
                          },
                          child: Text(
                            'sign up',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: AppColors.green),
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ))),
    );
  }
}
