import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inventory/data/api/dio_client.dart';
import 'package:inventory/modle/user_model.dart';
import 'package:inventory/resources/constants_manager.dart';
import 'package:inventory/resources/router_class.dart';
import 'package:inventory/ui/auth/Login.dart';
import 'package:inventory/ui/home_screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AuthProvider extends ChangeNotifier{
  AuthProvider() {
    initSp();
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
login(LoginData loginData)async{
  userApi =await DioClient.dioClient.login(loginData);
  if(userApi!=null){
    log(' login success');
    AppConstants.userApi=userApi;
    RouterClass.routerClass.pushWidgetReplacement(AdminHomeScreen());
    _prefs!.setBool('isLogin', true);
    _prefs!.setString('userName', loginData.userName!);
    _prefs!.setString('password', loginData.password!);
  }
}



logOut(){
  AppConstants.userApi=null;
  _prefs!.setBool('isLogin', false);
  _prefs!.setString('userName', ' ');
  _prefs!.setString('password', ' ');
  RouterClass.routerClass.pushWidgetReplacement(LoginScreen());
}
}
