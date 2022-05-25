import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/provider/auth_provider.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/styles_manager.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 105.h,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.circular(15.r)
              ),
              child: Column(
                children: [
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back_ios,color: ColorManager.white,size: 20,),
                      SizedBox(width: 15.w,),
                      Text('settings'.tr(), style: getMediumStyle(
                          color: ColorManager.white, fontSize: FontSize.s22),),
                      const Spacer(),
                    ],), SizedBox(height: 25.h,),],
              ),
            ),
            SizedBox(height: 25.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 150.w,
                  child: ElevatedButton(
                      onPressed: () {
                        context.setLocale(const Locale('ar'));
                      },
                      child: Text('arabic'.tr())),
                ),
                SizedBox(
                  width: 150.w,
                  child: ElevatedButton(
                      onPressed: () {
                        context.setLocale(const Locale('en'));
                      },
                      child:  Text('english'.tr())),
                ),
              ],
            ),
            SizedBox(height: 50.h,),
            Center(
              child: SizedBox(
                width: 250.w,
                child: ElevatedButton(
                    onPressed: () {
                      Provider.of<AuthProvider>(context,listen: false).logOut();
                    },
                    child: Text('Logout')),
              ),
            ),



          ],
        ),
      ),
    );
  }
}

