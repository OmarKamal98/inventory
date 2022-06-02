
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/provider/auth_provider.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/styles_manager.dart';
import 'package:provider/provider.dart';
class CustomTextFeild extends StatelessWidget {
  CustomTextFeild(
      {Key? key, required this.hintText,
        this.validator,
        this.obscureText = false,
        this.keyboardType,
        this.prefixIcon,
        this.suffixIcon,
        this.textInputAction,
        required this.controller,
        this.heightt,
        this.isPassword=false,
      }) : super(key: key);
  TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? heightt;
  final bool? isPassword;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    // TODO: implement build
    return Consumer<AuthProvider>(
      builder: (context,provider,x){
      return SizedBox(
        height: heightt ?? 45.h,
        child: TextFormField(
          minLines:isPassword!?1: null,
          maxLines:isPassword!?1: null,
          expands: isPassword!?false:true,
          autofocus: false,
          obscureText: provider.showPassword &&isPassword!,
          validator: (value) => validator!(value),
          controller: controller,
          focusNode: FocusNode(),
          keyboardType: keyboardType ?? TextInputType.text,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            fillColor: ColorManager.parent,
            filled: true,
            prefixIcon: prefixIcon,
            suffixIcon: isPassword! ?InkWell(onTap: (){
              provider.changeShowPass();
            },child: provider.showPassword?Icon(Icons.remove_red_eye,color: ColorManager.primary,):Icon(Icons.remove_red_eye_outlined,color: ColorManager.primary,),):null,
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
      );}
    );
  }
}
