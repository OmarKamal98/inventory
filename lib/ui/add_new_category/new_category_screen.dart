import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/styles_manager.dart';
import 'package:inventory/ui/component/input_text_field.dart';

class NewCategory extends StatelessWidget {
  TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Column(
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
                    Icon(Icons.arrow_back_ios,color: ColorManager.white,size: 22,),
                    SizedBox(width: 15.w,),
                    Text('newCat'.tr(), style: getMediumStyle(
                        color: ColorManager.white, fontSize: FontSize.s22),),
                    const Spacer(),
                  ],
                ),
                SizedBox(height: 25.h,),

              ],
            ),
          ),
          SizedBox(height: 20.h,),
          AddCategoryWidget(),
          SizedBox(height: 10.h,),
          ElevatedButton(
              onPressed: () {
                context.setLocale(const Locale('ar'));
              },
              child: Text("Change to ar Language")),   ElevatedButton(
              onPressed: () {
                context.setLocale(const Locale('en'));
              },
              child: Text("Change to ar Language")),



        ],
      ),
    );
  }
}
class AddCategoryWidget extends StatelessWidget {
    AddCategoryWidget({Key? key}) : super(key: key);
TextEditingController controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 25.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: ColorManager.white3
      ),
      child: SizedBox(
        height: 227.h,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
          Row(
            children: [
              Text('data'),
              Spacer(),
              InputTextFeild(controller: controller,)
            ],
          )
        ],),
      ),
    );
  }
}
