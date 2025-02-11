import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo/Constants/app_icons.dart';
import 'package:todo/user/addtodo.dart';
import 'package:todo/view/auth/signup_screen.dart';
import 'package:todo/widget/button/commonbutton.dart';
import 'package:todo/widget/fields/customtextfield.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  final TextEditingController forgotcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffEDEDED),
        body: Form(
          key: _formkey,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 60, right: 340, left: 15),
              child: GestureDetector(
                onTap: () {
                  Get.to(SignupScreen());
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupScreen()));
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
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Text(
                textAlign: TextAlign.center,
                'Forgot password!  ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 35.h,
            ),
            Image.asset('assets/Girl and boy sitting with laptop.png'),
            SizedBox(
              height: 15.h,
            ),
            CommonTextfield(
              hintText: 'forgot password',
              controller: forgotcontroller,
              validator: (value) {
                // Fixed the validator function
                if (value == null || value.isEmpty) {
                  return 'Please enter your forgot password';
                }
                return null;
              },
            ),
            SizedBox(
              height: 40.h,
            ),
            ComonButton(
                title: 'forgot password',
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    Get.to(Addtodo());
                  }
                }),
          ]),
        ));
  }
}
