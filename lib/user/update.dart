import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo/Constants/app_colors.dart';
import 'package:todo/Constants/app_icons.dart';
import 'package:todo/user/detail_screen.dart';
import 'package:todo/widget/button/commonbutton.dart';

class Update extends StatefulWidget {
  const Update({super.key});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool isloadingg = false;
  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments ?? {};
    titleController.text = arguments['title'] ?? '';
    descriptionController.text = arguments['description'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEDEDED),
      body: Column(children: [
        Padding(
            padding: const EdgeInsets.only(top: 60, right: 300),
            child: GestureDetector(
              onTap: () {
                Get.to(DetailScreen());
              },
              child: Icon(
                AppIcons.back,
                size: 30,
              ),
            )),
        SizedBox(
          height: 30.h,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: "Enter text here...",
              border: InputBorder.none,
            ),
          ),
        ),
        SizedBox(
          height: 14.h,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Divider(
            thickness: 2,
            color: AppColors.green,
          ),
        ),
        SizedBox(
          height: 29.h,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              hintText: "Enter text here...",
              border: InputBorder.none,
            ),
          ),
        ),
        ComonButton(
            title: "Update",
            isLoding: isloadingg,
            onTap: () async {
              final arguments = Get.arguments;
              final String docid = arguments['docid'];
              Update(docid);
            })
      ]),
    );
  }

  Future Update(String docId) async {
    try {
      setState(() {
        isloadingg = true;
      });
      await FirebaseFirestore.instance.collection('todo').doc(docId).update({
        "title": titleController.text,
        "description": descriptionController.text
      });
      setState(() {
        isloadingg = false;
      });
      Get.back();
    } catch (e) {
      Get.snackbar('error', e.toString());
    }
  }
}
