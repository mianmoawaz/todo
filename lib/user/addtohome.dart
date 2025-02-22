import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo/Constants/app_colors.dart';
import 'package:todo/user/addtodo.dart';
import 'package:todo/user/detail_screen.dart';
import 'package:todo/user/profile.dart';
import 'package:todo/utils/date_andtime.dart';
import 'package:todo/utils/loading_util.dart';

class Addtohome extends StatefulWidget {
  const Addtohome({super.key});

  @override
  State<Addtohome> createState() => _AddtohomeState();
}

final String userid = FirebaseAuth.instance.currentUser!.uid;

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
                height: 300.h,
                width: 500.h, // Responsive width
                decoration: BoxDecoration(
                  color: AppColors.green,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('userInfo')
                            .doc(userid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return LoadingUtil.shimmerTile(itemcount: 6);
                          } else if (!snapshot.hasData ||
                              snapshot.data!['name'] == '') {
                            return Text('Todo is not added');
                          } else {
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => Profile(), arguments: {
                                  'name': snapshot.data!['name'],
                                  'image': snapshot.data!['image'],
                                  'userid': snapshot.data!['userid'],
                                  'email': snapshot.data!['email'],
                                });
                              },
                              child: Column(
                                children: [
                                  Positioned(
                                    bottom: 120.h,
                                    child: CircleAvatar(
                                      radius: 50.r,
                                      backgroundColor: Color(0xff70968f),
                                      backgroundImage:
                                          NetworkImage(snapshot.data!['image']),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 0),
                                    child: Text(
                                      " ${snapshot.data!['name']}",
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.sp,
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        }),
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
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('todo')
                          .where('userid', isEqualTo: userid)
                          .snapshots(),
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
                                      Get.to(DetailScreen(), arguments: {
                                        'title': snapshot.data!.docs[index]
                                            ['title'],
                                        'description': snapshot
                                            .data!.docs[index]['description'],
                                        'docid': snapshot.data!.docs[index]
                                            ['docid'],
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
                                      snapshot.data!.docs[index]['title'],
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    subtitle: Text(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      snapshot.data!.docs[index]['description'],
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
