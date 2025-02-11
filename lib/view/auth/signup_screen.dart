import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo/Constants/app_colors.dart';
import 'package:todo/Constants/app_icons.dart';
import 'package:todo/Constants/app_images.dart';
import 'package:todo/user/addtodo.dart';
import 'package:todo/view/auth/forgotpassword.dart';
import 'package:todo/view/auth/login_screen.dart';
import 'package:todo/widget/button/commonbutton.dart';
import 'package:todo/widget/fields/customtextfield.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailcontroller = TextEditingController();
    final TextEditingController confirmpasswordcontroller =
        TextEditingController();
    final _formkey = GlobalKey<FormState>();
    return Scaffold(
        backgroundColor: Color(0xffEDEDED),
        body: Form(
            key: _formkey, // Fixed key issue
            child: Column(children: [
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
                controller: emailcontroller,
                validator: (value) {
                  // Fixed the validator function
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
                controller: confirmpasswordcontroller,
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
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Forgotpassword()));
                },
                child: Text(
                  'Forgot Password ?',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.green),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              ComonButton(
                  title: 'sign in',
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      Get.to(Addtodo());
                    }
                  }),
              Row(
                children: [
                  Text(
                    '                       Dont have an account ?',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black),
                  ),
                  SizedBox(
                    height: 41.h,
                  ),
                  Text(
                    'sign up',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.green),
                  ),
                ],
              )
            ])));
  }
}
