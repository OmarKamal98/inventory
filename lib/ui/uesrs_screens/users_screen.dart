import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:inventory/modle/role_model.dart';
import 'package:inventory/modle/users_app_model.dart';
import 'package:inventory/provider/api_provider.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/constants_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/router_class.dart';
import 'package:inventory/resources/styles_manager.dart';
import 'package:inventory/ui/uesrs_screens/add_user_screen.dart';
import 'package:inventory/ui/uesrs_screens/user_detail_screen.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatelessWidget {
  buildShowDialog(BuildContext context) {
    return  showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 5), () {
            Navigator.of(context).pop(true);
          });
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
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
                 const Spacer(),
                Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                      onTap:()=>RouterClass.routerClass.popFunction(),
                      child: Icon(Icons.arrow_back_ios,color: ColorManager.white,size: 20,)),
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
            Expanded(
                child:RefreshIndicator(
                  triggerMode: RefreshIndicatorTriggerMode.onEdge,
                  backgroundColor: ColorManager.primary,
                  onRefresh: () async{
                    provider.getUsers();
                  },
                  child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: provider.allUser!.length, itemBuilder: (context, index) {
                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      child: UsersWidget(onTap1: (){
                         RouterClass.routerClass.pushWidget(UserDetailScreen(usersApp:  provider.allUser![index],));
                       },usersApp: provider.allUser![index],adminTap:(bool? value) {
                        if(AppConstants.userApi!.roleName!.first.toLowerCase() =='founder') {
                          buildShowDialog(context);
                          if (provider.allUser![index].roles!.first
                              .toLowerCase() == 'admin') {
                            RoleModel role = RoleModel(
                                userId: provider.allUser![index].id,
                                roleName: 'user');
                            provider.changeRole(role);
                          } else {
                            RoleModel role = RoleModel(
                                userId: provider.allUser![index].id,
                                roleName: 'admin');
                            provider.changeRole(role);
                          }
                        }else{
                          return  showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title:  Text('warning'.tr()),
                                content:  Text('dontHaveRole'.tr()),
                                actions:[
                                  Row(
                                    mainAxisAlignment:MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () => Navigator.of(context).pop(false),
                                        child:  Text('cancel'.tr()),
                                      ),
                                    ],
                                  ),

                                ],
                              );
                            },
                          );
                        }

                        } ,editTap: (bool? value) {
                        buildShowDialog(context);
                        if(provider.allUser![index].roles!.first.toLowerCase() =='admin'){
                          RoleModel role=RoleModel(userId:provider.allUser![index].id,roleName: 'delete' );
                          provider.changeRole(role);
                        }else if(provider.allUser![index].roles!.first.toLowerCase() =='edit' && !(provider.allUser![index].roles!.first.toLowerCase() =='delete')){
                          RoleModel role=RoleModel(userId:provider.allUser![index].id,roleName: 'user' );
                          provider.changeRole(role);
                        }else if(provider.allUser![index].roles!.first.toLowerCase() =='delete' && !(provider.allUser![index].roles!.first.toLowerCase() =='edit')){
                          RoleModel role=RoleModel(userId:provider.allUser![index].id,roleName: 'admin' );
                          provider.changeRole(role);
                        }else{
                          RoleModel role=RoleModel(userId:provider.allUser![index].id,roleName: 'edit' );
                          provider.changeRole(role);
                        }
                      },deletedTap:(bool? value) {
                        buildShowDialog(context);
                        if(provider.allUser![index].roles!.first.toLowerCase() =='admin'){
                          RoleModel role=RoleModel(userId:provider.allUser![index].id,roleName: 'edit' );
                          provider.changeRole(role);
                        }else if(provider.allUser![index].roles!.first.toLowerCase() =='edit' && !(provider.allUser![index].roles!.first.toLowerCase() =='delete')){
                          RoleModel role=RoleModel(userId:provider.allUser![index].id,roleName: 'admin' );
                          provider.changeRole(role);
                        }else  if(provider.allUser![index].roles!.first.toLowerCase() =='delete' && !(provider.allUser![index].roles!.first.toLowerCase() =='edit')){
                          RoleModel role=RoleModel(userId:provider.allUser![index].id,roleName: 'user' );
                          provider.changeRole(role);
                        }else {
                          RoleModel role=RoleModel(userId:provider.allUser![index].id,roleName: 'delete' );
                          provider.changeRole(role);
                        }
                      } ,) ,
                      actions: [
                        IconSlideAction(
                          caption: 'delete'.tr(),
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () async {
                              return await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                              return AlertDialog(
                              title:  Text("Confirm"),
                              content:  Text("sureDelete".tr()),
                              actions:[
                                Row(
                              mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                  onPressed: () {
                                  if(AppConstants.userApi!.roleName!.first.toLowerCase()=='founder'){
                                  provider.deleteUser(provider.allUser![index].id!);
                                    RouterClass.routerClass.popFunction();
                                    const snackBar = SnackBar(
                                      content:  Text('delete user success'),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);


                                  }else{
                                    const snackBar = SnackBar(
                                      content:  Text('you Don\'t have Role to delete user!'),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                                  },
                                  child: Text('delete'.tr()),
                                    style: ElevatedButton.styleFrom(
                                      primary: ColorManager.red,
                                      elevation: 1,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child:  Text('cancel'.tr()),
                                  ),
                                ],
                              ),

                              ],
                              );
                              },
                              );
                          },
                        ),
                      ],
                    );

               //  return Dismissible(
               //   key: UniqueKey(),
               //   direction: DismissDirection.startToEnd,
               //   onDismissed: (direction) {
               //     // provider.itemCart.
               //   }, child: UsersWidget(onTap1: (){
               //    RouterClass.routerClass.pushWidget(UserDetailScreen(usersApp:  provider.allUser![index],));
               //  },usersApp: provider.allUser![index],) ,
               // //   confirmDismiss: (DismissDirection direction) async {
               //     return await showDialog(
               //       context: context,
               //       builder: (BuildContext context) {
               //         return AlertDialog(
               //           title: const Text("Confirm"),
               //           content: const Text("Are you sure you wish to delete this item?"),
               //           actions: <Widget>[
               //             ElevatedButton(
               //                 onPressed: () {
               //                   if(AppConstants.userApi!.roleName!.first.toLowerCase()=='founder'){
               //                     provider.deleteUser(provider.allUser![index].id!);
               //                     RouterClass.routerClass.popFunction();
               //                   }else{
               //                     log('you Dont have Role to delete user');
               //                   }
               //                   final snackBar = SnackBar(
               //                     content: const Text('Yay! A SnackBar!'),
               //                     action: SnackBarAction(
               //                       label: 'Undo',
               //                       onPressed: () {
               //                         // Some code to undo the change.
               //                       },
               //                     ),
               //                   );
               //
               //                   ScaffoldMessenger.of(context).showSnackBar(snackBar);
               //
               //                 },
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

               //   background: Container(
               //     decoration: BoxDecoration(color: ColorManager.red,borderRadius: BorderRadius.circular(8.r)),
               //     margin: EdgeInsets.symmetric(horizontal: 20.w),
               //     padding: EdgeInsets.symmetric(horizontal: 20.w),
               //     child: Row(
               //       crossAxisAlignment: CrossAxisAlignment.center,
               //       mainAxisAlignment: MainAxisAlignment.start,
               //       children: [
               //         Icon(Icons.delete_forever,color: Colors.white,size: 40,),
               //       ],
               //     ),
               //   ),
               // );
            } ),
                )),
            SizedBox(height: 15.h,)

          ],
        );}
      ),
    );

  }

}

class UsersWidget extends StatelessWidget {
    UsersWidget({Key? key,required this.onTap1,required this.usersApp,required this.adminTap,required this.editTap,required this.deletedTap}) : super(key: key);
    VoidCallback onTap1;
    final Function(bool?) adminTap;
    final Function(bool?) deletedTap;
    final Function(bool?) editTap;
    UsersApp usersApp;

  bool isAdmin=false;
  bool isDelete=false;
  bool isEdit=false;
  @override
  Widget build(BuildContext context) {
    if(usersApp.roles!.first.toLowerCase() =='founder'){
      isAdmin=true;isDelete=true;isEdit=true;
    }else if(usersApp.roles!.first.toLowerCase() =='admin'){
      isAdmin=true;isDelete=true;isEdit=true;
    }else if(usersApp.roles!.first.toLowerCase() =='delete'){
       isDelete=true;
    }else if(usersApp.roles!.first.toLowerCase() =='edit'){
      isEdit=true;
    }
    return Consumer<APIProvider>(
    builder:(context,provider,x){
     return Container(
        height: 90.h,
        margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: ColorManager.white3,
          borderRadius:BorderRadius.circular(8.r)
        ),
        child: Column(children: [
          Row(children: [
            InkWell(
                onTap:onTap1 ,
                child: Text(usersApp.userName!,style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),)),
            Spacer(),
            Text(usersApp.lastSeen!,style: getLightStyle(color: ColorManager.black,fontSize: FontSize.s10)),
            // Text('lastSeen'.tr(),style: getLightStyle(color: ColorManager.black,fontSize: FontSize.s10)),

          ],),
          SizedBox(height: 3.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Transform.scale(
                scale: 1.6,
                child: Checkbox(
                  activeColor: ColorManager.primary,
                  checkColor: ColorManager.white,
                  value: isEdit,
                  onChanged:editTap ,
                ),
              ),
              Text('edit'.tr(),style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14),),
               Transform.scale(
                scale: 1.6,
                child: Checkbox(
                  activeColor: ColorManager.primary,
                  checkColor: ColorManager.white,
                  value:isDelete,
                  onChanged: deletedTap
                ),
              ),
              Text('delete'.tr(),style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14),),
               Transform.scale(
                scale: 1.6,
                child: Checkbox(
                  activeColor: ColorManager.primary,
                  checkColor: ColorManager.white,
                  value: isAdmin,
                  onChanged:adminTap ,
                ),
              ),
              Text('admin'.tr(),style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14),),
            ],),],),);}
    );
  }

}