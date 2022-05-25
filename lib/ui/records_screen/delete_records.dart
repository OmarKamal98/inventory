import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/resources/assets_manager.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/styles_manager.dart';
import 'package:lottie/lottie.dart';

class DeletedRecordScreen extends StatelessWidget {
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
            Padding(
              padding:   EdgeInsets.symmetric(horizontal: 20.w),
              child: Text('omar Kamal',style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s20),),

            ),
            SizedBox(height: 10.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text('userdeleteRequest'.tr(),style: getLightStyle(color: ColorManager.black,fontSize: FontSize.s14),),
            ),
            SizedBox(height: 15.h,),
            CategortWidget(),
            SizedBox(height: 15.h,),
            Padding(
              padding:   EdgeInsets.symmetric(horizontal: 20.w),
              child: Text('reason'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s20),),

            ),
            SizedBox(height: 15.h,),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(height: 80.h,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: ColorManager.white3
                  ),
                  child: Text('reson',style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s16),),
                ) ),
            SizedBox(height: 15.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height:40.h,width:145.w,child: ElevatedButton(onPressed: (){}, child: Text('delete'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s16))
                  ,style: ElevatedButton.styleFrom(
                      primary: ColorManager.red,
                      elevation: 1,

                  ),
                )),
                SizedBox(
                    height: 40.h,
                    width:145.w,child: ElevatedButton(onPressed: (){}, child: Text('cancel'.tr(),style: getMediumStyle(color: ColorManager.white,fontSize: FontSize.s16),))),

              ],
            ),
            SizedBox(height: 75.h,),
            Padding(
              padding:  EdgeInsets.only(left: 170.w),
              child: Lottie.asset(
                  'assets/animation/58413-delete-icon-animation.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover
              ),
            )
          ],
        ),
      ),
    );
  }
}


class CategortWidget extends StatelessWidget {
  const CategortWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.h,
      margin: EdgeInsets.symmetric(vertical: 7.5.h,horizontal: 20.w),
      decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 3),
              blurRadius: 6,
              color: Colors.grey.withOpacity(0.16),
            ),
          ]
      ),
      child: Row(children: [
        Container(
          width: 60.w,
          decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius:context.locale==Locale('en')? BorderRadius.only(topLeft: Radius.circular(12.r),bottomLeft: Radius.circular(12.r)):BorderRadius.only(topRight: Radius.circular(12.r),bottomRight: Radius.circular(12.r))
          ),
          child: Center(child: SizedBox(
              width: 30.w,
              height: 30.h,
              child:const Image(image:  AssetImage(ImageAssets.splashLogo),)),),
        ),
        Container(
          width:270.w ,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 7.h,),
              Text('#593265345',style: getLightStyle(color: ColorManager.codeColor),),
              SizedBox(
                height: 35.h,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  Text('categoryname'.tr(),style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                  contenerShow('omar test')
                ],),
              ),
              Spacer(),
              Row(children: [
                Text('categoryname'.tr(),style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                contenerShow('omar test')
              ],),
              SizedBox(height: 20.h,),

            ],),
        )
      ],),
    );
  }
  Widget contenerShow(String detail){
    return  Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Container(height: 25.h,
          width: 120.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: ColorManager.white3
          ),
          child: Center(child: Text(detail,style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s16),)),
        ) );
  }
}
