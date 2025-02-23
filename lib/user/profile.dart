import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo/Constants/app_colors.dart';
import 'package:todo/controller/auth_controller.dart';
import 'package:todo/utils/snackbar_util.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  AuthController authController = Get.put(AuthController());

  final String userid = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments ?? {};

    authController.nameController.text = arguments['name'] ?? '';
    authController.emailController.text = arguments['email'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    return Scaffold(
      backgroundColor: Color(0xffEDEDED),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
                height: 250,
                width: 400,
                color: AppColors.green,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 290),
                        child: GestureDetector(
                          onTap: () {
                            updateUserName();
                          },
                          child: Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50.r,
                            backgroundColor: AppColors.green,
                            backgroundImage:
                                NetworkImage(arguments['profileImage']),
                          ),
                          // CircleAvatar(
                          //   radius: 50.r,
                          //   backgroundColor: AppColors.white.withOpacity(.5),
                          //   child: Center(
                          //     child: Icon(Icons.add_photo_alternate,
                          //         size: 30, color: AppColors.white),
                          //   ),
                          // ),
                        ],
                      ),
                    ])),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 260, top: 10),
                    child: Text(
                      'edit text',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.green),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      height: 55,
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: authController.nameController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '',
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Icon(Icons.edit),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      height: 55,
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: authController.emailController,
                        readOnly: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 260),
                    child: Text('more',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.green)),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Image.asset('assets/privacy-policy.png'),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Privacy Policy')
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Image.asset('assets/terms-and-conditions 2.png'),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text('Terms & Conditions'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Image.asset('assets/logout.png'),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () => authController.logout(),
                          child: Text('Logout'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              height: 650,
              width: 400,
              decoration: BoxDecoration(
                color: Color(0xffEDEDED),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future updateUserName() async {
    try {
      await FirebaseFirestore.instance
          .collection('userInfo')
          .doc(userid)
          .update({'name': authController.nameController.text});
      Get.back();
    } catch (e) {
      SnackbarUtil.showError('error');
    }
  }
}
