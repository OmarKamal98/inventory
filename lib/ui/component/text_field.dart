
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/styles_manager.dart';
class CustomTextFeild extends StatelessWidget {
  CustomTextFeild(
      {required this.hintText,
        this.validator,
        this.obscureText = false,
        this.keyboardType,
        this.prefixIcon,
        this.textInputAction,
        required this.controller,
        this.heightt});
  TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final double? heightt;

  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    // TODO: implement build
    return SizedBox(
      height: heightt ?? 45.h,
      child: TextFormField(
        minLines: null,
        maxLines: null,
        expands: true,
        autofocus: false,
        validator: (value) => validator!(value),
        controller: controller,
        focusNode: FocusNode(),
        keyboardType: keyboardType ?? TextInputType.text,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          fillColor: ColorManager.parent,
          filled: true,

          prefixIcon: prefixIcon,
          contentPadding:
          EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          labelStyle:
          getLightStyle(color: ColorManager.black.withOpacity(0.27), fontSize: FontSize.s14),
          errorStyle: const TextStyle(height: 0, color: Colors.transparent),
          hintText: hintText,
          hintStyle:  getLightStyle(color: ColorManager.black.withOpacity(0.27), fontSize: FontSize.s14),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
              borderSide:
                BorderSide(color: ColorManager.primary, width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
              borderSide:
                BorderSide(color: ColorManager.primary, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
              borderSide:
                BorderSide(color: ColorManager.primary, width: 1)),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            borderSide: BorderSide(color: ColorManager.red, width: 1),
          ),
        ),
      ),
    );
  }
}
