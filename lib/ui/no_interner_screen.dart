import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/styles_manager.dart';
import 'package:lottie/lottie.dart';

class NOInternerScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 80.h,),
        Center(child: Text('No Internet Conncetion',style: getMediumStyle(color: ColorManager.white,fontSize: FontSize.s18),)),
          SizedBox(height: 50.h,),
          Stack(
            children: [
             Positioned(
               top: 50.h,
               right: 0,
               bottom: 0,
               left: 0,
               child: Lottie.asset(
                    'assets/animation/12955-no-internet-connection-empty-state.json',
                    width: 200,
                    height: 520.h,
                    fit: BoxFit.cover

                ),
             ), Row(
                children: [
                  Spacer(),
                  Lottie.asset(
                      'assets/animation/105345-setting-animation.json',
                      width: 180.w,
                      height: 105.h,
                      fit: BoxFit.cover

                  ),
                ],
              ),],

          ),
       ],),
    );
  }
}
