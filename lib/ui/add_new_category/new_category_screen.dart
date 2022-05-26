import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/provider/api_provider.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/styles_manager.dart';
import 'package:inventory/ui/component/input_text_field.dart';
import 'package:provider/provider.dart';

class NewCategory extends StatelessWidget {
  TextEditingController searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    Provider.of<APIProvider>(context,listen: false).clearCatScreen();
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Consumer<APIProvider>(
        builder: (context,provider,x){
        return ListView(
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
            Visibility(
              visible:provider.numberAddCategory !=0,
              child: AddCategoryWidget2(name: "ICODE1"),
            ), Visibility(
              visible: provider.numberAddCategory >1,
              child: AddCategoryWidget2(name: "ICODE2"),
            ), Visibility(
              visible: provider.numberAddCategory >2,
              child: AddCategoryWidget2(name: "ICODE3"),
            ),
            SizedBox(height: 34.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: provider.numberAddCategory <3,
                  child: SizedBox(
                    height: 40.h,
                      width:134.w,child: ElevatedButton(onPressed: (){
                        log(provider.allItem!.length.toString());
                        provider.addCatScreen();
                  }, child: Text('add'.tr(),style: getMediumStyle(color: ColorManager.white,fontSize: FontSize.s16),))),
                ),
                SizedBox(width: 50.w,),
                SizedBox(
                    height: 40.h,
                    width:134.w,child: ElevatedButton(onPressed: (){}, child: Text('save'.tr(),style: getMediumStyle(color: ColorManager.white,fontSize: FontSize.s16)))),
              ],
            ),



          ],
        );}
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
          boxShadow: [
            BoxShadow(
                offset: const Offset(0,3),
                blurRadius: 6,
                color: ColorManager.black.withOpacity(.16)
            )
          ],
        borderRadius: BorderRadius.circular(8.r),
        color: ColorManager.white3
      ),
      child: SizedBox(
        height: 227.h,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
          Row(
            children: [
              Text('categoryname'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
              Spacer(),
              InputTextFeild(controller: controller,)
            ],
          ),
            SizedBox(height: 12.h,),
 Row(
            children: [
              Text('categoryunit'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
              Spacer(),
              InputTextFeild(controller: controller,)
            ],
          ),
            SizedBox(height: 12.h,),
            Row(
            children: [
              Text('costprice'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
              Spacer(),
              InputTextFeild(controller: controller,)
            ],
          ),
            SizedBox(height: 12.h,),
            Row(
            children: [
              Text('sellingprice'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
              Spacer(),
              InputTextFeild(controller: controller,)
            ],
          ),
            SizedBox(height: 12.h,),
            Row(
            children: [
              Text('categorycode'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
              Spacer(),
              InputTextFeild(controller: controller,)
            ],
          ),
            SizedBox(height: 12.h,),


        ],),
      ),
    );
  }
}
class AddCategoryWidget2 extends StatelessWidget {
  AddCategoryWidget2({Key? key,required this.name}) : super(key: key);
  String name;
  TextEditingController controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280.h,

      margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 25.h),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0,3),
            blurRadius: 6,
            color: ColorManager.black.withOpacity(.16)
          )
        ],
          borderRadius: BorderRadius.circular(8.r),
          color: ColorManager.white3
      ),
      child: SizedBox(
        height: 227.h,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            Center(child: Text(name,style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s18),)),
            SizedBox(height: 20.h,),
            Row(
              children: [
                Text('categoryunit'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                Spacer(),
                InputTextFeild(controller: controller,)
              ],
            ),
            SizedBox(height: 15.h,),
            Row(
              children: [
                Text('costprice'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                Spacer(),
                InputTextFeild(controller: controller,)
              ],
            ),
            SizedBox(height: 15.h,),
            Row(
              children: [
                Text('sellingprice'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                Spacer(),
                InputTextFeild(controller: controller,)
              ],
            ),
            SizedBox(height: 15.h,),
            Row(
              children: [
                Text('categorycode'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                Spacer(),
                InputTextFeild(controller: controller,)
              ],
            ),



          ],),
      ),
    );
  }
}
