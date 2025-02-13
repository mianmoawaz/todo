import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo/Constants/app_colors.dart';
import 'package:todo/Constants/app_icons.dart';

class Titleofyourtasks extends StatefulWidget {
  const Titleofyourtasks({super.key});

  @override
  State<Titleofyourtasks> createState() => _TitleofyourtasksState();
}

class _TitleofyourtasksState extends State<Titleofyourtasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffEDEDED),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 45, right: 340, left: 15),
            child: GestureDetector(
              onTap: () {
                Get.back();
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Addtohome()));
              },
              child: Icon(
                AppIcons.back,
                size: 30,
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Text(
            'Title of your tasks',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
          Text(
            'It is a long established fact that a reader\n will be distracted by the readable content\n of a page when looking at its layout. The\n point of using Lorem Ipsum is that it has a\n more-or-less normal distribution of letters,\n as opposed to using Content here, content\n here, making it look like readable English.\n Many desktop publishing packages and\n web page editors now use Lorem Ipsum as\n their default model text, and a search for\n lorem ipsum will uncove',
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
          )
        ]));
  }
}
