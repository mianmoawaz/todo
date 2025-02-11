import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/Constants/app_colors.dart';

class ComonButton extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const ComonButton({super.key, required this.title, required this.onTap});

  @override
  State<ComonButton> createState() => _ComonButtonState();
}

class _ComonButtonState extends State<ComonButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
          child: Center(
            child: Text(
              widget.title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white),
            ),
          ),
          height: 44.h,
          width: 200,
          decoration: BoxDecoration(color: AppColors.green)),
    );
  }
}
