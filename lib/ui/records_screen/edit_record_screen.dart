import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/styles_manager.dart';

class EditRecordsScreen extends StatelessWidget {
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
                      Text('editRecords'.tr(), style: getMediumStyle(
                          color: ColorManager.white, fontSize: FontSize.s22),),
                      const Spacer(),
                    ],),
                  SizedBox(height: 25.h,),],
              ),
            ),
            SizedBox(height: 25.h,),
            Padding(
              padding:   EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(children: [
                Text('omar Kamal',style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s20),)
              ,const Spacer(),
                TextButton(onPressed: (){}, child: Text('editRequest'.tr(),style: getRegularStyle(color: ColorManager.recordEite,fontSize: FontSize.s14),))
              ],),

            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text('usereditRequest'.tr(),style: getLightStyle(color: ColorManager.black,fontSize: FontSize.s14),),
            ),


            // Expanded(child: ListView.builder(
            //     padding: EdgeInsets.zero,
            //     itemCount: 10,
            //     itemBuilder: (context, index) {
            //       return recordsWidget();
            //     })),
            editWidget(),
           Padding(
             padding:   EdgeInsets.symmetric(horizontal: 20.w),
             child: Text('toBecome'.tr(),style: getLightStyle(color: ColorManager.black,fontSize: FontSize.s12),),
           ),editWidget(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  height: 40.h,
                  width:134.w,child: ElevatedButton(onPressed: (){}, child: Text('acceptChanges'.tr(),style: getMediumStyle(color: ColorManager.white,fontSize: FontSize.s16),))),
              SizedBox(height:40.h,width:134.w,child: ElevatedButton(onPressed: (){}, child: Text('decline'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s16))
                ,style: ElevatedButton.styleFrom(
                    primary: ColorManager.white,
                    side: BorderSide(width: 1.0, color: ColorManager.primary,),elevation: 1
                ),
              )),
            ],
          )


          ],
        ),
      ),
    );
  }
  Widget editWidget(){
    return Container(
      height: 231.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: ColorManager.white,
        boxShadow:[
          BoxShadow(
            offset: const Offset(0, 3),
            blurRadius: 6,
            color: Colors.grey.withOpacity(0.16),
          ),
        ],
      ),
      child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(children: [
          Text('categoryname'.tr()+' :',style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14),)
          ,const Spacer(),
          Text('#593543122',style: getLightStyle(color: ColorManager.codeColor,fontSize: FontSize.s12),) ],),
        contenerShow('Category Name goes here'),
          Text('categoryPrice'.tr(),style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14),)
          , contenerShow('Category Name goes here'),
        Text('categoryunit'.tr()+' :',style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14),)
          , contenerShow('Category unit goes here'), ],),
    );
  }
  Widget contenerShow(String detail){
    return  Container(height: 30.h,
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: ColorManager.white3
      ),
      child: Center(child: Text(detail,style: getLightStyle(color: ColorManager.black,fontSize: FontSize.s14),)),
    );
  }
}

