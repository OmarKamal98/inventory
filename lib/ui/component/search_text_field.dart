import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inventory/resources/assets_manager.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/styles_manager.dart';

import '../../resources/font_manager.dart';
class CustomSearchField extends StatelessWidget {
  CustomSearchField(
      {required this.onChanged,
        required this.sortFunction,
        this.validator,
        required this.controller});
  TextEditingController controller;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;
  final Function() sortFunction;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,designSize: const Size(375, 812),);
    return Container(
      height: 40.h,
      decoration: BoxDecoration(color: ColorManager.parent),
      child: TextField(
        focusNode:FocusNode() ,
        controller: controller,
        onChanged: onChanged,
        textInputAction:TextInputAction.done ,
        keyboardType:TextInputType.text,
        textAlignVertical: TextAlignVertical.bottom,
        style : getMediumStyle(color: ColorManager.black,fontSize: FontSize.s16 ),
        decoration: InputDecoration(
          fillColor:  ColorManager.white.withOpacity(.74) ,
          filled: true,
          contentPadding: EdgeInsets.only(bottom: 12.h),
          hintText: 'searchbyin'.tr(),
          hintStyle: getLightStyle(color: Colors.grey ,fontSize: FontSize.s13),
          prefixIcon:Container(
              width: 43.w,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius:context.locale==Locale('en')? BorderRadius.only(topLeft: Radius.circular(10.r),bottomLeft:Radius.circular(10.r) ):BorderRadius.only(topRight: Radius.circular(10.r),bottomRight:Radius.circular(10.r) ),
              ),
          child:const Image(image: AssetImage(ImageAssets.splashLogo),),),
          suffixIcon: Container(
              width: 43.w,
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius:context.locale!=Locale('en')? BorderRadius.only(topLeft: Radius.circular(10.r),bottomLeft:Radius.circular(10.r) ):BorderRadius.only(topRight: Radius.circular(10.r),bottomRight:Radius.circular(10.r) ),
              ),
              child: const Icon(Icons.search)),
          enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              borderSide:   BorderSide(color: ColorManager.white, width: 0)
          ),
          focusedBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              borderSide:   BorderSide(color: ColorManager.white, width: 0)
          ),

        ),
      ) );
  }
}