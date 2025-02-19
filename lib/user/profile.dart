import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo/Constants/app_colors.dart';
import 'package:todo/view/auth/login_screen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController namecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEDEDED),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
                height: 250,
                width: 400,
                color: AppColors.green, // Direct color use
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 290),
                        child: Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.green,
                            radius: 45,
                            backgroundImage:
                                AssetImage('assets/handsome 2 1.png'),
                          ),
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.withOpacity(0.8),
                            ),
                          ),
                          Icon(Icons.add_photo_alternate,
                              size: 30, color: Colors.white),
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
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Fizyomi',
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
                        readOnly: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'abc@gmail.com',
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
                            onTap: () async {
                              try {
                                await FirebaseAuth.instance.signOut();
                              } catch (e) {
                                print("eroor to signout");
                              }
                              Get.to(LoginScreen());
                            },
                            child: Text('Logout ')),
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
}
