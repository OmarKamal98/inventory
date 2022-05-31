import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inventory/modle/item_model.dart';
import 'package:inventory/provider/api_provider.dart';
import 'package:inventory/resources/assets_manager.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/constants_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/router_class.dart';
import 'package:inventory/resources/styles_manager.dart';
import 'package:inventory/ui/category_screen/category_screen.dart';
import 'package:inventory/ui/component/search_text_field.dart';
import 'package:provider/provider.dart';
import '../add_new_category/new_category_screen.dart';
class CategoriesListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Consumer<APIProvider>(
        builder: (context,provider,x){
        return Column(
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
                      InkWell(
                          onTap: (){
                            RouterClass.routerClass.popFunction();
                          },
                          child: Icon(Icons.arrow_back_ios,color: ColorManager.white,size: 22,)),
                      SizedBox(width: 15.w,),
                      Text('categories'.tr(), style: getMediumStyle(
                          color: ColorManager.white, fontSize: FontSize.s22),),
                      const Spacer(),
                      Visibility(
                        visible: AppConstants.userApi!.roleName!.first.toLowerCase() =='founder'||AppConstants.userApi!.roleName!.first.toLowerCase() =='admin',
                        child: IconButton(onPressed: (){
                          RouterClass.routerClass.pushWidget(NewCategory());
                        }, icon: Icon(Icons.add, color: ColorManager.white,size: 24,)),
                      )
                    ],
                  ),
                  SizedBox(height: 20.h,),
                  CustomSearchField(controller:provider.searchController ,onChanged: (val){   provider.runFilter();},sortFunction: (){},),
                  SizedBox(height: 20.h,),
                  InkWell(
                    onTap: (){
                      provider.scanQR(context);
                    },
                    child: Row(
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
            provider.noResulr?  Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 92.h,),
                    SizedBox(height: 18.h,),
                    Center(child: Text('لم يتم العثور على ما تبحث عنه!',style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s14.sp),),)
                  ]),
            ):Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount:provider.searchItem.isNotEmpty?provider.searchItem.length: provider.allItem!.length,
                  itemBuilder: (context,index){
                return  CategortWidget(item:provider.searchItem.isNotEmpty?provider.searchItem[index]: provider.allItem![index],);
              }),
            ),

          ],
        );}
      ),
    );
  }
}

class CategortWidget extends StatelessWidget {
    CategortWidget({Key? key,required this.item}) : super(key: key);
  Item item;
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
              Expanded(
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,child: InkWell(
                    onTap: ()=>RouterClass.routerClass.pushWidget(CategoryScreen(item: item,)),
                    child: Text(item.idscr!,style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s18),))),
              ),
              SizedBox(width: 20.w,),
              Text(item.isprice!.toString().length >5?item.isprice!.toStringAsFixed(3)+' \$':item.isprice!.toString()+' \$',style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s18)),

            ],),
            SizedBox(height: 10.h,),
            Text('#'+item.icode.toString(),style: getRegularStyle(color: ColorManager.codeColor),),
              SizedBox(height: 10.h,),
              Text(item.iunit!,style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14),),

          ],),
        )
      ],),
    );
  }
}
