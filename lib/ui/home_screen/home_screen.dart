import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inventory/data/api/dio_client.dart';
import 'package:inventory/provider/api_provider.dart';
import 'package:inventory/resources/assets_manager.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/constants_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/router_class.dart';
import 'package:inventory/resources/styles_manager.dart';
import 'package:inventory/ui/categories_list_screen/categories_ist_screen.dart';
import 'package:inventory/ui/records_screen/records_screen.dart';
import 'package:inventory/ui/setting/setting_screen.dart';
import 'package:inventory/ui/uesrs_screens/users_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Consumer<APIProvider>(
        builder: (context,provider,x){
      return Column(
          children: [
            Stack(
              children: [
                Container(
                height: 160.h,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                    color: ColorManager.primary,
                    borderRadius: BorderRadius.circular(15.r)
                ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: SizedBox(
                            width: 40.w,
                            height: 40.h,
                            child: ClipOval(
                              child: Image.asset(ImageAssets.splashLogo,fit: BoxFit.cover,alignment: Alignment.topCenter
                              ),
                            )
                        )
                    ),
                    SizedBox(width: 15.w,),
                    Text('welcome'.tr()+' '+AppConstants.userApi!.userName!,style: getMediumStyle(color: ColorManager.white,fontSize: FontSize.s22),),
                    const Spacer(),
                    InkWell(
                        onTap: (){
                          RouterClass.routerClass.pushWidget(SettingScreen());
                        },
                        child: Icon(Icons.settings,color: ColorManager.white,))
                  ],
                ),
              ),
                   Padding(
                      padding:EdgeInsets.only(top: 120.h),
                      child: Container(
                        height: 82.h,
                        margin: EdgeInsets.symmetric(horizontal: 15.w),
                        decoration: BoxDecoration(
                          boxShadow:[
                            BoxShadow(
                              offset: const Offset(0, 3),
                              blurRadius: 6,
                              color: Colors.grey.withOpacity(0.16),
                            ),
                          ] ,
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                          Control(text: 'users'.tr(),number: provider.allUser==null?'0':provider.allUser!.length.toString(),),
                          VerticalDivider(
                            indent: 17.h,
                            endIndent: 17.h,
                            thickness: 1,
                          ),
                          Control(text: 'edits'.tr(),number: provider.allEditRequest==null?'0':provider.allEditRequest!.length.toString(),),
                            VerticalDivider(
                              indent: 17.h,
                              endIndent: 17.h,
                              thickness: 1,
                            ),
                          Control(text: 'delets'.tr(),number: provider.allDeletedRequest==null?'0':provider.allDeletedRequest!.length.toString()),
                        ],),
                ),
                    )
              ],

            ),
            SizedBox(height: 30.h,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                firstWid('records'.tr(),ImageAssets.record,(){
                  RouterClass.routerClass.pushWidget(RecordsScreen());
                }),
                firstWid('users'.tr(),ImageAssets.users,(){
                  RouterClass.routerClass.pushWidget(UserScreen());

                }),
              ],
            ),
            SizedBox(height: 30.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: WidgetHome(imagePath: ImageAssets.home1, text: 'stocktaking'.tr(),buttomText: 'view'.tr(),buttonPress: (){

              },),
            ),
            SizedBox(height: 20.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: WidgetHome(imagePath: ImageAssets.home2, text: 'categories'.tr(),buttomText: 'view'.tr(),buttonPress: (){
                RouterClass.routerClass.pushWidget(CategoriesListScreen());
              },),
            ),
                // Padding(
                //   padding:  EdgeInsets.only(left: 170.w),
                //   child: Lottie.asset(
                //       'assets/animation/105509-delivery-man.json',
                //       width: 200,
                //       height: 200,
                //       fit: BoxFit.cover
                //   ),
                // ),
            Padding(
              padding:  EdgeInsets.only(left: 170.w),
              child: Lottie.asset(
                  'assets/animation/animation.json',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover
              ),
            )
          ],
        );}
      ),
    );
  }
  Widget firstWid(String name,String iconPath,VoidCallback onTap1){
    return InkWell(
      onTap: onTap1,
      child: Container(
        width: 155.w,
        height: 35.h,
        decoration: BoxDecoration(
            boxShadow:[
              BoxShadow(
                offset: const Offset(0, 3),
                blurRadius: 6,
                color: Colors.grey.withOpacity(0.16),
              ),
            ],
          color: ColorManager.homeScreen
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
         SizedBox(
             width: 18.w,
             height:18.h ,
             child: Image(image: AssetImage(iconPath)))
            ,SizedBox(width: 15.w,),
            Text(name,style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s16),),

        ],),
      ),
    );
  }
}
class Control extends StatelessWidget {
    Control({Key? key,required this.text,required this.number}) : super(key: key);
  String text;
  String number;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: Column(
        children: [Text(text,style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s16),),
        SizedBox(height: 10.h,),
        Stack(children: [
          SvgPicture.asset(
            IconAssets.backNumber,
          ),
          Padding(
            padding: EdgeInsets.only(top: 3.h,left: 5.w),
            child: Text(number,style:getBoldStyle(color: ColorManager.black,fontSize: FontSize.s14) ,),
          )
        ],)
        //IconAssets
        ],
      ),
    );
  }
}
class  WidgetHome extends StatelessWidget {
     WidgetHome({Key? key,required this.text,required this.buttomText,required this.buttonPress,required this.imagePath}) : super(key: key);
String text;
  String buttomText;
     VoidCallback  buttonPress;
     String imagePath;
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(17.r),

      dashPattern: const <double>[8, 4],
      color: ColorManager.black,
      strokeCap: StrokeCap.butt,
      strokeWidth: 1,

      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(17.r)),
        child: Container(
            height: 133.h,
            padding: EdgeInsets.all(20.w),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(17.r),
            color: ColorManager.white,
                boxShadow: [
                BoxShadow(
                offset: const Offset(0, 3),
                blurRadius: 6,
                color: Colors.black.withOpacity(0.16),
        ),
          ]
            ),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              SizedBox(
                  width:110.w,
                  height: 80.h,
                  child: Image(image: AssetImage(imagePath))),
                SizedBox(width:25.w ,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(text,style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s16),),
                    SizedBox(height: 17.h,),
                    SizedBox(
                        width: 130.w,
                        height: 35.h,
                        child: ElevatedButton(onPressed: buttonPress, child: Text(buttomText,style: getRegularStyle(color: ColorManager.white,fontSize: FontSize.s14),)))
                  ],
                )
              ],
            )
        ),
      ),
    );
  }
}
