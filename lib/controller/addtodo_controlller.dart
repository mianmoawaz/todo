import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/user/addtohome.dart';
import 'package:todo/utils/snackbar_util.dart';

class AddtodoControlller extends GetxController {
  RxBool isloading = false.obs;

  Future addtodo(_formkey, TextEditingController titlecontroller,
      TextEditingController descriptioncontroller) async {
    if (_formkey.currentState!.validate()) {
      try {
        isloading.value = true;

        User? user = FirebaseAuth.instance.currentUser;
        DocumentReference docRef =
            await FirebaseFirestore.instance.collection('todo').doc();
        await docRef.set({
          'docid': docRef.id,
          'title': titlecontroller.text,
          'description': descriptioncontroller.text,
          'time': DateTime.now().toString(),
          "userid": user!.uid.toString()
        });

        isloading.value = false;

        Get.to(Addtohome());
      } catch (e) {
        isloading.value = false;
        Get.snackbar('error', e.toString());
      }
    }
  }

  Future Update(String docid, TextEditingController titlecontroller,
      TextEditingController descriptioncontroller) async {
    try {
      isloading.value = true;
      await FirebaseFirestore.instance.collection('todo').doc(docid).update({
        "title": titlecontroller.text,
        "description": descriptioncontroller.text
      });
      isloading.value = false;
      Get.offAll(Addtohome());
    } catch (e) {
      isloading.value = false;
      SnackbarUtil.showError('error'.toString());
    }
  }
}

Future delete(String docid) async {
  try {
    await FirebaseFirestore.instance.collection('todo').doc(docid).delete();
  } catch (e) {}
}
