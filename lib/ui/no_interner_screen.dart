import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/styles_manager.dart';

class NOInternerScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Column(
        children: [
          SizedBox(height: 80.h,),
        Center(child: Text('No Internet Conncetion',style: getMediumStyle(color: ColorManager.white,fontSize: FontSize.s18),))
       ],),
    );
  }
}
