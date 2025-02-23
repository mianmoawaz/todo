import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo/Constants/app_colors.dart';
import 'package:todo/Constants/app_icons.dart';
import 'package:todo/controller/addtodo_controlller.dart';
import 'package:todo/user/detail_screen.dart';
import 'package:todo/utils/snackbar_util.dart';
import 'package:todo/widget/button/commonbutton.dart';

class Update extends StatefulWidget {
  const Update({super.key});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  AddtodoControlller todocontroller = Get.put(AddtodoControlller());
  RxBool isloading = false.obs;
  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments ?? {};
    titleController.text = arguments['title'] ?? '';
    descriptionController.text = arguments['description'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
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
        Obx(() => ComonButton(
            title: "Update",
            isLoding: todocontroller.isloading.value,
            onTap: () async {
              final String docId = arguments['docid'];
              await todocontroller.Update(
                  docId, titleController, descriptionController);
            }))
      ]),
    );
  }
}
