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
          Future.delayed(const Duration(seconds: 6), () {
            Navigator.of(context).pop(true);
          });
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    Provider.of<APIProvider>(context,listen: false).getUsers();
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
                      key: const ValueKey(0),
                      startActionPane: ActionPane(
                        motion:   const StretchMotion(),
                        children:   [
                          SlidableAction(
                            onPressed: (context) async{
                                return await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                return AlertDialog(
                                title:const Text("Confirm"),
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
                            backgroundColor: ColorManager.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'delete'.tr(),
                          ),

                        ],
                      ),

                      // The end action pane is the one at the right or the bottom side.


                      child: UsersWidget(onTap1: (){
                      RouterClass.routerClass.pushWidget(UserDetailScreen(usersApp:  provider.allUser![index],));
                    },usersApp: provider.allUser![index],adminTap:(bool? value) {
                    if(AppConstants.userApi!.roleName!.first.toLowerCase() =='founder') {
                    if (provider.allUser![index].roles!.first.toLowerCase() == 'admin') {
                      buildShowDialog(context);
                        RoleModel role = RoleModel(
                            userId: provider.allUser![index].id,
                            roleName: 'user');
                        provider.changeRole(role);
                      } else if(provider.allUser![index].roles!.first.toLowerCase() != 'founder'){
                      RoleModel role = RoleModel(
                          userId: provider.allUser![index].id,
                          roleName: 'admin');
                      provider.changeRole(role);
                    }else{
                      return showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('warning'.tr()),
                            content: Text('dontHaveRole'.tr()),
                            actions: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: Text('cancel'.tr()),
                                  ),
                                ],
                              ),

                            ],
                          );
                        },
                      );
                    }
                    } else {
                      return showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('warning'.tr()),
                            content: Text('dontHaveRole'.tr()),
                            actions: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: Text('cancel'.tr()),
                                  ),
                                ],
                              ),

                            ],
                          );
                        },
                      );
                    }
                    } ,editTap: (bool? value) {
                        if(AppConstants.userApi!.roleName!.first.toLowerCase() =='founder'){
                            if (provider.allUser![index].roles!.first.toLowerCase() =='admin' ){
                              buildShowDialog(context);
                              RoleModel role = RoleModel(
                                  userId: provider.allUser![index].id,
                                  roleName: 'delete');
                              provider.changeRole(role);
                            } else if (provider.allUser![index].roles!.first .toLowerCase() =='edit' && !(provider.allUser![index].roles!.first.toLowerCase() == 'delete')) {
                              buildShowDialog(context);
                              RoleModel role = RoleModel(
                                  userId: provider.allUser![index].id,
                                  roleName: 'user');
                              provider.changeRole(role);
                            } else if (provider.allUser![index].roles!.first .toLowerCase() =='delete' && !(provider.allUser![index].roles!.first .toLowerCase() =='edit')) {
                              buildShowDialog(context);
                              RoleModel role = RoleModel(
                                  userId: provider.allUser![index].id,
                                  roleName: 'admin');
                              provider.changeRole(role);
                            } else if(provider.allUser![index].roles!.first .toLowerCase() == 'user'){
                              buildShowDialog(context);
                              RoleModel role = RoleModel(
                                  userId: provider.allUser![index].id,
                                  roleName: 'edit');
                              provider.changeRole(role);
                            }else{
                              return showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('warning'.tr()),
                                    content: Text('dontHaveRole'.tr()),
                                    actions: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(false),
                                            child: Text('cancel'.tr()),
                                          ),
                                        ],
                                      ),

                                    ],
                                  );
                                },
                              );
                            }
                          }else{
                          if (provider.allUser![index].roles!.first .toLowerCase() =='edit' && !(provider.allUser![index].roles!.first.toLowerCase() == 'delete')) {
                            buildShowDialog(context);
                            RoleModel role = RoleModel(
                                userId: provider.allUser![index].id,
                                roleName: 'user');
                            provider.changeRole(role);
                          } else if (provider.allUser![index].roles!.first .toLowerCase() =='delete' && !(provider.allUser![index].roles!.first .toLowerCase() =='edit')) {
                            buildShowDialog(context);
                            RoleModel role = RoleModel(
                                userId: provider.allUser![index].id,
                                roleName: 'edit');
                            provider.changeRole(role);
                          } else if(provider.allUser![index].roles!.first .toLowerCase() == 'user'){
                            buildShowDialog(context);
                            RoleModel role = RoleModel(
                                userId: provider.allUser![index].id,
                                roleName: 'edit');
                            provider.changeRole(role);
                          }else{
                            return showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('warning'.tr()),
                                  content: Text('dontHaveRole'.tr()),
                                  actions: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: Text('cancel'.tr()),
                                        ),
                                      ],
                                    ),

                                  ],
                                );
                              },
                            );
                          }
                        }
                        },deletedTap:(bool? value) {
                        if(AppConstants.userApi!.roleName!.first.toLowerCase() =='founder'){
                          if (provider.allUser![index].roles!.first.toLowerCase() =='admin' ){
                            buildShowDialog(context);
                            RoleModel role = RoleModel(
                                userId: provider.allUser![index].id,
                                roleName: 'edit');
                            provider.changeRole(role);
                          } else if (provider.allUser![index].roles!.first .toLowerCase() =='edit' && !(provider.allUser![index].roles!.first.toLowerCase() == 'delete')) {
                            buildShowDialog(context);
                            RoleModel role = RoleModel(
                                userId: provider.allUser![index].id,
                                roleName: 'admin');
                            provider.changeRole(role);
                          } else if (provider.allUser![index].roles!.first .toLowerCase() =='delete' && !(provider.allUser![index].roles!.first .toLowerCase() =='edit')) {
                            buildShowDialog(context);
                            RoleModel role = RoleModel(
                                userId: provider.allUser![index].id,
                                roleName: 'user');
                            provider.changeRole(role);
                          } else if(provider.allUser![index].roles!.first .toLowerCase() == 'user'){
                            buildShowDialog(context);
                            RoleModel role = RoleModel(
                                userId: provider.allUser![index].id,
                                roleName: 'delete');
                            provider.changeRole(role);
                          }else{
                            return showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('warning'.tr()),
                                  content: Text('dontHaveRole'.tr()),
                                  actions: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: Text('cancel'.tr()),
                                        ),
                                      ],
                                    ),

                                  ],
                                );
                              },
                            );
                          }
                        }else{
                          if (provider.allUser![index].roles!.first .toLowerCase() =='edit' && !(provider.allUser![index].roles!.first.toLowerCase() == 'delete')) {
                            buildShowDialog(context);
                            RoleModel role = RoleModel(
                                userId: provider.allUser![index].id,
                                roleName: 'delete');
                            provider.changeRole(role);
                          } else if (provider.allUser![index].roles!.first .toLowerCase() =='delete' && !(provider.allUser![index].roles!.first .toLowerCase() =='edit')) {
                            buildShowDialog(context);
                            RoleModel role = RoleModel(
                                userId: provider.allUser![index].id,
                                roleName: 'user');
                            provider.changeRole(role);
                          } else if(provider.allUser![index].roles!.first .toLowerCase() == 'user'){
                            buildShowDialog(context);
                            RoleModel role = RoleModel(
                                userId: provider.allUser![index].id,
                                roleName: 'delete');
                            provider.changeRole(role);
                          }else{
                            return showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('warning'.tr()),
                                  content: Text('dontHaveRole'.tr()),
                                  actions: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: Text('cancel'.tr()),
                                        ),
                                      ],
                                    ),

                                  ],
                                );
                              },
                            );
                          }
                        }
                    } ,),
                    );

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
        height:provider.isAndroid? 110.h:95.h,
        margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: ColorManager.white3,
          borderRadius:BorderRadius.circular(8.r)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Center(child: InkWell(
              onTap:onTap1 ,
              child: Text(usersApp.userName!,style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),)),)

         , Row(
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
            ],),
          Text(usersApp.lastSeen!,style: getLightStyle(color: ColorManager.black,fontSize: FontSize.s10)),

        ],),
     );

    }
    );
  }

}