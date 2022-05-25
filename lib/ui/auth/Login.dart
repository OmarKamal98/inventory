import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inventory/resources/assets_manager.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/styles_manager.dart';
import 'package:inventory/ui/component/text_field.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController userNameController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
     body: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Container(
         height: 320.h,
         width: MediaQuery.of(context).size.width,
         decoration: BoxDecoration(
           color: ColorManager.primary,
         ),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             SizedBox(
                 width: 76.w,
                 height: 81.h,
                 child:const Image(image: AssetImage(ImageAssets.splashLogo))),
             SizedBox(height: 20.h,),
             Text('inventory'.tr(),style: getBoldStyle(color: ColorManager.white,fontSize: FontSize.s20),),
           ],
         ),
       ),
       Padding(padding: EdgeInsets.only(left: 20.w,top: 20.h,right:20.w),
       child: Text('login'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s20),),

       ),
         SizedBox(height: 35.h,),
         Padding(
           padding:   EdgeInsets.symmetric(horizontal: 50.w),
           child: CustomTextFeild(hintText: 'userName'.tr(), controller: userNameController,
           prefixIcon: Padding(
             padding:   EdgeInsets.all(12.w),
             child: SvgPicture.asset(
               IconAssets.username,
             ),
           ),),
         ),
         SizedBox(height: 15.h,),
         Padding(
           padding:   EdgeInsets.symmetric(horizontal: 50.w),
           child: CustomTextFeild(hintText: 'password'.tr(), controller: passwordController,
             prefixIcon: Padding(
               padding: EdgeInsets.all(12.w),
               child: SvgPicture.asset(
                 IconAssets.password,
               ),
             ),
           ),
         ),
         SizedBox(height: 35.h,),
         Center(
           child: SizedBox(
               width:270.w ,
               height: 40.h,
               child: ElevatedButton(onPressed: (){}, child: Text('login'.tr()))),
         )
,

       ],
     ),
    );
  }
}
