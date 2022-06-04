import 'dart:async';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/modle/user_model.dart';
import 'package:inventory/provider/auth_provider.dart';
import 'package:inventory/resources/assets_manager.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/router_class.dart';
import 'package:inventory/resources/styles_manager.dart';
import 'package:inventory/ui/auth/Login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed( const Duration(seconds: 3)).then((v) async {
      SharedPreferences? _prefs ;
      _prefs ??= await SharedPreferences.getInstance();
      bool? isLoggedIn = _prefs.getBool('isLogin');
      if(isLoggedIn ==true){
        String? username=_prefs.getString('userName');
        String? password=_prefs.getString('password');
        LoginData loginData=LoginData(userName: username, password: password);
        Provider.of<AuthProvider>(context,listen: false).login(loginData);
      }else{
        RouterClass.routerClass.pushWidgetReplacement(LoginScreen());
      }

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
              ],
            ),
          ),],
      ),
    );
  }
}
