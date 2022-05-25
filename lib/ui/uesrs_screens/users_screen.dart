import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/router_class.dart';
import 'package:inventory/resources/styles_manager.dart';
import 'package:inventory/ui/uesrs_screens/add_user_screen.dart';
import 'package:inventory/ui/uesrs_screens/user_detail_screen.dart';

class UserScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Column(
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
                Text('users'.tr(), style: getMediumStyle(
                color: ColorManager.white, fontSize: FontSize.s22),),
                const Spacer(),
                IconButton(onPressed: (){
                  RouterClass.routerClass.pushWidget(AddUserScreen());
                }, icon: Icon(Icons.add, color: ColorManager.white,size: 26,))
              ],), SizedBox(height: 25.h,),],
            ),
          ),
          SizedBox(height: 15.h,),
          Expanded( child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 10, itemBuilder: (context, index) {
             return Slidable(
               key: ValueKey(index),
               startActionPane: ActionPane(
                 motion: const ScrollMotion(),
                 dismissible: DismissiblePane(onDismissed: () => AlertDialog(
                      title: const Text("Confirm"),
                      content: const Text("Are you sure you wish to delete this item?"),
                      actions: <Widget>[
                      ElevatedButton(
                      onPressed: () {},
                      child: const Text("DELETE")),
                      ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("CANCEL"),
                      ),
                      ],
                      )),
                 children:   [
                   SlidableAction(
                     onPressed: (BuildContext context) {},
                     backgroundColor: Color(0xFFFE4A49),
                     foregroundColor: Colors.white,
                     icon: Icons.delete,
                     label: 'Delete',
                   ),],),
               child: UsersWidget(onTap1: (){
                 RouterClass.routerClass.pushWidget(UserDetailScreen());
               },),
             );
             //   Dismissible(
             //   key: UniqueKey(),
             //   direction: DismissDirection.startToEnd,
             //   onDismissed: (direction) {
             //     // provider.itemCart.
             //   }, child: UsersWidget() ,
             //   confirmDismiss: (DismissDirection direction) async {
             //     return await showDialog(
             //       context: context,
             //       builder: (BuildContext context) {
             //         return AlertDialog(
             //           title: const Text("Confirm"),
             //           content: const Text("Are you sure you wish to delete this item?"),
             //           actions: <Widget>[
             //             ElevatedButton(
             //                 onPressed: ()
             //                 {
             //
             //                   },
             //                 child: const Text("DELETE")
             //             ),
             //             ElevatedButton(
             //               onPressed: () => Navigator.of(context).pop(false),
             //               child: const Text("CANCEL"),
             //             ),
             //           ],
             //         );
             //       },
             //     );
             //   },
             //
             //   background: Container(
             //     decoration: BoxDecoration(color: ColorManager.red,borderRadius: BorderRadius.circular(8.r)),
             //     margin: EdgeInsets.symmetric(horizontal: 20.w),
             //     alignment: Alignment.centerRight,
             //     child: Icon(Icons.delete_forever,color: Colors.white,),
             //   ),
             // );
          } )),
          SizedBox(height: 15.h,)

        ],
      ),
    );

  }

}

class UsersWidget extends StatelessWidget {
    UsersWidget({Key? key,required this.onTap1}) : super(key: key);
    VoidCallback onTap1;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap1 ,
      child: Container(
        height: 90.h,
        margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: ColorManager.white3,
          borderRadius:BorderRadius.circular(8.r)
        ),
        child: Column(children: [
          Row(children: [
            Text('Ahmed Kamel',style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
            Spacer(),
            Text('lastSeen'.tr(),style: getLightStyle(color: ColorManager.black,fontSize: FontSize.s10)),

          ],),
          SizedBox(height: 3.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Transform.scale(
                scale: 1.6,
                child: Checkbox(
                  checkColor: Colors.white,
                  value: false,
                  onChanged: (bool? value) {

                  },
                ),
              ),
              Text('edit'.tr(),style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14),),
               Transform.scale(
                scale: 1.6,
                child: Checkbox(
                  checkColor: Colors.white,
                  value: false,

                  onChanged: (bool? value) {

                  },
                ),
              ),
              Text('delete'.tr(),style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14),),
               Transform.scale(
                scale: 1.6,
                child: Checkbox(
                  checkColor: Colors.white,
                  value: false,

                  onChanged: (bool? value) {

                  },
                ),
              ),
              Text('admin'.tr(),style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14),),

            ],
          ),
        ],),
      ),
    );
  }

}
