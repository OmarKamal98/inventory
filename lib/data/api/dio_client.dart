import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:inventory/data/api/apiconst.dart';
import 'package:inventory/modle/delete_request.dart';
import 'package:inventory/modle/edit_request.dart';
import 'package:inventory/modle/item_model.dart';
import 'package:inventory/modle/post_Stocktaking.dart';
import 'package:inventory/modle/role_model.dart';
import 'package:inventory/modle/user_model.dart';
import 'package:inventory/modle/users_app_model.dart';
import 'package:inventory/resources/constants_manager.dart';

class DioClient {
  DioClient._() {initDio();}
  static final DioClient dioClient = DioClient._();
  Dio? dio;
  initDio() {dio = Dio();
     dio?.options.baseUrl = ApiConstant.baseUrl;}
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
      Response response = await dio!.get(ApiConstant.item,
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
  Future<String?> postItem (Item itempost)async {
    try {
      log('start post Item');
      String token=AppConstants.userApi!.token!;

      Response response = await dio!.post(ApiConstant.item,
      data: itempost.toJson(),
      options: Options(headers: {"Authorization":"Bearer $token"})
      );
     if(response.statusCode==200){

       return 'Success';
     }
      log('finish post Item');
      return 'Success';
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
  Future<String?> postUsersApp (AddUserRequest addUser)async {
    try {
      await dio!.post(ApiConstant.register,
      data: addUser.toJson()
      );
    return 'success';
    } on Exception {
      return null;
    }
  }
  Future<String?> deleteUsersApp (String userID)async {
    try {
      log('start delete');
      String token=AppConstants.userApi!.token!;
      await dio!.delete(ApiConstant.getUsers+'/$userID',
          options: Options(headers: {"Authorization":"Bearer $token"})
      );
      log('end delete');
    return 'success';
    } on Exception catch(e){
      print(e);
      return null;
    }
  }
  Future<RoleModel?> changeRole (RoleModel roleModel1)async {
    try {
      String token=AppConstants.userApi!.token!;
      Response response = await dio!.post(ApiConstant.addRole,
          data: roleModel1.toJson(),
          options: Options(headers: {"Authorization":"Bearer $token"})
      );
      RoleModel roleModel=RoleModel.fromJson(response.data);

    return roleModel;
    } on Exception catch(e) {
      print(e);
      return null;
    }
  }
  Future<String?> postStocktaking (StocktakingModel stocktakingModel)async {
    try {
      String token=AppConstants.userApi!.token!;
      Response response = await dio!.post(ApiConstant.stocktaking,
          data: stocktakingModel.toJson(),
          options: Options(headers: {"Authorization":"Bearer $token"})
      );
     if(response.statusCode==200 ){
       return 'success';
     }
    return 'success';
    } on Exception catch(e) {
      print(e);
      return null;
    }
  }
  Future<List<StocktakingModel>?> getStocktaking ()async {
    try {
      log('start get stocktaking');
      String token=AppConstants.userApi!.token!;
      List<StocktakingModel> st=[];
      Response response = await dio!.get(ApiConstant.stocktaking,
          options: Options(headers: {"Authorization":"Bearer $token"})
      );

     if(response.statusCode==200 ){
       response.data.forEach((data) {
         StocktakingModel item = StocktakingModel.fromJson(data);
         st.add(item);
       });
       return st;
     }
    return st;
    } on Exception catch(e) {
      print(e);
      return null;
    }
  }
  Future<String?> deleteStocktaking (String id)async {
    try {
      String token=AppConstants.userApi!.token!;
      Response response = await dio!.delete(ApiConstant.stocktaking+'/$id',
          options: Options(headers: {"Authorization":"Bearer $token"})
      );
      if(response.statusCode==200 ){
        return 'success';
      }
      return 'success';
    } on Exception catch(e) {
      print(e);
      return null;
    }
  }

  Future<String?> postDeleteRequest (DeleteRequest deleteRequest)async {
    try {
      String token=AppConstants.userApi!.token!;
      Response response = await dio!.post(ApiConstant.deleteRequest,
          data: deleteRequest.toJson(),
          options: Options(headers: {"Authorization":"Bearer $token"})
      );
     if(response.statusCode==200 ){
       return 'success';
     }
    return 'success';
    } on Exception catch(e) {
      print(e);
      return null;
    }
  }
  Future<List<DeleteRequest>?> getDeleteRequest ()async {
    try {
      String token=AppConstants.userApi!.token!;
      List<DeleteRequest> st=[];
      Response response = await dio!.get(ApiConstant.deleteRequest,
          options: Options(headers: {"Authorization":"Bearer $token"})
      );

     if(response.statusCode==200 ){
       response.data.forEach((data) {
         DeleteRequest item = DeleteRequest.fromJson(data);
         st.add(item);
       });
       return st;
     }
    return st;
    } on Exception catch(e) {
      print(e);
      return null;
    }
  }
  Future<String?> postEditRequest (EditRequest editRequest)async {
    try {
      String token=AppConstants.userApi!.token!;
      Response response = await dio!.post(ApiConstant.editRequest,
          data: editRequest.toJson(),
          options: Options(headers: {"Authorization":"Bearer $token"})
      );
     if(response.statusCode==200 ){
       return 'success';
     }
    return 'success';
    } on Exception catch(e) {
      print(e);
      return null;
    }
  }
  Future<List<EditRequest>?> getEditRequest ()async {
    try {
      String token=AppConstants.userApi!.token!;
      List<EditRequest> st=[];
      Response response = await dio!.get(ApiConstant.editRequest,
          options: Options(headers: {"Authorization":"Bearer $token"})
      );

     if(response.statusCode==200 ){
       response.data.forEach((data) {
         EditRequest item = EditRequest.fromJson(data);
         st.add(item);
       });
       return st;
     }
    return st;
    } on Exception catch(e) {
      print(e);
      return null;
    }
  }
  Future<String?>  deleteItem (String icode)async {
    try {
      String token=AppConstants.userApi!.token!;
      Response response = await dio!.delete(ApiConstant.item+'/$icode',
          options: Options(headers: {"Authorization":"Bearer $token"})
      );
      if(response.statusCode==200 ){
        return 'success';
      }
      return 'success';
    } on Exception catch(e) {
      print(e);
      return null;
    }
  }
  Future<String?> upDateItem (Item item)async {
    try {
      String token=AppConstants.userApi!.token!;
      String icode=item.icode!;
      Response response = await dio!.put(ApiConstant.item+'/$icode',
          data: item.toJson(),
          options: Options(headers: {"Authorization":"Bearer $token"})
      );
      if(response.statusCode==200 ){
        return 'success';
      }
      return 'success';
    } on Exception catch(e) {
      print(e);
      return null;
    }
  }
  Future<String?> deleteTheREquest (String icode)async {
    try {
      String token=AppConstants.userApi!.token!;
      Response response = await dio!.delete(ApiConstant.deleteTheRequest+'/$icode',
          options: Options(headers: {"Authorization":"Bearer $token"})
      );
      if(response.statusCode==200 ){
        return 'success';
      }
      return 'success';
    } on Exception catch(e) {
      print(e);
      return null;
    }
  }
}
