import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo/Constants/app_colors.dart';
import 'package:todo/Constants/app_icons.dart';
import 'package:todo/user/addtodo.dart';
import 'package:todo/user/detail_screen.dart';
import 'package:todo/utils/date_andtime.dart';
import 'package:todo/view/auth/login_screen.dart';
import 'package:todo/widget/button/commonbutton.dart';
import 'package:todo/widget/fields/customtextfield.dart';

class Practice extends StatefulWidget {
  const Practice({super.key});

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final isloading = false;
  final Random _random = Random();

  Color _getRandomColor() {
    List<Color> colors = [
      AppColors.list3,
      AppColors.list2,
      AppColors.list1,
    ];
    return colors[_random.nextInt(colors.length)];
  }

  String _getRandomTime() {
    int hour = _random.nextInt(12) + 1;
    int minute = _random.nextInt(60);
    String period = _random.nextBool() ? 'AM' : 'PM';
    return '$hour:${minute.toString().padLeft(2, '0')} $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60, right: 300),
              child: GestureDetector(
                onTap: () {
                  Get.to(Addtodo());
                },
                child: Icon(
                  AppIcons.back,
                  size: 30,
                ),
              ),
            ),
            Text(
              'Firebase practice',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 40.h,
            ),
            CommonTextfield(
                hintText: 'enter youe email',
                controller: emailcontroller,
                validator: (Value) {
                  if (Value == null || Value.isEmpty) {
                    return 'please enter your email';
                  }
                  return null;
                }),
            SizedBox(
              height: 30.h,
            ),
            CommonTextfield(
              hintText: 'password',
              controller: passwordcontroller,
              validator: (Value) {
                if (Value == null || Value.isEmpty) {
                  return 'please enter password';
                }
                return null;
              },
            ),
            CommonTextfield(
                hintText: 'name',
                controller: namecontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter your name';
                  }
                  return null;
                }),
            SizedBox(
              height: 20.h,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('todo').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No task available'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, index) {
                      var todo = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: (_getRandomColor()),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            onTap: () async {
                              Get.to(DetailScreen(), arguments: {
                                'title': snapshot.data!.docs[index]['title'],
                                'description': snapshot.data!.docs[index]
                                    ['description'],
                              });
                            },
                            leading: GestureDetector(
                              onTap: () async {
                                final String docid = snapshot
                                    .data!.docs[index]['docid']
                                    .toString();
                                await FirebaseFirestore.instance
                                    .collection('todo')
                                    .doc(docid)
                                    .delete();
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.red,
                                child: Icon(Icons.delete),
                              ),
                            ),
                            title: Text(
                              todo['title'],
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              todo['description'],
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            trailing: Text(
                              DateTimeUtil.formatTime(todo['time']),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
            ComonButton(
                isLoding: isloading,
                title: 'next',
                onTap: () async {
                  if (_formkey.currentState!.validate()) {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: emailcontroller.text,
                        password: passwordcontroller.text);
                    Get.to(LoginScreen());
                  }
                })
          ],
        ),
      ),
    );
  }
}
