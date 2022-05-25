import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/styles_manager.dart';
import 'package:inventory/ui/component/input_text_field.dart';

class AddUserScreen extends StatelessWidget {
TextEditingController controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Column(
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
                    Text('adduser'.tr(), style: getMediumStyle(
                        color: ColorManager.white, fontSize: FontSize.s22),),
                    const Spacer(),
                  ],), SizedBox(height: 25.h,),],
            ),
          ),
          SizedBox(height: 25.h,),
          Padding(
            padding:   EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Text('userName'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                Spacer(),
                InputTextFeild(controller: controller,width: 240.w,color2: ColorManager.white3,)
              ],
            ),
          ),
          SizedBox(height: 20.h,),
          Padding(
            padding:   EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Text('password'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                Spacer(),
                InputTextFeild(controller: controller,width: 240.w,color2: ColorManager.white3,)
              ],
            ),
          ),
          SizedBox(height: 20.h,),
          Padding(
            padding:   EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Text('email'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                Spacer(),
                InputTextFeild(controller: controller,width: 240.w,color2: ColorManager.white3,)
              ],
            ),
          ),
          SizedBox(height: 20.h,),
          Padding(
            padding:   EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Text('jobID'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                Spacer(),
                InputTextFeild(controller: controller,width: 240.w,color2: ColorManager.white3,)
              ],
            ),
          ),
          SizedBox(height: 20.h,),
          Padding(
            padding:   EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Text('location'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                Spacer(),
                InputTextFeild(controller: controller,width: 240.w,color2: ColorManager.white3,)
              ],
            ),
          ),
          SizedBox(height: 20.h,),
          Padding(
            padding:   EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Text('job'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                Spacer(),
                InputTextFeild(controller: controller,width: 240.w,color2: ColorManager.white3,)
              ],
            ),
          ),
          SizedBox(height: 20.h,),
          Divider(endIndent: 20.w,
          indent: 20.w,
          thickness: .5,),
          SizedBox(height: 20.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Transform.scale(
                scale: 1.6,
                child: Checkbox(
                  checkColor: Colors.white,
                  value: false,
                  onChanged: (bool? value) {

                  },
                ),
              ),
              Text('edit'.tr(),style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14),),
              Transform.scale(
                scale: 1.6,
                child: Checkbox(
                  checkColor: Colors.white,
                  value: false,

                  onChanged: (bool? value) {

                  },
                ),
              ),
              Text('delete'.tr(),style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14),),
              Transform.scale(
                scale: 1.6,
                child: Checkbox(
                  checkColor: Colors.white,
                  value: false,

                  onChanged: (bool? value) {

                  },
                ),
              ),
              Text('admin'.tr(),style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14),),

            ],
          ),
          SizedBox(height: 50.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 40.h,
                  width:134.w,child: ElevatedButton(onPressed: (){}, child: Text('save'.tr(),style: getMediumStyle(color: ColorManager.white,fontSize: FontSize.s16),))),
              SizedBox(height:40.h,width:134.w,child: ElevatedButton(onPressed: (){}, child: Text('cancel'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s16))
              ,style: ElevatedButton.styleFrom(
                    primary: ColorManager.white,
                    side: BorderSide(width: 1.0, color: ColorManager.primary,),elevation: 1
                ),
              )),
            ],
          ),

        ],
      ),
    );

  }
}

