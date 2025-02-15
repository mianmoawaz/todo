import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo/Constants/app_icons.dart';
import 'package:todo/user/addtodo.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
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
            ComonButton(
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
