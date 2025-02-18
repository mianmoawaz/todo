import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:todo/Constants/app_colors.dart';
import 'package:todo/Constants/app_icons.dart';
import 'package:todo/user/addtohome.dart';
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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();
  final TextEditingController ConfirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 244, 243, 243),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 324, top: 32, left: 14),
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
                    controller: nameController),
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
                    controller: emailController),
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
                    controller: PasswordController),
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
                    controller: ConfirmPasswordController),
                SizedBox(
                  height: 98.h,
                ),
                ComonButton(
                  isLoding: isLoading,
                  title: 'Sign Up ',
                  onTap: () => signup(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 80, top: 40),
                  child: Row(
                    children: [
                      Text('Already have an account ? '),
                      GestureDetector(
                          onTap: () {
                            Get.to(() => LoginScreen());
                            setState(() {
                              isLoading = false;
                            });
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
        ));
  }

  Future signup() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: PasswordController.text,
        );
        User? user = FirebaseAuth.instance.currentUser;
        DocumentReference docRef =
            FirebaseFirestore.instance.collection('userInfo').doc();
        await docRef.set({
          'email': emailController.text,
          'name': nameController.text,
          'password': PasswordController.text
        });

        Get.to(() => Addtohome());
      } catch (e) {
        Get.snackbar('Error ', e.toString());
      }
    }
  }
}
