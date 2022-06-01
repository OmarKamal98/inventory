import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/modle/delete_request.dart';
import 'package:inventory/provider/api_provider.dart';
import 'package:inventory/resources/assets_manager.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/constants_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/router_class.dart';
import 'package:inventory/resources/styles_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class DeletedRecordScreen extends StatelessWidget {
  DeleteRequest deleteRequest;

  DeletedRecordScreen({Key? key,required this.deleteRequest}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
        backgroundColor: ColorManager.white,
        body:Consumer<APIProvider>(
        builder:(context,provider,x){
      return  SingleChildScrollView(
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
                        InkWell(
                          onTap:()=>RouterClass.routerClass.popFunction(),
                            child: Icon(Icons.arrow_back_ios,color: ColorManager.white,size: 20,)),
                        SizedBox(width: 15.w,),
                        Text('settings'.tr(), style: getMediumStyle(
                            color: ColorManager.white, fontSize: FontSize.s22),),
                        const Spacer(),
                      ],), SizedBox(height: 25.h,),],
                ),
              ),
              SizedBox(height: 25.h,),
              Padding(
                padding:   EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(deleteRequest.username.toString(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s20),),

              ),
              SizedBox(height: 10.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text('userdeleteRequest'.tr(),style: getLightStyle(color: ColorManager.black,fontSize: FontSize.s14),),
              ),
              SizedBox(height: 15.h,),
              CategortWidget(deleteRequest: deleteRequest,),
              SizedBox(height: 15.h,),
              Padding(
                padding:   EdgeInsets.symmetric(horizontal: 20.w),
                child: Text('reason'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s20),),

              ),
              SizedBox(height: 15.h,),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(height: 80.h,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: ColorManager.white3
                    ),
                    child: Text(deleteRequest.reason!,style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s16),),
                  ) ),
              SizedBox(height: 15.h,),
              Visibility(
                visible: AppConstants.userApi!.roleName!.first.toLowerCase()=='founder',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height:40.h,width:145.w,child: ElevatedButton(onPressed: (){
                      provider.changeIsLoading();
                      provider.deleteItem(deleteRequest.categoryCode!);
                       Future.delayed(const Duration(seconds: 4), (){
                        provider.changeIsLoading();
                        RouterClass.routerClass.popFunction();
                      });
                    }, child:provider.isLoading?Row(
                      mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text('delete'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s16)),
                     const CircularProgressIndicator(color: Colors.white,),
                    ],
                    ):
                    Text('delete'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s16))
                      ,style: ElevatedButton.styleFrom(
                          primary: ColorManager.red,
                          elevation: 1,
                      ),
                    )),
                    SizedBox(
                        height: 40.h,
                        width:145.w,child: ElevatedButton(onPressed: (){
                      provider.deleteTheREquestDeletion(deleteRequest.deletionid.toString());
                      RouterClass.routerClass.popFunction();
                    }, child: Text('cancel'.tr(),style: getMediumStyle(color: ColorManager.white,fontSize: FontSize.s16),))),

                  ],
                ),
              ),
              SizedBox(height: 75.h,),
              Padding(
                padding:  EdgeInsets.only(left: 170.w),
                child: Lottie.asset(
                    'assets/animation/58413-delete-icon-animation.json',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover
                ),
              )
            ],
          ),
        );}
        )
    );
  }
}


class CategortWidget extends StatelessWidget {
    CategortWidget({Key? key,required this.deleteRequest}) : super(key: key);
  DeleteRequest deleteRequest;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.h,
      margin: EdgeInsets.symmetric(vertical: 7.5.h,horizontal: 20.w),
      decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 3),
              blurRadius: 6,
              color: Colors.grey.withOpacity(0.16),
            ),
          ]
      ),
      child: Row(children: [
        Container(
          width: 60.w,
          decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius:context.locale==Locale('en')? BorderRadius.only(topLeft: Radius.circular(12.r),bottomLeft: Radius.circular(12.r)):BorderRadius.only(topRight: Radius.circular(12.r),bottomRight: Radius.circular(12.r))
          ),
          child: Center(child: SizedBox(
              width: 30.w,
              height: 30.h,
              child:const Image(image:  AssetImage(ImageAssets.splashLogo),)),),
        ),
        Container(
          width:270.w ,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 7.h,),
              Text(deleteRequest.categoryCode!,style: getLightStyle(color: ColorManager.codeColor),),
              SizedBox(
                height: 35.h,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  Text('categoryname'.tr(),style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                  Spacer(),
                    contenerShow(deleteRequest.categoryName!),
                    SizedBox(width: 20.w,)
                ],),
              ),
              Spacer(),
              Row(children: [
                Text('categoryunit'.tr(),style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14),),

                Spacer(),
                contenerShow(deleteRequest.categoryUnit!),
                SizedBox(width: 20.w,)
              ],),
              SizedBox(height: 20.h,),

            ],),
        )
      ],),
    );
  }
  Widget contenerShow(String detail){
    return  Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Container(height: 25.h,
          width: 120.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: ColorManager.white3
          ),
          child: Center(child: Text(detail,style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s15),)),
        ) );
  }
}
