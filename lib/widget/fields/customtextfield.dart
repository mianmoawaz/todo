import 'package:flutter/material.dart';
import 'package:todo/Constants/app_colors.dart';

class CommonTextfield extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator; // Validator Function Added

  const CommonTextfield({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator, // Validator Parameter
  });

  @override
  State<CommonTextfield> createState() => _CommonTextfieldState();
}

class _CommonTextfieldState extends State<CommonTextfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 17),
      child: TextFormField(
        // Changed from TextField to TextFormField
        controller: widget.controller,
        enabled: true,
        validator: widget.validator, // Apply Validator Function
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontFamily: "font",
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.white, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.white, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.white, width: 2),
          ),
          contentPadding: EdgeInsets.all(15),
        ),
      ),
    );
  }
}
