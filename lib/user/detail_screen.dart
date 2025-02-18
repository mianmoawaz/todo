import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo/Constants/app_colors.dart';
import 'package:todo/Constants/app_icons.dart';
import 'package:todo/user/addtohome.dart';
import 'package:todo/user/update.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _TitleofyourtasksState();
}

class _TitleofyourtasksState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    return Scaffold(
        backgroundColor: Color(0xffEDEDED),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 60, left: 10),
            child: GestureDetector(
              onTap: () {
                Get.to(Addtohome());
              },
              child: Row(
                children: [
                  Icon(
                    AppIcons.back,
                    size: 30,
                  ),
                  SizedBox(
                    width: 330.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(Update(), arguments: {
                        'title': arguments['title'],
                        'description': arguments['description'],
                        'docid': arguments['docid'],
                      });
                    },
                    child: Icon(
                      AppIcons.edit,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Text(
            arguments['title'],
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
            arguments['description'],
          )
        ]));
  }
}
