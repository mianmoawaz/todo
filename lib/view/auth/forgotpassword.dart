import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo/Constants/app_colors.dart';
import 'package:todo/Constants/app_icons.dart';
import 'package:todo/utils/snackbar_util.dart'; // Import SnackbarUtil
import 'package:todo/view/auth/login_screen.dart';
import 'package:todo/widget/button/commonbutton.dart';
import 'package:todo/widget/fields/customtextfield.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  final TextEditingController emailcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool isLodingg = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEDEDED),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60, right: 300),
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
              SizedBox(height: 65.h),
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Text(
                  textAlign: TextAlign.center,
                  'Forgot password!  ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 35.h),
              Image.asset('assets/Girl and boy sitting with laptop.png'),
              SizedBox(height: 15.h),
              CommonTextfield(
                hintText: 'Enter your email',
                controller: emailcontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 40.h),
              ComonButton(
                title: 'Reset Password',
                onTap: () async {
                  if (_formkey.currentState!.validate()) {
                    try {
                      setState(() {
                        isLodingg = true;
                      });

                      await FirebaseAuth.instance.sendPasswordResetEmail(
                        email: emailcontroller.text,
                      );

                      setState(() {
                        isLodingg = false;
                      });

                      SnackbarUtil.showSuccess(
                          "Password reset email sent successfully!");
                      Get.to(LoginScreen());
                    } on FirebaseAuthException catch (e) {
                      setState(() {
                        isLodingg = false;
                      });

                      SnackbarUtil.showError(e.message ?? "An error occurred");
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
