import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/modle/edit_request.dart';
import 'package:inventory/modle/item_model.dart';
import 'package:inventory/provider/api_provider.dart';
import 'package:inventory/provider/user_provider.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/router_class.dart';
import 'package:inventory/resources/styles_manager.dart';
import 'package:inventory/ui/component/input_text_field.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
class EditCategoryScreen extends StatelessWidget {
  Item item;
  GlobalKey<FormState> sentEditFormkey = GlobalKey<FormState>();

  EditCategoryScreen({Key? key,required this.item}) : super(key: key);
  TextEditingController nameController =TextEditingController();
  TextEditingController unitController =TextEditingController();
  TextEditingController priceController =TextEditingController();
  String icode='';
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    icode=Provider.of<APIProvider>(context,listen: false).selectedCode;
    nameController.text=item.idscr!;
    unitController.text=icode=='icode'?item.iunit!:icode=='icode1'?item.iunit2!:icode=='icode2'?item.iunit3!:item.iunit4!;
    priceController.text=icode=='icode'?item.isprice.toString():icode=='icode1'?item.isprice2.toString():icode=='icode2'?item.isprice3.toString():item.isprice4.toString();
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Consumer<APIProvider>(
          builder: (context,provider,x){
            return Form(
              key: sentEditFormkey,
              child: ListView(
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
                                onTap: (){
                                  RouterClass.routerClass.popFunction();
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
                  Container(
                    height: 240.h,
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
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      children: [
                        Row(
                          children: [
                            Text('categoryname'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                            Spacer(),
                            InputTextFeild(controller: nameController,validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'هذا الحقل مطلوب';
                              }
                              return null;

                            },)
                          ],
                        ),
                        SizedBox(height: 16.h,),
                        Row(
                          children: [
                            Text('categoryunit'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                            Spacer(),
                            InputTextFeild(controller: unitController,validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'هذا الحقل مطلوب';
                              }
                              return null;

                            })
                          ],
                        ),
                        SizedBox(height: 16.h,),
                        Row(
                          children: [
                            Text('categoryPrice'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                            Spacer(),
                            InputTextFeild(controller: priceController,validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'هذا الحقل مطلوب';
                              }
                              return null;

                            })
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




                      ],),
                  ),
                  // ShowCategoryWidget(item: item,nameController: nameController,priceController: priceController,unitController: unitController,),
                  SizedBox(height: 60.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          height: 40.h,
                          width:145.w,child: ElevatedButton(onPressed: (){
                            if (sentEditFormkey.currentState!.validate()) {
                              sentEditFormkey.currentState!.save();
                              provider.changeIsLoading();
                              EditRequest editRe=EditRequest(
                                  categoryName: nameController.text,
                                  categoryUnit: unitController.text,
                                  categoryPrice:priceController.text ,
                                  categoryCode: provider.selectedCode=='icode'?item.icode!:provider.selectedCode=='icode1'?item.icode1!:provider.selectedCode=='icode2'?item.icode2!:item.icode3!
                              );
                              provider.postEditRequest(editRe);
                              Future.delayed(const Duration(seconds: 3), () {
                                provider.isLoading=false;
                                RouterClass.routerClass.popFunction();
                              });
                            }},

                          child:provider.isLoading?Row(
                        mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text('sendRequest'.tr(),style: getMediumStyle(color: ColorManager.white,fontSize: FontSize.s14),),
                        const SizedBox(width: 5,),
                        const CircularProgressIndicator(color: Colors.white,),
                      ],
                      ): Text('sendRequest'.tr(),style: getMediumStyle(color: ColorManager.white,fontSize: FontSize.s16),))),
                      SizedBox(height:40.h,width:145.w,child: ElevatedButton(onPressed: (){
                        RouterClass.routerClass.popFunction();
                      }, child: Text('cancel'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s16))
                        ,style: ElevatedButton.styleFrom(
                          primary: ColorManager.white,
                          elevation: 1,
                        ),
                      )),
                    ],
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal:60.w ),
                    child: Lottie.asset(
                        'assets/animation/105037-pencil-connecting-dots.json',
                        width: 250.w,
                        height: 250.h,
                        fit: BoxFit.cover
                    ),
                  ),
                ],
              ),
            );}
      ),
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
