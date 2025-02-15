import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo/Constants/app_colors.dart';
import 'package:todo/Constants/app_icons.dart';
import 'package:todo/user/addtodo.dart';
import 'package:todo/user/titleofyourtasks.dart';
import 'package:todo/utils/date_andtime.dart';

class Addtohome extends StatefulWidget {
  const Addtohome({super.key});

  @override
  State<Addtohome> createState() => _AddtohomeState();
}

class _AddtohomeState extends State<Addtohome> {
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
      backgroundColor: Color(0xffEDEDED),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          Column(
            children: [
              Container(
                height: 300.h, // Responsive height
                width: 500.h, // Responsive width
                decoration: BoxDecoration(
                  color: AppColors.green,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.green,
                      radius: 50, // Avatar size
                      backgroundImage: AssetImage(
                        'assets/handsome 2 1.png',
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Welcome Fizayomi',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 250, top: 15),
                      child: Text(
                        'Todo task',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black),
                      ),
                    ),
                    FutureBuilder<QuerySnapshot>(
                      future:
                          FirebaseFirestore.instance.collection('todo').get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.docs.isEmpty) {
                          return Center(child: Text('No tasks available'));
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
                                    color: _getRandomColor(),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      Get.to(Titleofyourtasks());
                                    },
                                    title: Text(
                                      todo['title'] ?? 'No Title',
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    subtitle: Text(
                                      todo['description'] ?? 'No Description',
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    trailing: Text(
                                      DateTimeUtil.formatTime(
                                          todo['time'] ?? ''),
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
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
                height: 650.h,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: AppColors.green,
          child: Center(
            child: Icon(
              Icons.add,
              color: AppColors.white,
            ),
          ),
          onPressed: () {
            Get.to(Addtodo());
          }),
    );
  }
}
