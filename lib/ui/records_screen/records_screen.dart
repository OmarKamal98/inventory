import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/modle/delete_request.dart';
import 'package:inventory/modle/edit_request.dart';
import 'package:inventory/provider/api_provider.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/router_class.dart';
import 'package:inventory/resources/styles_manager.dart';
import 'package:inventory/ui/records_screen/delete_records.dart';
import 'package:inventory/ui/records_screen/edit_record_screen.dart';
import 'package:provider/provider.dart';

class RecordsScreen extends StatelessWidget {
  buildShowDialog(BuildContext context) {
    return  showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 5), () {
            Navigator.of(context).pop(true);
          });
          return   Column(
            children: [
              SizedBox(height: 200.h,),
              CircularProgressIndicator(),
            Text('waitingGetItem'.tr(),style: getMediumStyle(color: ColorManager.white),)
            ],

          );
        });
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: ColorManager.white,
        body: Consumer<APIProvider>(
        builder:(context,provider,x){
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
                    // borderRadius: BorderRadius.circular(15.r)
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
                        Text('records'.tr(), style: getMediumStyle(
                            color: ColorManager.white, fontSize: FontSize.s22),),
                        const Spacer(),
                      ],), SizedBox(height: 25.h,),],
                ),
              ),

              PreferredSize(
                preferredSize: Size(60, 42.h),
                child: Container(
                  decoration: BoxDecoration(
                     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.r),bottomRight: Radius.circular(8.r)),
                    color: ColorManager.codeColor,
                  ),
                  height: 40.h,

                  child: TabBar(
                    padding: EdgeInsets.all(1.w),
                    indicatorColor: Colors.black,
                    labelStyle: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: FontSize.s16.sp),
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            8.r), // Creates border
                        color: ColorManager.primary),
                    tabs:  [
                      Tab(
                        text:'edit'.tr(),
                      ),
                      Tab(
                        text:'delete'.tr(),
                      )
                    ],
                  ),
                ),
              ),
               Expanded(
                 child: TabBarView(
                        children: [
                         provider.allEditRequest!.isEmpty?
                         RefreshIndicator(
                           child: Stack(
                             children: <Widget>[
                               Center(
                                 child:Text('noRequestYet'.tr(),style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s16)),
                               ),
                               SizedBox(
                                   height: 200.h,
                                   child: ListView())
                             ],
                           ),
                           onRefresh: () async{
                             provider.getEditRequest();
                           },
                         )
                             :
                         RefreshIndicator(
                           triggerMode: RefreshIndicatorTriggerMode.onEdge,
                           backgroundColor: ColorManager.primary,
                           onRefresh: () async{
                             provider.getEditRequest();
                           },
                           child: ListView.builder(
                                padding: EdgeInsets.zero,
                                 itemCount:provider.allEditRequest!.length ,
                                itemBuilder: (context, index) {
                                  return recordsWidget(provider.allEditRequest![index],context);
                                }),
                         )
                         , provider.allDeletedRequest!.isEmpty?  RefreshIndicator(
                            child: Stack(
                              children: <Widget>[
                                Center(
                                  child:Text('noRequestYet'.tr(),style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s16)),
                                ),
                                SizedBox(
                                    height: 200.h,
                                    child: ListView())
                              ],
                            ),
                            onRefresh: () async{
                              provider.getDeleteRequest();
                            },
                          ):
                          RefreshIndicator(
                            triggerMode: RefreshIndicatorTriggerMode.onEdge,
                            backgroundColor: ColorManager.primary,
                            onRefresh: () async{
                              provider.getDeleteRequest();
                            },
                           child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount:provider.allDeletedRequest!.length ,
                                itemBuilder: (context, index) {
                                  return recordsDeleteWidget(provider.allDeletedRequest![index],context);
                                }),
                         ),
                        ],
                       ),
               ),

            ],
          );}
        ),
      ),
    );
  }
  Widget recordsWidget(EditRequest editRequest,BuildContext context){
    return Consumer<APIProvider>(
      builder: (context,provider,x){
      return InkWell(
        onTap: (){
          if(provider.allItem!.isEmpty){
            buildShowDialog(context);
          }else {
            Provider.of<APIProvider>(context, listen: false).searchwhenPost(
                editRequest.categoryCode!);
            RouterClass.routerClass.pushWidget(
                EditRecordsScreen(editRequest: editRequest,));
          }  },
        child: Container(
          height: 70.h,
          width: 335.w,
          padding: EdgeInsets.all(15.w),
          margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 15.h),
          decoration: BoxDecoration(
            color: ColorManager.white3,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow:[
              BoxShadow(
                offset: const Offset(0, 3),
                blurRadius: 6,
                color: Colors.grey.withOpacity(0.16),
              ),
            ],
          ),
          child: RichText(
            text:    TextSpan(
              children: <TextSpan>[
                  TextSpan(
                    text: editRequest.username.toString(),
                    style:  getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14)),
                    TextSpan(
                    text:'userRequest'.tr(),
                    style:  getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14)),
                    TextSpan(
                    text:'edit'.tr(),
                    style:  getMediumStyle(color: ColorManager.recordEite,fontSize: FontSize.s14)),
                  TextSpan(
                      text:'item'.tr()+': '+editRequest.categoryName.toString(),
                      style:getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14)),

              ],
            ),
          ),
        ),
      );}
    );
  }
  Widget recordsDeleteWidget(DeleteRequest deleteRequest,BuildContext context){
    return InkWell(
      onTap: (){
        Provider.of<APIProvider>(context,listen: false).searchwhenPost(deleteRequest.categoryCode!);
        RouterClass.routerClass.pushWidget(DeletedRecordScreen(deleteRequest: deleteRequest,));
      },
      child: Container(
        height: 70.h,
        width: 335.w,
        padding: EdgeInsets.all(15.w),
        margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 15.h),
        decoration: BoxDecoration(
          color: ColorManager.white3,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow:[
            BoxShadow(
              offset: const Offset(0, 3),
              blurRadius: 6,
              color: Colors.grey.withOpacity(0.16),
            ),
          ],
        ),
        child: RichText(
          text:    TextSpan(
            children: <TextSpan>[
                TextSpan(
                  text: deleteRequest.username.toString(),
                  style:  getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14)),
                  TextSpan(
                  text:'userRequest'.tr(),
                  style:  getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14)),
                  TextSpan(
                  text:'delete'.tr(),
                  style:  getMediumStyle(color: ColorManager.red,fontSize: FontSize.s14)),
                TextSpan(
                    text:'item'.tr()+': '+deleteRequest.categoryName!,
                    style:getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14)),

            ],
          ),
        ),
      ),
    );
  }

}

