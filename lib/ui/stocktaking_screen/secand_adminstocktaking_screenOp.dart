
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/modle/post_Stocktaking.dart';
import 'package:inventory/provider/api_provider.dart';
import 'package:inventory/resources/assets_manager.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/router_class.dart';
import 'package:inventory/resources/styles_manager.dart';
import 'package:inventory/ui/component/dropDown.dart';
import 'package:provider/provider.dart';

class AdminStocktakingScreenOp extends StatelessWidget {
  List<String> section=[
    'Section One',
    'Section Two',
  ];
  List<String> sectionAr=[
    'الفرع الاول'
    ,'الفرع الثاني'
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Consumer<APIProvider>(
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
                            InkWell(
                                onTap: (){
                                  RouterClass.routerClass.popFunction();
                                },
                                child: Icon(Icons.arrow_back_ios,color: ColorManager.white,size: 20,)),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 155.w,
                        child: ElevatedButton(onPressed: (){
                          List<StocktakingModel> listToExcel= context.locale==Locale('en')?provider.selectedSection=='Section One'?provider.allStocktaking1!:provider.allStocktaking2!:provider.selectedSectionAr=='الفرع الاول'?provider.allStocktaking1!:provider.allStocktaking2!;
                          provider.createExcel(listToExcel);
                        }, child:  Text('saveAsExcel'.tr(),style: getRegularStyle(color: ColorManager.white,fontSize: FontSize.s14),)),
                      ),
                      SizedBox(
                        width: 155.w,
                        child: ElevatedButton(onPressed: () {
                          List<StocktakingModel> listToExcel= context.locale==Locale('en')?provider.selectedSection=='Section One'?provider.allStocktaking1!:provider.allStocktaking2!:provider.selectedSectionAr=='الفرع الاول'?provider.allStocktaking1!:provider.allStocktaking2!;

                          if(listToExcel.isEmpty){
              final snackBar = SnackBar(
                content: Text('noRequestToD'.tr()),
                backgroundColor: Colors.red,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

            }else{
                      provider.changeIsLoading();
                      provider.deleteStocktaking(context);
                      Future.delayed(const Duration(seconds: 3), () {
                        provider.changeIsLoading();
                        final snackBar = SnackBar(
                          content: Text('deletedAllS'.tr()),
                          backgroundColor: Colors.red,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    }
                  }, child:provider.isLoading? Row(
                          mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text('deleteAll'.tr(),style: getRegularStyle(color: ColorManager.white,fontSize: FontSize.s14),),
                          const SizedBox(width: 5,),
                          const CircularProgressIndicator(color: Colors.white,),
                        ],
                        ):
                        Text('deleteAll'.tr(),style: getRegularStyle(color: ColorManager.white,fontSize: FontSize.s14),),
                          style: ElevatedButton.styleFrom(
                            primary: ColorManager.red,
                            elevation: 1,
                          ),),

                      ),
                    ],
                  ),
                  SizedBox(height: 25.h,),
                  context.locale==Locale('en')?
                 ((provider.selectedSection=='Section One'&&provider.allStocktaking1!.isEmpty)||(provider.selectedSection=='Section Two'&&provider.allStocktaking2!.isEmpty))?
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
                     provider.getStocktaking();
                   },
                 )
                     :
                  Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount:provider.selectedSection=='Section One'?provider.allStocktaking1!.length:provider.allStocktaking2!.length,
                        itemBuilder: (context,index){
                          return  CategortSWidget(stocktakingModel: provider.selectedSection=='Section One'?provider.allStocktaking1![index]:provider.allStocktaking2![index],);
                        }),
                  ): ( (provider.selectedSectionAr=='الفرع الاول'&&provider.allStocktaking1!.isEmpty)||(provider.selectedSectionAr=='الفرع الثاني'&&provider.allStocktaking2!.isEmpty))?
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
                      provider.getStocktaking();
                    },
                  )
                      :Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount:provider.selectedSectionAr=='الفرع الاول'?provider.allStocktaking1!.length:provider.allStocktaking2!.length,
                        itemBuilder: (context,index){
                          return  CategortSWidget(stocktakingModel:  provider.selectedSectionAr=='الفرع الاول'?provider.allStocktaking1![index]:provider.allStocktaking2![index]);
                        }),
                  )
                ]

            );}
      ),
    );

  }
}


class CategortSWidget extends StatelessWidget {
  CategortSWidget({Key? key,required this.stocktakingModel}) : super(key: key);
  StocktakingModel stocktakingModel;
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
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 55.w,
                height: 45.h,
                margin: EdgeInsets.all(7.w),
                decoration: BoxDecoration(
                    color: ColorManager.primary,
                    borderRadius: BorderRadius.circular(12.r)
                ),
                child: Center(child: SizedBox(
                    width: 30.w,
                    height: 30.h,
                    child:const Image(image:  AssetImage(ImageAssets.splashLogo),)),),
              ),
              SizedBox(width: 5.w,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(stocktakingModel.idscr!,style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s16),),
                  SizedBox(height: 5.h,)
                  ,Text(stocktakingModel.icode!,style: getLightStyle(color: ColorManager.codeColor),),

                ],
              )
            ],
          ),
          SizedBox(height: 10.h,),
          Row(children: [
            contenerShow(stocktakingModel.branches!),
            contenerShow(stocktakingModel.invqty!.toString()+' piece'),
          ],)
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
