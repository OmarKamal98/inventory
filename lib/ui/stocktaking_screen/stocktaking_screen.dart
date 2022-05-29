import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inventory/modle/item_model.dart';
import 'package:inventory/modle/post_Stocktaking.dart';
import 'package:inventory/provider/api_provider.dart';
import 'package:inventory/resources/assets_manager.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/constants_manager.dart';
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
  List<String> section=[
    'Section One',
    'Section Two',

  ];
  List<String> sectionAr=[
    'الفرع الاول'
   ,'الفرع الثاني'
  ];
  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
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
                  SizedBox(height: 25.h,),
                  CustomDropdownButton22(
                    buttonWidth: 335.w,
                    buttonHeight: 45.h,
                    dropdownWidth: 330.w,
                    dropdownHeight: 200.h,
                    buttonDecoration: BoxDecoration(
                        color: ColorManager.white3
                        ,borderRadius: BorderRadius.circular(12.r)
                    ),
                    valueAlignment: Alignment.center,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.black,
                    ),
                    iconSize: 25,
                    hint: '',
                    dropdownItems:context.locale==Locale('en')? section:sectionAr,
                    value:context.locale==Locale('en')?provider.selectedSection:provider.selectedSectionAr,
                    onChanged: (value) {
                      context.locale==Locale('en')? provider.changeSelectedSection(value!):provider.changeSelectedSectionAr(value!);
                    },
                  ),
                  SizedBox(height: 25.h,),
                  Padding(
                    padding:   EdgeInsets.symmetric(horizontal: 20.w),
                    child: InputTextFeild(
                        hintText: 'nameProduct'.tr(),
                        controller: productNameController,heightt:45.h,width:MediaQuery.of(context).size.width,color2: ColorManager.white3,validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'هذا الحقل مطلوب';
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
                      }
                      return null;

                    }),
                  ),
                   SizedBox(height: 20.h,),
                  Padding(
                    padding:EdgeInsets.symmetric(horizontal: 20.w),
                    child: InputTextFeild(
                      hintText: 'quntity'.tr(),
                        controller: quantityInStockController,heightt:45.h,width:MediaQuery.of(context).size.width,color2: ColorManager.white3,
                        validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'هذا الحقل مطلوب';
                      }else if(!isNumeric(value)){
                        return 'must be number';
                      }
                      return null;
                    }),
                  ),
                  SizedBox(height: 40.h,),
                  SizedBox(
                      width: 266.w,
                      height: 40.h,
                      child: ElevatedButton(onPressed: (){
                        if (stocktakingFormkey.currentState!.validate()) {
                          stocktakingFormkey.currentState!.save();
                          provider.changeIsLoading();
                          StocktakingModel stocktakingModel=StocktakingModel(
                            idscr: productNameController.text,
                            icode: barCODEController.text,
                            iunit: unitController.text,
                            username: AppConstants.userApi!.userName!,
                            invqty: double.parse(quantityInStockController.text),
                            branches: context.locale==Locale('en')? provider.selectedSection:provider.selectedSectionAr,
                            reason: ' '
                          );
                          provider.searchwhenPost(barCODEController.text);
                          if(provider.itemSearch.isNotEmpty){
                            provider.postStocktaking(stocktakingModel);

                          }else{
                            provider.changeIsLoading();
                            const snackBar = SnackBar(
                              content: Text('no Item with this Code'),
                              backgroundColor: Colors.red,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                       if(provider.itemSearch.isNotEmpty){
                          Future.delayed(const Duration(seconds: 3), (){
                            productNameController.clear();
                            barCODEController.clear();
                            unitController.clear();
                            quantityInStockController.clear();
                            provider.changeIsLoading();
                             final snackBar = SnackBar(
                              content: Text('Request sent success'),
                              backgroundColor: ColorManager.primary,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            provider.itemSearch=[];

                          });}
                        }
                      }, child:provider.isLoading? Row(
                        mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text('addToStock'.tr(),style: getLightStyle(color: ColorManager.white,fontSize: FontSize.s16),),
                       const SizedBox(width: 10,),
                       const CircularProgressIndicator(color: Colors.white,),
                      ],
                      ):Text('addToStock'.tr(),style: getLightStyle(color: ColorManager.white,fontSize: FontSize.s16),))),
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
                      child: ElevatedButton(onPressed: ()async{
                       Item? item=await provider.scanQRFill(context);
                       if(item !=null){
                         productNameController.text=item.idscr!;
                         barCODEController.text=item.icode!;
                         unitController.text=item.iunit!;
                       }
                      }, child:  Row(
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

