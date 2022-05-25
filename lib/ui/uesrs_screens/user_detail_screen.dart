import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/styles_manager.dart';
class UserDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Column(
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
                    Text('userDetails'.tr(), style: getMediumStyle(
                        color: ColorManager.white, fontSize: FontSize.s22),),
                    const Spacer(),
                  ],), SizedBox(height: 25.h,),],
            ),
          ),
          SizedBox(height: 25.h,),
          Padding(
            padding:   EdgeInsets.symmetric(horizontal: 20.w),
            child: Text('userName'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s18),),
          ),
          contenerShow('omar'),
          Padding(
            padding:   EdgeInsets.symmetric(horizontal: 20.w),
            child: Text('email'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s18),),
          ),
          contenerShow('omar'),
          Padding(
            padding:   EdgeInsets.symmetric(horizontal: 20.w),
            child: Text('phoneNumber'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s18),),
          ),
          contenerShow('omar'),
          Padding(
            padding:   EdgeInsets.symmetric(horizontal: 20.w),
            child: Text('jobTitle'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s18),),
          ),
          contenerShow('omar'),
          Padding(
            padding:   EdgeInsets.symmetric(horizontal: 20.w),
            child: Text('jobID'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s18),),
          ),
          contenerShow('omar'),
          Padding(
            padding:   EdgeInsets.symmetric(horizontal: 20.w),
            child: Text('role'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s18),),
          ),
          contenerShow('omar'),

        ],
      ),
    );

  }
  Widget contenerShow(String detail){
    return  Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 15.h),
        child: Container(height: 40.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: ColorManager.white3
          ),
          child: Center(child: Text(detail,style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s16),)),
        ) );
  }
}

