import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/modle/delete_request.dart';
import 'package:inventory/modle/item_model.dart';
import 'package:inventory/provider/api_provider.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/constants_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/router_class.dart';
import 'package:inventory/resources/styles_manager.dart';
import 'package:inventory/ui/category_screen/edit_category_screen.dart';
import 'package:inventory/ui/component/dropDown.dart';
import 'package:inventory/ui/component/input_text_field.dart';
import 'package:provider/provider.dart';
class CategoryScreen extends StatelessWidget {
Item item;
TextEditingController resonDeleteController = TextEditingController();
GlobalKey<FormState> resonFormkey = GlobalKey<FormState>();

  CategoryScreen({Key? key,required this.item}) : super(key: key);
  @override
    Widget build(BuildContext context) {
      ScreenUtil.init(context, designSize: const Size(375, 812));
     return Scaffold(
        backgroundColor: ColorManager.white,
        body: Consumer<APIProvider>(
          builder: (context,provider,x){
            return ListView(
              physics: NeverScrollableScrollPhysics(),
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
                    children:[
                     const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap:(){
                                RouterClass.routerClass.popFunction();
                                provider.selectedCode='icode';
                                },
                              child: Icon(Icons.arrow_back_ios,color: ColorManager.white,size: 22,)),
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
                ShowCategoryWidget(item: item,),
                SizedBox(height: 60.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: AppConstants.userApi!.roleName!.first.toLowerCase()=='edit'|| AppConstants.userApi!.roleName!.first.toLowerCase()=='admin'|| AppConstants.userApi!.roleName!.first.toLowerCase()=='founder',
                      child: SizedBox(
                          height: 40.h,
                          width:145.w,child: ElevatedButton(onPressed: (){
                            RouterClass.routerClass.pushWidget(EditCategoryScreen(item: item,));
                      }, child: Text('editCategory'.tr(),style: getMediumStyle(color: ColorManager.white,fontSize: FontSize.s16),))),
                    ),
                      Visibility(
                          visible: AppConstants.userApi!.roleName!.first.toLowerCase()=='admin'||AppConstants.userApi!.roleName!.first.toLowerCase()=='founder',
                          child: SizedBox(width: 30.w,)),
                    Visibility(
                      visible: AppConstants.userApi!.roleName!.first.toLowerCase() =='delete' || AppConstants.userApi!.roleName!.first.toLowerCase()=='admin'|| AppConstants.userApi!.roleName!.first.toLowerCase()=='founder',
                      child: SizedBox(height:40.h,width:145.w,child: ElevatedButton(onPressed: (){
                        if(AppConstants.userApi!.roleName!.first.toLowerCase()=='founder'){
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Consumer<APIProvider>(
                                    builder: (context, provider, x) {
                                      return AlertDialog(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 15.w),
                                        actionsPadding: EdgeInsets.only(
                                            bottom: 25.h),
                                        title: Center(
                                            child: Text('deleteAction'.tr())),
                                        content: SizedBox(
                                          height: 80.h,
                                          width: 315.w,
                                          child: Column(
                                            children: [
                                              SizedBox(height: 20.h,),
                                              Text('sureDelete'.tr()),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                  height: 40.h,
                                                  width: 125.w,
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                          provider.deleteItem(item.icode!);
                                                          provider.changeIsLoading();
                                                          Future.delayed(const Duration(seconds:3), () {
                                                            provider.searchController.clear();
                                                            provider.changeIsLoading();
                                                            RouterClass.routerClass.popUntilFunction(context);
                                                          });
                                                      },
                                                      child: provider.isLoading
                                                          ? Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .center, children: [
                                                        Text('delete'
                                                            .tr(),
                                                          style: getMediumStyle(
                                                              color: ColorManager
                                                                  .white,
                                                              fontSize: FontSize
                                                                  .s16),),
                                                        const SizedBox(
                                                          width: 5,),
                                                        const CircularProgressIndicator(
                                                          color: Colors.white,),
                                                      ],
                                                      )
                                                          : Text(
                                                        'delete'.tr(),
                                                        style: getMediumStyle(
                                                            color: ColorManager
                                                                .white,
                                                            fontSize: FontSize
                                                                .s16),),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: ColorManager.red,
                                                      elevation: 1,
                                                    ),
                                                  )),
                                              SizedBox(height: 40.h,
                                                  width: 125.w,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      RouterClass.routerClass
                                                          .popFunction();
                                                    },
                                                    child: Text('cancel'.tr(),
                                                        style: getMediumStyle(
                                                            color: ColorManager
                                                                .black,
                                                            fontSize: FontSize
                                                                .s16))
                                                    ,
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: ColorManager
                                                          .white,
                                                      elevation: 1,
                                                    ),
                                                  )),

                                            ],
                                          ),

                                        ],
                                      );
                                    }
                                );
                              });
                        }else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Consumer<APIProvider>(
                                    builder: (context, provider, x) {
                                      return AlertDialog(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 15.w),
                                        actionsPadding: EdgeInsets.only(
                                            bottom: 25.h),
                                        title: Center(
                                            child: Text('deleteAction'.tr())),
                                        content: SizedBox(
                                          height: 150.h,
                                          width: 315.w,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text('reason'.tr()),
                                              SizedBox(height: 10.h,),
                                              InputTextFeild(
                                                  controller: resonDeleteController,
                                                  heightt: 100.h,
                                                  color2: ColorManager.white3,
                                                  width: 285.w,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'هذا الحقل مطلوب';
                                                    }
                                                    return null;
                                                  }),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceEvenly,
                                            children: [
                                              SizedBox(
                                                  height: 40.h,
                                                  width: 127.w,
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        if (resonDeleteController
                                                            .text.isNotEmpty) {
                                                          provider
                                                              .changeIsLoading();
                                                          DeleteRequest delete = DeleteRequest(
                                                            deletionid: 0,
                                                              reason: resonDeleteController
                                                                  .text,
                                                              categoryName: item
                                                                  .idscr,
                                                              username: AppConstants
                                                                  .userApi!
                                                                  .userName,
                                                              categoryUnit: provider
                                                                  .selectedCode ==
                                                                  'icode'
                                                                  ? item.iunit!
                                                                  : provider
                                                                  .selectedCode ==
                                                                  'icode1'
                                                                  ? item.iunit2!
                                                                  : provider
                                                                  .selectedCode ==
                                                                  'icode2'
                                                                  ? item.iunit3!
                                                                  : item
                                                                  .iunit4!,
                                                              categoryCode: provider
                                                                  .selectedCode ==
                                                                  'icode'
                                                                  ? item.icode!
                                                                  : provider
                                                                  .selectedCode ==
                                                                  'icode1'
                                                                  ? item.icode1!
                                                                  : provider
                                                                  .selectedCode ==
                                                                  'icode2'
                                                                  ? item.icode2!
                                                                  : item.icode3!
                                                          );
                                                          provider
                                                              .postDeleteRequest(
                                                              delete);
                                                          Future.delayed(
                                                              const Duration(
                                                                  seconds: 3), () {
                                                            resonDeleteController
                                                                .clear();
                                                            provider
                                                                .changeIsLoading();
                                                            RouterClass
                                                                .routerClass
                                                                .popFunction();
                                                          });
                                                        } else {
                                                          log('no reson');
                                                        }
                                                      },
                                                      child: provider.isLoading
                                                          ? Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .center, children: [
                                                        Text('sendRequestD'
                                                            .tr(),
                                                          style: getLightStyle(
                                                              color: ColorManager
                                                                  .white,
                                                              fontSize: FontSize
                                                                  .s10),),

                                                        const CircularProgressIndicator(
                                                          color: Colors.white,),
                                                      ],
                                                      )
                                                          : Text(
                                                        'sendRequestD'.tr(),
                                                        style: getMediumStyle(
                                                            color: ColorManager
                                                                .white,
                                                            fontSize: FontSize
                                                                .s15),))),
                                              SizedBox(height: 40.h,
                                                  width: 125.w,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      RouterClass.routerClass
                                                          .popFunction();
                                                    },
                                                    child: Text('cancel'.tr(),
                                                        style: getMediumStyle(
                                                            color: ColorManager
                                                                .black,
                                                            fontSize: FontSize
                                                                .s16))
                                                    ,
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: ColorManager
                                                          .white,
                                                      elevation: 1,
                                                    ),
                                                  )),

                                            ],
                                          ),

                                        ],
                                      );
                                    }
                                );
                              });
                        }    }, child: Text('deleteCategory'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s16))
                        ,style: ElevatedButton.styleFrom(
                          primary: ColorManager.red,
                          elevation: 1,
                        ),
                      )),
                    ),

                  ],
                ),

              ],
            );}
      ),
    );
  }
}
class ShowCategoryWidget extends StatelessWidget {
  ShowCategoryWidget({Key? key,required this.item}) : super(key: key);
  Item item;
  List<String> iCode=[
    'icode',
    'icode1',
    'icode2',
    'icode3'
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<APIProvider>(
      builder: (context,provider,x){
      return Container(
        height: 330.h,
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
                  contenerShow(item.idscr!)
                ],
              ),
              SizedBox(height: 10.h,),
              Row(
                children: [
                  Text('categoryunit'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                  Spacer(),
                  contenerShow(provider.selectedCode=='icode'?item.iunit!:provider.selectedCode=='icode1'?item.iunit2!:provider.selectedCode=='icode2'?item.iunit3!:item.iunit4!)
                ],
              ),
              SizedBox(height: 10.h,),
              Row(
                children: [
                  Text('categoryPrice'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                  Spacer(),
                  contenerShow(
                      provider.selectedCode=='icode'?item.isprice.toString():provider.selectedCode=='icode1'?item.isprice2.toString():provider.selectedCode=='icode2'?item.isprice3.toString():item.isprice4.toString()
                  )

                ],
              ),
              SizedBox(height: 10.h,),
              Row(
                children: [
                  Text('code'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                  Spacer(),
                  CustomDropdownButton22(
                    buttonWidth: 185.w,
                    buttonHeight: 35.h,
                    dropdownWidth: 180.w,
                    dropdownHeight: 200.h,
                    buttonDecoration: BoxDecoration(
                        color: ColorManager.white
                        ,borderRadius: BorderRadius.circular(8.r)
                    ),
                    valueAlignment: Alignment.center,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.black,
                    ),
                    iconSize: 25,
                    hint: '',
                    dropdownItems: iCode,
                    value:provider.selectedCode,
                    onChanged: (value) {
                      provider.changeSelectedCode(value!);
                    },
                  ),
                ],
              ),
              SizedBox(height: 10.h,),

              Row(
                children: [
                  Text('categoryCode'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                  Spacer(),
                  contenerShow(provider.selectedCode=='icode'?item.icode!:provider.selectedCode=='icode1'?item.icode1!:provider.selectedCode=='icode2'?item.icode2!:item.icode3!)
                ],
              ),
              SizedBox(height: 10.h,),


            ],),
        ),
      );}
    );
  }
  Widget contenerShow(String detail){
    return  Container(height: 31.h,
      width: 185.w,
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: ColorManager.white
      ),
      child: Center(child: Text(detail,style: getLightStyle(color: ColorManager.black,fontSize: FontSize.s14),)),
    );
  }
}
