import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inventory/provider/api_provider.dart';
import 'package:inventory/resources/assets_manager.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/styles_manager.dart';
import 'package:inventory/ui/component/dropDown.dart';
import 'package:inventory/ui/component/input_text_field.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

class StocktakingScreen extends StatelessWidget {
  TextEditingController productNameController=TextEditingController();
  TextEditingController barCODEController=TextEditingController();
  TextEditingController unitController=TextEditingController();
  TextEditingController quantityInStockController=TextEditingController();
  GlobalKey<FormState> stocktakingFormkey = GlobalKey<FormState>();
  List<String> sizeFilter = [
    'No Filter',
    'S',
    'M',
    'L',
    'XL',
    'XXL',
    'XXXL',
  ];
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Form(
        key: stocktakingFormkey,
        child: Consumer<APIProvider>(
            builder: (context,provider,x){
              return Column(
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
                            Text('stocktakinguser'.tr(), style: getMediumStyle(
                                color: ColorManager.white, fontSize: FontSize.s22),),
                            const Spacer(),
                          ],), SizedBox(height: 25.h,),],
                    ),
                  ),
                  CustomDropdownButton22(
                    buttonWidth: 400.w,
                    buttonHeight: 60.h,
                    dropdownWidth: 340.w,
                    dropdownHeight: 400.h,

                    valueAlignment: Alignment.center,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 35,
                    hint: 'Select medicine type',
                    dropdownItems: sizeFilter,
                    value:sizeFilter[0],
                    onChanged: (value) {
                      // provider.selectmedicalType = value;
                      // provider.notify1();
                    },
                  ),
                  SizedBox(height: 100.h,),
                  Padding(
                    padding:   EdgeInsets.symmetric(horizontal: 20.w),
                    child: InputTextFeild(
                        hintText: 'nameProduct'.tr(),
                        controller: productNameController,heightt:45.h,width:MediaQuery.of(context).size.width,color2: ColorManager.white3,validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'هذا الحقل مطلوب';
                      }else if(value.contains(' ')){
                        return 'no contain space';
                      }
                      return null;

                    }),
                  ),
                  SizedBox(height: 20.h,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: InputTextFeild(
                        hintText: 'barProduct'.tr(),
                        controller: barCODEController,heightt:45.h,width:MediaQuery.of(context).size.width,color2: ColorManager.white3,validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'هذا الحقل مطلوب';
                      }
                      return null;

                    }),
                  ),
                  SizedBox(height: 20.h,),
                  Padding(
                    padding:   EdgeInsets.symmetric(horizontal: 20.w),
                    child: InputTextFeild(
                      hintText: 'unit'.tr(),
                        controller: unitController,heightt:45.h,width:MediaQuery.of(context).size.width,color2: ColorManager.white3,validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'هذا الحقل مطلوب';
                      }else if(!isEmail(value)){
                        return 'error email syntx';
                      }
                      return null;

                    }),
                  ),
                   SizedBox(height: 20.h,),
                  Padding(
                    padding:   EdgeInsets.symmetric(horizontal: 20.w),
                    child: InputTextFeild(
                      hintText: 'quntity'.tr(),
                        controller: quantityInStockController,heightt:45.h,width:MediaQuery.of(context).size.width,color2: ColorManager.white3,validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'هذا الحقل مطلوب';
                      }else if(!isEmail(value)){
                        return 'error email syntx';
                      }
                      return null;

                    }),
                  ),
                  SizedBox(height: 40.h,),
                  SizedBox(
                      width: 266.w,
                      height: 40.h,
                      child: ElevatedButton(onPressed: (){}, child: Text('addToStock'.tr(),style: getLightStyle(color: ColorManager.white,fontSize: FontSize.s16),))),
                  SizedBox(height: 35.h,),
                  Row(
                      children: <Widget>[
                        Expanded(
                            child: Divider(
                              endIndent: 20.w,
                              indent: 20.w,
                              thickness: 1,
                              color: ColorManager.black,
                            )
                        ),

                        Text("OR"),

                        Expanded(
                            child: Divider(
                              endIndent: 20.w,
                              indent: 20.w,
                              thickness: 1,
                              color: ColorManager.black,
                            )
                        ),
                      ]
                  ),
                  SizedBox(height: 25.h,),
                  SizedBox(
                      width: 266.w,
                      height: 40.h,
                      child: ElevatedButton(onPressed: (){}, child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                SvgPicture.asset(IconAssets.qrCode),
                SizedBox(width: 12.w,),
                Text('searchby'.tr(), style: getLightStyle(color: ColorManager.white, fontSize: FontSize.s12),),
                ],),)),],

              );}
        ),
      ),
    );

  }
}

