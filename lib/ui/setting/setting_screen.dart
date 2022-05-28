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
        child: Consumer<AuthProvider>(
        builder: (context,provider,x){
         return Column(
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
                   const Spacer(),
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: MediaQuery.of(context).size.width,
                height: 50.h,
                decoration: BoxDecoration(
                    color: ColorManager.white3,
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 3),
                          blurRadius: 6,
                          color: ColorManager.black.withOpacity(.16)
                      )
                    ]
                ),
                child: DropdownButton(
                    icon: Icon(Icons.keyboard_arrow_down,size: 32,color: ColorManager.black,),
                    hint: Row(
                      children: [
                        const Icon(Icons.language,size: 32,),
                        SizedBox(width: 15.w,),
                        Text('language'.tr(),style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s16),),
                        SizedBox(width: 165.w,),
                      ],
                    ),
                    items:const [
                      DropdownMenuItem(
                        alignment: Alignment.center,
                        value:1,
                        child: Text( 'English'),),
                      DropdownMenuItem(
                        alignment: Alignment.center,
                        value: 2,
                        child: Text( 'العربية' ),)
                    ],
                    onChanged: (v)  {
                      if(v==1){
                        provider.changeEnglish(context);
                      }else{
                        provider.changeArabic(context);
                      }

                    }),
              ),
              SizedBox(height: 450.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50.h,
                  child: ElevatedButton(
                      onPressed: () {
                        Provider.of<AuthProvider>(context,listen: false).logOut();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('logout'.tr(),style: getRegularStyle(color: ColorManager.white,fontSize: FontSize.s16),),
                        SizedBox(width: 15.w,),
                        const Icon(Icons.logout),  ],
                      )),
                ),
              ),
            ],
          );}
        ),
      ),
    );
  }
}

