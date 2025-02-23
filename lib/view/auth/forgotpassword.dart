import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo/Constants/app_icons.dart';
import 'package:todo/controller/auth_controller.dart';
import 'package:todo/view/auth/login_screen.dart';
import 'package:todo/widget/button/commonbutton.dart';
import 'package:todo/widget/fields/customtextfield.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  AuthController authController = Get.put(AuthController());

  final _formkey = GlobalKey<FormState>();
  bool isLodingg = false;

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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60, right: 300),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(LoginScreen());
                    },
                    child: Icon(
                      AppIcons.back,
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(height: 65.h),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Text(
                    textAlign: TextAlign.center,
                    'Forgot password!  ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 35.h),
                Image.asset('assets/Girl and boy sitting with laptop.png'),
                SizedBox(height: 15.h),
                CommonTextfield(
                  hintText: 'Enter your email',
                  controller: authController.emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40.h),
                Obx(
                  () => ComonButton(
                    isLoding: authController.isloading.value,
                    title: 'Reset Password',
                    onTap: () => authController.forgotpassword,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
