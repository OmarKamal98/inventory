import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:inventory/data/api/apiconst.dart';
import 'package:inventory/modle/item_model.dart';
import 'package:inventory/modle/user_model.dart';
import 'package:inventory/modle/users_app_model.dart';
import 'package:inventory/resources/constants_manager.dart';
class DioClient {
  DioClient._() {
    initDio();
  }
  static final DioClient dioClient = DioClient._();
  Dio? dio;
  initDio() {
    dio = Dio();
     dio?.options.baseUrl = ApiConstant.baseUrl;
  }
  Future<UserApi?> login(LoginData loginData) async {
    try {
      log('start login');
      Response response = await dio!.post(ApiConstant.login,
          data:loginData.toJson()
      );
      UserApi user = UserApi.fromJson(response.data);
      return user;
    } on Exception {
      return null;
    }
  }

  Future<List<Item>?> getItem ()async {
    try {
      log('start get Item');
      String token=AppConstants.userApi!.token!;
      List<Item> allItem=[];
      Response response = await dio!.get(ApiConstant.getItem,
      options: Options(headers: {"Authorization":"Bearer $token"})
      );
      response.data.forEach((data) {
        Item item = Item.fromJson(data);
        allItem.add(item);
      });
      log('finish get Item');
      return allItem;
    } on Exception {
      return null;
    }
  }
  Future<List<UsersApp>?> getUsersApp ()async {
    try {
      log('start get users');
      String token=AppConstants.userApi!.token!;
      List<UsersApp> allUsersApp=[];
      Response response = await dio!.get(ApiConstant.getUsers,
      options: Options(headers: {"Authorization":"Bearer $token"})
      );
      response.data.forEach((data) {
        UsersApp user = UsersApp.fromJson(data);
        allUsersApp.add(user);
      });
      log('finish get user');
      log('number of user'+allUsersApp.length.toString());
      return allUsersApp;
    } on Exception {
      return null;
    }
  }

}