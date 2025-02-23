import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/Constants/app_colors.dart';
import 'package:todo/model/user_model.dart';
import 'package:todo/user/addtohome.dart';
import 'package:todo/utils/snackbar_util.dart';
import 'package:todo/view/auth/login_screen.dart';

class AuthController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();
  final TextEditingController ConfirmPasswordController =
      TextEditingController();

  RxBool isloading = false.obs;

  Future signup(formkey) async {
    if (formkey.currentState!.validate()) {
      try {
        isloading.value = true;
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: PasswordController.text,
        );

        final String userid = await FirebaseAuth.instance.currentUser!.uid;
        DocumentReference docRef =
            FirebaseFirestore.instance.collection('userInfo').doc(userid);

        UserModel userModel = UserModel(
            userId: userid,
            name: nameController.text,
            email: emailController.text,
            profileImage: '');

        await docRef.set(userModel.toFirestore());
        isloading.value = false;
        Get.to(() => Addtohome());
      } catch (e) {
        Get.snackbar('Error ', e.toString());
        isloading.value = false;
      }
    }
  }

  Future login(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      try {
        isloading.value = true;

        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: PasswordController.text,
        );

        SnackbarUtil.showSuccess("Login Successful!");

        Get.to(() => Addtohome());
      } on FirebaseAuthException catch (e) {
        Get.snackbar('Error', e.message ?? "Login failed!",
            backgroundColor: AppColors.red);
      } finally {
        isloading.value = false;
      }
    }
  }

  Future forgotpassword(GlobalKey<FormState> _formkey,
      TextEditingController emailcontroller) async {
    if (_formkey.currentState!.validate()) {
      try {
        isloading.value = true;
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text,
        );

        SnackbarUtil.showSuccess("Password reset email sent successfully!");
        Get.to(LoginScreen());
      } on FirebaseAuthException catch (e) {
        SnackbarUtil.showError(e.message ?? "An error occurred");
      }
    }
  }

  Future logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => LoginScreen());
      SnackbarUtil.showSuccess("Logout Successful!");
    } catch (e) {
      SnackbarUtil.showError("Error logging out: ${e.toString()}");
    }
  }
}
