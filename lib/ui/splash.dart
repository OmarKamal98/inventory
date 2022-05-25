import 'dart:async';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/resources/assets_manager.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/styles_manager.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Timer(const Duration(seconds: 3), () async {

    });
    return Scaffold(
      backgroundColor: ColorManager.primary ,
      body: Stack(
        children: [
          Container(
          decoration:  const BoxDecoration(
            image:  DecorationImage(
              image:  ExactAssetImage(ImageAssets.splashback),
              fit: BoxFit.contain,
            ),
          ),
          child:  BackdropFilter(
            filter:  ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
            child:  Container(
              decoration:  BoxDecoration(color: Colors.white.withOpacity(0.0)),
            ),
          ),
        ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: 125.w,
                    height: 133.h,
                    child:const Image(image: AssetImage(ImageAssets.splashLogo))),
             SizedBox(height: 25.h,),
                  Text('inventory'.tr(),style: getBoldStyle(color: ColorManager.white,fontSize: FontSize.s20),),
                // ElevatedButton(
                //     onPressed: () {
                //       context.setLocale(const Locale('ar'));
                //     },
                //     child: Text("Change to ar Language")),
                //
                // ElevatedButton(
                //     onPressed: () {
                //       context.setLocale(const Locale('en'));
                //     },
                //     child: Text("Change to English Language")),
                // RaisedButton(
                //   onPressed: (){
                //     context.resetLocale();
                //   },
                //   child: Text('LocaleKeys.reset_locale').tr(),
                // )
              ],
            ),
          ),],
      ),
    );
  }
}
