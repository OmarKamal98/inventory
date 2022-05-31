import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/modle/item_model.dart';
import 'package:inventory/provider/api_provider.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/router_class.dart';
import 'package:inventory/resources/styles_manager.dart';
import 'package:inventory/ui/component/input_text_field.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class NewCategory extends StatelessWidget {
  TextEditingController searchController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController unitController=TextEditingController();
  TextEditingController priceController=TextEditingController();
  TextEditingController costController=TextEditingController();
  TextEditingController codeController=TextEditingController();
  TextEditingController unit2Controller=TextEditingController();
  TextEditingController price2Controller=TextEditingController();
  TextEditingController cost2Controller=TextEditingController();
  TextEditingController code2Controller=TextEditingController();
  TextEditingController unit3Controller=TextEditingController();
  TextEditingController price3Controller=TextEditingController();
  TextEditingController cost3Controller=TextEditingController();
  TextEditingController code3Controller=TextEditingController();
  TextEditingController unit4Controller=TextEditingController();
  TextEditingController price4Controller=TextEditingController();
  TextEditingController cost4Controller=TextEditingController();
  TextEditingController code4Controller=TextEditingController();
  GlobalKey<FormState> addItemFormkey = GlobalKey<FormState>();
  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
  @override
  Widget build(BuildContext context) {
    Provider.of<APIProvider>(context,listen: false).clearCatScreen();
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Form(
        key:addItemFormkey ,
        child: Consumer<APIProvider>(
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
                        InkWell(
                            onTap:()=>RouterClass.routerClass.popFunction(),
                            child: Icon(Icons.arrow_back_ios,color: ColorManager.white,size: 22,)),
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
            Container(
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
            const  Spacer(),
            InputTextFeild(controller: nameController,    validator: (value) {
            if (value == null || value.isEmpty) {
            return 'هذا الحقل مطلوب';
            }
            return null;

            })
            ],
            ),
            SizedBox(height: 12.h,),
            Row(
            children: [
            Text('categoryunit'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
            const Spacer(),
            InputTextFeild(controller: unitController,    validator: (value) {
            if (value == null || value.isEmpty) {
            return 'هذا الحقل مطلوب';
            }
            return null;

            })
            ],
            ),
            SizedBox(height: 12.h,),
            Row(
            children: [
            Text('costprice'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
            const Spacer(),
            InputTextFeild(controller: costController,    validator: (value) {
            if (value == null || value.isEmpty) {
            return 'هذا الحقل مطلوب';
            }else if(!isNumeric(value)){
            return 'must be number';
            }
            return null;

            })
            ],
            ),
            SizedBox(height: 12.h,),
            Row(
            children: [
            Text('sellingprice'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
            const Spacer(),
            InputTextFeild(controller: priceController,    validator: (value) {
            if (value == null || value.isEmpty) {
            return 'هذا الحقل مطلوب';
            }else if(!isNumeric(value)){
            return 'must be number';
            }
            return null;

            })
            ],
            ),
            SizedBox(height: 12.h,),
            Row(
            children: [
            Text('categorycode'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
            const Spacer(),
            InputTextFeild(controller: codeController,    validator: (value) {
            if (value == null || value.isEmpty) {
            return 'هذا الحقل مطلوب';
            }
            return null;

            })
            ],
            ),
            SizedBox(height: 12.h,),


            ],),
            ),
            ),
              SizedBox(height: 10.h,),
              Visibility(
                visible:provider.numberAddCategory !=0,
                child:Container(
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
                        Center(child: Text('ICODE1',style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s18),)),
                        SizedBox(height: 20.h,),
                        Row(
                          children: [
                            Text('categoryunit'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                            Spacer(),
                            InputTextFeild(controller:unit2Controller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'هذا الحقل مطلوب';
                                  }
                                  return null;
                                })
                          ],
                        ),
                        SizedBox(height: 15.h,),
                        Row(
                          children: [
                            Text('costprice'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                            Spacer(),
                            InputTextFeild(controller:cost2Controller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'هذا الحقل مطلوب';
                                  }else if(!isNumeric(value)){
                                    return 'must be number';
                                  }
                                  return null;

                                })
                          ],
                        ),
                        SizedBox(height: 15.h,),
                        Row(
                          children: [
                            Text('sellingprice'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                            Spacer(),
                            InputTextFeild(controller:price2Controller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'هذا الحقل مطلوب';
                                  }else if(!isNumeric(value)){
                                    return 'must be number';
                                  }
                                  return null;

                                }
                            )
                          ],
                        ),
                        SizedBox(height: 15.h,),
                        Row(
                          children: [
                            Text('categorycode'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                            Spacer(),
                            InputTextFeild(controller:code2Controller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'هذا الحقل مطلوب';
                                  }
                                  return null;
                                })
                          ],
                        ),



                      ],),
                  ),
                )
               ),
              Visibility(
                visible: provider.numberAddCategory >1,
                child: Container(
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
                        Center(child: Text('ICODE2',style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s18),)),
                        SizedBox(height: 20.h,),
                        Row(
                          children: [
                            Text('categoryunit'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                            Spacer(),
                            InputTextFeild(controller:unit3Controller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'هذا الحقل مطلوب';
                                  }
                                  return null;
                                })
                          ],
                        ),
                        SizedBox(height: 15.h,),
                        Row(
                          children: [
                            Text('costprice'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                            Spacer(),
                            InputTextFeild(controller:cost3Controller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'هذا الحقل مطلوب';
                                  }else if(!isNumeric(value)){
                                    return 'must be number';
                                  }
                                  return null;

                                })
                          ],
                        ),
                        SizedBox(height: 15.h,),
                        Row(
                          children: [
                            Text('sellingprice'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                            Spacer(),
                            InputTextFeild(controller:price3Controller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'هذا الحقل مطلوب';
                                  }else if(!isNumeric(value)){
                                    return 'must be number';
                                  }
                                  return null;

                                }
                            )
                          ],
                        ),
                        SizedBox(height: 15.h,),
                        Row(
                          children: [
                            Text('categorycode'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                            Spacer(),
                            InputTextFeild(controller:code3Controller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'هذا الحقل مطلوب';
                                  }
                                  return null;
                                })
                          ],
                        ),



                      ],),
                  ),
                )
               ),
              Visibility(
                visible: provider.numberAddCategory >2,
                child: Container(
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
                        Center(child: Text('ICODE3',style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s18),)),
                        SizedBox(height: 20.h,),
                        Row(
                          children: [
                            Text('categoryunit'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                            Spacer(),
                            InputTextFeild(controller:unit4Controller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'هذا الحقل مطلوب';
                                  }
                                  return null;
                                })
                          ],
                        ),
                        SizedBox(height: 15.h,),
                        Row(
                          children: [
                            Text('costprice'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                            Spacer(),
                            InputTextFeild(controller:cost4Controller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'هذا الحقل مطلوب';
                                  }else if(!isNumeric(value)){
                                    return 'must be number';
                                  }
                                  return null;

                                })
                          ],
                        ),
                        SizedBox(height: 15.h,),
                        Row(
                          children: [
                            Text('sellingprice'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                            Spacer(),
                            InputTextFeild(controller:price4Controller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'هذا الحقل مطلوب';
                                  }else if(!isNumeric(value)){
                                    return 'must be number';
                                  }
                                  return null;

                                }
                            )
                          ],
                        ),
                        SizedBox(height: 15.h,),
                        Row(
                          children: [
                            Text('categorycode'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                            Spacer(),
                            InputTextFeild(controller:code4Controller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'هذا الحقل مطلوب';
                                  }
                                  return null;
                                })
                          ],
                        ),



                      ],),
                  ),
                )
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
                  Visibility(
                      visible: provider.numberAddCategory <3,
                      child: SizedBox(width: 50.w,)),
                  SizedBox(
                      height: 40.h,
                      width:134.w,child: ElevatedButton(onPressed: (){
                      if (addItemFormkey.currentState!.validate()) {
                     addItemFormkey.currentState!.save();
                        Item itemPost=Item(
                          idscr: nameController.text,icode:codeController.text ,icode1:code2Controller.text  ,icode2:code3Controller.text  ,icode3: code4Controller.text,
                          icprice: double.parse(costController.text),isprice: double.parse(priceController.text) ,isprice2:price2Controller.text.isEmpty?0: double.parse(price2Controller.text) ,isprice3: price3Controller.text.isEmpty?0:  double.parse(price3Controller.text),isprice4:price4Controller.text.isEmpty?0:   double.parse(price4Controller.text),
                          iunit:unitController.text ,iunit2:unit2Controller.text ,iunit3:unit3Controller.text ,iunit4: unit4Controller.text
                          );
                         provider.postItem(itemPost);
    }
                  }, child: Text('save'.tr(),style: getMediumStyle(color: ColorManager.white,fontSize: FontSize.s16)))),
                ],
              ),
               Visibility(
                   visible:provider.numberAddCategory ==0,
                   child: Padding(
                     padding:  EdgeInsets.only(left: 110.w),
                     child: Lottie.asset(
                         'assets/animation/42404-add-document.json',
                         width: 250,
                         height: 250,
                         fit: BoxFit.cover
                     ),
                   )
               ),
               SizedBox(height: 30.w,)
            ],
          );}
        ),
      ),
    );
  }
}

