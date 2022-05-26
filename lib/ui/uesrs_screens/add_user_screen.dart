import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/modle/users_app_model.dart';
import 'package:inventory/provider/api_provider.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/styles_manager.dart';
import 'package:inventory/ui/component/input_text_field.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

class AddUserScreen extends StatelessWidget {
TextEditingController userNameController=TextEditingController();
TextEditingController passwordController=TextEditingController();
TextEditingController emailController=TextEditingController();
TextEditingController jobIdController=TextEditingController();
TextEditingController locationController=TextEditingController();
TextEditingController jobController=TextEditingController();

GlobalKey<FormState> adduserFormkey = GlobalKey<FormState>();
bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Form(
        key: adduserFormkey,
        child: Consumer<APIProvider>(
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
                        Icon(Icons.arrow_back_ios,color: ColorManager.white,size: 20,),
                        SizedBox(width: 15.w,),
                        Text('adduser'.tr(), style: getMediumStyle(
                            color: ColorManager.white, fontSize: FontSize.s22),),
                        const Spacer(),
                      ],), SizedBox(height: 25.h,),],
                ),
              ),
              SizedBox(height: 25.h,),
              Padding(
                padding:   EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Text('userName'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                    Spacer(),
                    InputTextFeild(controller: userNameController,width: 240.w,color2: ColorManager.white3,validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'هذا الحقل مطلوب';
                      }else if(value.contains(' ')){
                        return 'no contain space';
                      }
                      return null;

                    })
                  ],
                ),
              ),
              SizedBox(height: 20.h,),
              Padding(
                padding:   EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Text('password'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                    Spacer(),
                    InputTextFeild(controller: passwordController,width: 240.w,color2: ColorManager.white3,validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'هذا الحقل مطلوب';
                      }
                      return null;

                    })
                  ],
                ),
              ),
              SizedBox(height: 20.h,),
              Padding(
                padding:   EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Text('email'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                    Spacer(),
                    InputTextFeild(controller: emailController,width: 240.w,color2: ColorManager.white3,validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'هذا الحقل مطلوب';
                      }else if(!isEmail(value)){
                        return 'error email syntx';
                      }
                      return null;

                    })
                  ],
                ),
              ),
              SizedBox(height: 20.h,),
              Padding(
                padding:   EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Text('jobID'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                    Spacer(),
                    InputTextFeild(controller: jobIdController,width: 240.w,color2: ColorManager.white3,keyboardType: TextInputType.number,validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'هذا الحقل مطلوب';
                      }else if(!isNumeric(value)){
                        return 'must be number';
                      }
                      return null;

                    })
                  ],
                ),
              ),
              SizedBox(height: 20.h,),
              Padding(
                padding:   EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Text('location'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                    Spacer(),
                    InputTextFeild(controller: locationController,width: 240.w,color2: ColorManager.white3,validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'هذا الحقل مطلوب';
                      }
                      return null;

                    })
                  ],
                ),
              ),
              SizedBox(height: 20.h,),
              Padding(
                padding:   EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Text('job'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                    Spacer(),
                    InputTextFeild(controller: jobController,width: 240.w,color2: ColorManager.white3,validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'هذا الحقل مطلوب';
                      }
                      return null;

                    },)
                  ],
                ),
              ),
              SizedBox(height: 20.h,),
              Divider(endIndent: 20.w,
              indent: 20.w,
              thickness: .5,),
              SizedBox(height: 20.h,),
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
              SizedBox(height: 50.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 40.h,
                      width:134.w,child: ElevatedButton(onPressed: (){
                      if (adduserFormkey.currentState!.validate()) {
                        adduserFormkey.currentState!.save();
                        AddUserRequest addUser = AddUserRequest(userName: userNameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            joBTitle: jobController.text,
                            locEMP: locationController.text,
                            empId: int.parse(jobIdController.text));
                        provider.postUser(addUser);

                       }
                      }, child: Text('save'.tr(),style: getMediumStyle(color: ColorManager.white,fontSize: FontSize.s16),))),
                  SizedBox(height:40.h,width:134.w,child: ElevatedButton(onPressed: (){}, child: Text('cancel'.tr(),style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s16))
                  ,style: ElevatedButton.styleFrom(
                        primary: ColorManager.white,
                        side: BorderSide(width: 1.0, color: ColorManager.primary,),elevation: 1
                    ),
                  )),
                ],
              ),

            ],
          );}
        ),
      ),
    );

  }
}

