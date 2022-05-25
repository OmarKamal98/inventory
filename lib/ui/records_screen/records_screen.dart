import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/router_class.dart';
import 'package:inventory/resources/styles_manager.dart';
import 'package:inventory/ui/records_screen/edit_record_screen.dart';

class RecordsScreen extends StatelessWidget {
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
                    Text('records'.tr(), style: getMediumStyle(
                        color: ColorManager.white, fontSize: FontSize.s22),),
                    const Spacer(),
                  ],), SizedBox(height: 25.h,),],
            ),
          ),
          SizedBox(height: 25.h,),
          Expanded(child: ListView.builder(
            padding: EdgeInsets.zero,
              itemCount: 10,
              itemBuilder: (context, index) {
            return recordsWidget();
          })),


        ],
      ),
    );

  }
  Widget recordsWidget(){

    return InkWell(
      onTap: (){
        RouterClass.routerClass.pushWidget(EditRecordsScreen());
      },
      child: Container(
        height: 70.h,
        width: 335.w,
        padding: EdgeInsets.all(15.w),
        margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 15.h),
        decoration: BoxDecoration(
          color: ColorManager.white3,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow:[
            BoxShadow(
              offset: const Offset(0, 3),
              blurRadius: 6,
              color: Colors.grey.withOpacity(0.16),
            ),
          ],
        ),
        child: RichText(
          text:    TextSpan(
            children: <TextSpan>[
                TextSpan(
                  text: 'Ahmed Kamel ',
                  style:  getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14)),
                  TextSpan(
                  text: ', this user has requested to',
                  style:  getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14)),
                  TextSpan(
                  text: ' Edit',
                  style:  getMediumStyle(color: ColorManager.recordEite,fontSize: FontSize.s14)),
              TextSpan(
                  text: '\n the category',
                  style:  getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14)),

            ],
          ),
        ),
      ),
    );
  }

}

