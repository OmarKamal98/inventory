import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/modle/item_model.dart';
import 'package:inventory/provider/user_provider.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/styles_manager.dart';
import 'package:inventory/ui/component/input_text_field.dart';
import 'package:provider/provider.dart';
class CategoryScreen extends StatelessWidget {
Item item;

  CategoryScreen({Key? key,required this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Consumer<UserAppProvider>(
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
                          Text('categorynames'.tr(), style: getMediumStyle(
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
                SizedBox(height: 60.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        height: 40.h,
                        width:145.w,child: ElevatedButton(onPressed: (){}, child: Text('editCategory'.tr(),style: getMediumStyle(color: ColorManager.white,fontSize: FontSize.s16),))),
                    SizedBox(height:40.h,width:145.w,child: ElevatedButton(onPressed: (){}, child: Text('deleteCategory'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s16))
                      ,style: ElevatedButton.styleFrom(
                        primary: ColorManager.red,
                        elevation: 1,
                      ),
                    )),

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
  TextEditingController nameController=TextEditingController();
  TextEditingController unitController=TextEditingController();
  TextEditingController priceController=TextEditingController();
  TextEditingController codeproductController=TextEditingController();
  TextEditingController codeController=TextEditingController();
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
                InputTextFeild(controller: nameController,)
              ],
            ),
            SizedBox(height: 12.h,),
            Row(
              children: [
                Text('categoryunit'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                Spacer(),
                InputTextFeild(controller: unitController,)
              ],
            ),
            SizedBox(height: 12.h,),
            Row(
              children: [
                Text('categoryPrice'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                Spacer(),
                InputTextFeild(controller: priceController,)
              ],
            ),
            SizedBox(height: 12.h,),
            Row(
              children: [
                Text('categoryCode'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                Spacer(),
                InputTextFeild(controller: codeproductController,)
              ],
            ),
            SizedBox(height: 12.h,),
            Row(
              children: [
                Text('categorycode'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                Spacer(),
                InputTextFeild(controller: codeController,)
              ],
            ),
            SizedBox(height: 12.h,),


          ],),
      ),
    );
  }
}
