import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:inventory/data/api/dio_client.dart';
import 'package:inventory/modle/user_model.dart';
import 'package:inventory/resources/constants_manager.dart';
import 'package:inventory/resources/router_class.dart';
import 'package:inventory/ui/auth/Login.dart';
import 'package:inventory/ui/home_screen/home_screen.dart';
import 'package:inventory/ui/home_screen/user_home_screen.dart';
import 'package:inventory/ui/no_interner_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AuthProvider extends ChangeNotifier{
  AuthProvider() {
    initSp();
  }
  bool showPassword=false;
  changeShowPass(){
    showPassword= !showPassword;
    notifyListeners();
  }
  UserApi? userApi;
  SharedPreferences? _prefs ;
  initSp() async {
    _prefs ??= await SharedPreferences.getInstance();
    notifyListeners();
  }
  bool isLoading = false;
  changeIsLoading(){
    isLoading= !isLoading;
    notifyListeners();
  }
  login(LoginData loginData,BuildContext context) async {
     userApi = await DioClient.dioClient.login(loginData);
    if(userApi != null){
      log(' login success');
      AppConstants.userApi=userApi;
      if(userApi!.roleName!.first.toLowerCase() =='user'||userApi!.roleName!.first.toLowerCase() =='edit'||userApi!.roleName!.first.toLowerCase() =='delete'){
        RouterClass.routerClass.pushWidgetReplacement(UserHomeScreen());
      }
      else{
        RouterClass.routerClass.pushWidgetReplacement(AdminHomeScreen());
      }
      _prefs!.setBool('isLogin', true);
      _prefs!.setString('userName', loginData.userName!);
      _prefs!.setString('password', loginData.password!);
      notifyListeners();
    }else{
      final  snackBar = SnackBar(
        content: Text('errorPassWord'.tr()),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }

  }
  logOut(){

    AppConstants.userApi=null;
    _prefs!.setBool('isLogin', false);
    _prefs!.setString('userName', ' ');
    _prefs!.setString('password', ' ');
    RouterClass.routerClass.pushWidgetReplacement(LoginScreen());
  }

  changeArabic(BuildContext context){
    context.setLocale(const Locale('ar'));
    notifyListeners();
  }
  changeEnglish(BuildContext context){
    context.setLocale(const Locale('en'));
    notifyListeners();
  }
}
