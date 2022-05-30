import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/modle/edit_request.dart';
import 'package:inventory/modle/item_model.dart';
import 'package:inventory/provider/api_provider.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/router_class.dart';
import 'package:inventory/resources/styles_manager.dart';
import 'package:provider/provider.dart';

class EditRecordsScreen extends StatelessWidget {
  EditRequest? editRequest;
  EditRecordsScreen({Key? key,required this.editRequest}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SingleChildScrollView(
        child: Consumer<APIProvider>(
          builder: (context,provider,x){
          return Column(
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
                        Icon(Icons.arrow_back_ios,color: ColorManager.white,size: 20,),
                        SizedBox(width: 15.w,),
                        Text('editRecords'.tr(), style: getMediumStyle(
                            color: ColorManager.white, fontSize: FontSize.s22),),
                        const Spacer(),
                      ],),
                    SizedBox(height: 25.h,),],
                ),
              ),
              SizedBox(height: 25.h,),
              Padding(
                padding:   EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(children: [
                  Text('omar Kamal',style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s20),)
                ,const Spacer(),
                  TextButton(onPressed: (){}, child: Text('editRequest'.tr(),style: getRegularStyle(color: ColorManager.recordEite,fontSize: FontSize.s14),))
                ],),

              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text('usereditRequest'.tr(),style: getLightStyle(color: ColorManager.black,fontSize: FontSize.s14),),
              ),
              editWidget1(provider.itemSearch.first,editRequest!),
             Padding(
               padding:   EdgeInsets.symmetric(horizontal: 20.w),
               child: Text('toBecome'.tr(),style: getLightStyle(color: ColorManager.black,fontSize: FontSize.s12),),
             ),
              editWidget(editRequest!),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    height: 40.h,
                    width:136.w,child: ElevatedButton(onPressed: (){
                      provider.changeIsLoading();

                 Item itemm= provider.itemSearch.first;
                  Item item=Item(icode:itemm.icode ,icode1:itemm.icode1 ,icode2: itemm.icode2,icode3:itemm.icode3 ,
                  idscr: editRequest!.categoryName,
                    icprice: itemm.icprice,
                    iunit:editRequest!.categoryCode==itemm.icode? editRequest!.categoryUnit: itemm.iunit,
                    iunit2: editRequest!.categoryCode==itemm.icode1? editRequest!.categoryUnit: itemm.iunit2,
                    iunit3:editRequest!.categoryCode==itemm.icode2? editRequest!.categoryUnit: itemm.iunit3,
                    iunit4: editRequest!.categoryCode==itemm.icode3? editRequest!.categoryUnit: itemm.iunit4,
                    isprice:editRequest!.categoryCode==itemm.icode? double.parse(editRequest!.categoryPrice!): itemm.isprice ,
                    isprice2:editRequest!.categoryCode==itemm.icode1? double.parse(editRequest!.categoryPrice!): itemm.isprice2 ,
                    isprice3:editRequest!.categoryCode==itemm.icode2? double.parse(editRequest!.categoryPrice!): itemm.isprice3  ,
                    isprice4:editRequest!.categoryCode==itemm.icode3? double.parse(editRequest!.categoryPrice!): itemm.isprice4,
                    iunitf: itemm.iunitf,
                    iunitf3: itemm.iunitf3 ,
                    iunitf4:  itemm.iunitf4);
                     provider.upDateItem(item);
                      Future.delayed(const Duration(seconds: 4), (){
                        provider.deleteRequst(editRequest!.categoryCode!);
                        provider.changeIsLoading();
                        RouterClass.routerClass.popFunction();
                        provider.itemSearch=[];
                      });

                }, child:provider.isLoading? Row(
                  mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('acceptChanges'.tr(),style: getMediumStyle(color: ColorManager.white,fontSize: FontSize.s12),),

                  CircularProgressIndicator(color: Colors.white,),
                ],
                ): Text('acceptChanges'.tr(),style: getMediumStyle(color: ColorManager.white,fontSize: FontSize.s16),))),


                SizedBox(height:40.h,width:134.w,child: ElevatedButton(onPressed: (){
                  RouterClass.routerClass.popFunction();
                  provider.deleteRequst(editRequest!.categoryCode!);
                }, child: Text('decline'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s16))
                  ,style: ElevatedButton.styleFrom(
                      primary: ColorManager.white,
                      side: BorderSide(width: 1.0, color: ColorManager.primary,),elevation: 1
                  ),
                )),
              ],
            )


            ],
          );}
        ),
      ),
    );
  }
  Widget editWidget(EditRequest editRequest){
    return Container(
      height: 231.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: ColorManager.white,
        boxShadow:[
          BoxShadow(
            offset: const Offset(0, 3),
            blurRadius: 6,
            color: Colors.grey.withOpacity(0.16),
          ),
        ],
      ),
      child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(children: [
          Text('categoryname'.tr()+' :',style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14),)
          ,const Spacer(),
          Text('#593543122',style: getLightStyle(color: ColorManager.codeColor,fontSize: FontSize.s12),) ],),
        contenerShow(editRequest.categoryName!),
          Text('categoryPrice'.tr(),style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14),)
          , contenerShow(editRequest.categoryPrice!),
        Text('categoryunit'.tr()+' :',style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14),)
          , contenerShow(editRequest.categoryUnit!), ],),
    );
  }
  Widget editWidget1(Item item,EditRequest editRequest){
    return Container(
      height: 231.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: ColorManager.white,
        boxShadow:[
          BoxShadow(
            offset: const Offset(0, 3),
            blurRadius: 6,
            color: Colors.grey.withOpacity(0.16),
          ),
        ],
      ),
      child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(children: [
          Text('categoryname'.tr()+' :',style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14),)
          ,const Spacer(),
          Text('#593543122',style: getLightStyle(color: ColorManager.codeColor,fontSize: FontSize.s12),) ],),
        contenerShow(item.idscr!),
          Text('categoryPrice'.tr(),style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14),)
          , contenerShow(editRequest.categoryCode==item.icode?item.isprice!.toString():editRequest.categoryCode==item.icode1?item.isprice2!.toString():editRequest.categoryCode==item.icode2?item.isprice3!.toString():item.isprice4!.toString()),
        Text('categoryunit'.tr()+' :',style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14),)
          , contenerShow(editRequest.categoryCode==item.icode?item.iunit!:editRequest.categoryCode==item.icode1?item.iunit2!:editRequest.categoryCode==item.icode2?item.iunit3!:item.iunit4!), ],),
    );
  }
  Widget contenerShow(String detail){
    return  Container(height: 30.h,
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: ColorManager.white3
      ),
      child: Center(child: Text(detail,style: getLightStyle(color: ColorManager.black,fontSize: FontSize.s14),)),
    );
  }
}

