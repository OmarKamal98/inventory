 import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
 import 'package:inventory/resources/assets_manager.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/styles_manager.dart';
import 'package:inventory/ui/component/search_text_field.dart';

class CategoriesListScreen extends StatelessWidget {
  TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 191.h,
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
                    Text('categories'.tr(), style: getMediumStyle(
                        color: ColorManager.white, fontSize: FontSize.s22),),
                    const Spacer(),
                    IconButton(onPressed: (){}, icon: Icon(Icons.add, color: ColorManager.white,size: 24,))

                  ],
                ),
                SizedBox(height: 20.h,),
                CustomSearchField(controller:searchController ,onChanged: (val){},sortFunction: (){},),
                SizedBox(height: 20.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      IconAssets.qrCode,
                    ),
                    SizedBox(width: 7.w,),
                    Text('searchby'.tr(), style: getLightStyle(
                        color: ColorManager.white, fontSize: FontSize.s12),),

                  ],
                ),
                SizedBox(height: 17.h,)
              ],
            ),
          ),
          SizedBox(height: 15.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text('result'.tr(),style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s16),),
          ),
          SizedBox(height: 10.h,),
          ElevatedButton(
              onPressed: () {
                context.setLocale(const Locale('ar'));
              },
              child: Text("Change to ar Language")),   ElevatedButton(
              onPressed: () {
                context.setLocale(const Locale('en'));
              },
              child: Text("Change to ar Language")),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: 12, itemBuilder: (context,index){
              return  CategortWidget();
            }),
          ),


        ],
      ),
    );
  }
}

class CategortWidget extends StatelessWidget {
  const CategortWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 106.h,
      margin: EdgeInsets.symmetric(vertical: 7.5.h),
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
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            SizedBox(height: 15.h,),
            Row(children: [
              Text('CocaCola',style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s18),),
              Spacer(),
              Text('13.9 \$',style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s18)),

            ],),
            SizedBox(height: 10.h,),
            Text('#593265345',style: getRegularStyle(color: ColorManager.codeColor),),
              SizedBox(height: 10.h,),
              Text('Drinks / soda',style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14),),

          ],),
        )
      ],),
    );
  }
}
