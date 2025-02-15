import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo/Constants/app_colors.dart';
import 'package:todo/Constants/app_icons.dart';
import 'package:todo/user/addtohome.dart';
import 'package:todo/view/auth/login_screen.dart';
import 'package:todo/widget/button/commonbutton.dart';
import 'package:todo/widget/fields/customtextfield.dart';

class Addtodo extends StatefulWidget {
  const Addtodo({super.key});

  @override
  State<Addtodo> createState() => _AddtodoState();
}

class _AddtodoState extends State<Addtodo> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController titlecontroller = TextEditingController();
    final TextEditingController descriptioncontroller = TextEditingController();
    final _formkey = GlobalKey<FormState>();
    bool isLoding = false;
    return Scaffold(
        backgroundColor: Color(0xffEDEDED),
        body: Form(
            key: _formkey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 45, right: 340, left: 15),
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
                SizedBox(
                  height: 65.h,
                ),
                Text(
                  textAlign: TextAlign.center,
                  'Add new todo!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 45.h,
                ),
                Image.asset('assets/Girl and boy sitting with laptop.png'),
                SizedBox(
                  height: 41.h,
                ),
                Text(
                  'Add What your want to do later on..',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.green),
                ),
                SizedBox(
                  height: 41.h,
                ),
                CommonTextfield(
                  hintText: 'title',
                  controller: titlecontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your title';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 26.h,
                ),
                CommonTextfield(
                  hintText: 'description',
                  controller: descriptioncontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your description';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 45.h,
                ),
                ComonButton(
                    isLoding: isLoding,
                    title: 'Add to list ',
                    onTap: () async {
                      if (_formkey.currentState!.validate()) {
                        try {
                          setState(() {
                            isLoding = true;
                          });
                          User? user = FirebaseAuth.instance.currentUser;
                          DocumentReference docRef = FirebaseFirestore.instance
                              .collection('todo')
                              .doc();
                          await docRef.set({
                            'docid': docRef.id,
                            'title': titlecontroller.text,
                            'description': descriptioncontroller.text,
                            'time': DateTime.now(),
                            "userid": user!.uid.toString()
                          });
                          setState(() {
                            isLoding = false;
                          });
                          Get.to(Addtohome());
                        } catch (e) {
                          Get.snackbar('error', e.toString());
                          setState(() {
                            isLoding = false;
                          });
                        }
                      }
                    }),
              ]),
            )));
  }
}
