import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:inventory/data/api/dio_client.dart';
import 'package:inventory/modle/delete_request.dart';
import 'package:inventory/modle/item_model.dart';
import 'package:inventory/modle/post_Stocktaking.dart';
import 'package:inventory/modle/role_model.dart';
import 'package:inventory/modle/users_app_model.dart';

class APIProvider extends ChangeNotifier {
  APIProvider() {
    getItem();
    getUsers();
  }

  bool admin=false;
  bool delete=false;
  bool edit=false;
  changeAdminRoleAddUser(){
    admin = !admin;
    notifyListeners();
  }changeDeleteRoleAddUser(){
    delete = !delete;
    notifyListeners();
  }changeEditRoleAddUser(){
    edit = !edit;
    notifyListeners();
  }
  bool isLoading = false;
  changeIsLoading(){
    isLoading= !isLoading;
    notifyListeners();
  }
  int numberAddCategory=0;
  addCatScreen(){
    numberAddCategory+=1;
    log(numberAddCategory.toString());
    notifyListeners();
  }
  clearCatScreen(){
    numberAddCategory=0;
  }
  String selectedCode='icode';

  bool isenglish=false;
  String? selectedSection= 'Section One';
  String? selectedSectionAr= 'الفرع الاول';
  changeSelectedCode(String ss){
    selectedCode=ss;
    notifyListeners();
  }
  changeSelectedSection(String ss){
    selectedSection=ss;
    notifyListeners();
  }changeSelectedSectionAr(String ss){
    selectedSectionAr=ss;
    notifyListeners();
  }
  List<Item>? allItem=[];
  List<Item> searchItem=[];
  List<UsersApp>? allUser=[];
  bool noResulr=false;
   getItem()async{
     allItem=await DioClient.dioClient.getItem();
     if(allItem!=null){
     searchItem=allItem!;
     }
     notifyListeners();
   }
   getUsers()async{
     allUser=await DioClient.dioClient.getUsersApp();
     notifyListeners();
   }
   postUser(AddUserRequest  userRequest)async{
     String? isSucccess;
     isSucccess = await DioClient.dioClient.postUsersApp(userRequest);
     if(isSucccess !=null){
      await getUsers();
       RoleModel roleModel ;
       if(admin || (delete&&edit)) {
          roleModel = RoleModel(
             userId: allUser!.last.id, roleName: 'admin');
       }else if(delete){
         roleModel = RoleModel(
             userId: allUser!.last.id, roleName: 'delete');
       }else if(edit){
         roleModel = RoleModel(
             userId: allUser!.last.id, roleName: 'edit');
       }else{
         roleModel = RoleModel(
             userId: allUser!.last.id, roleName: 'user');
       }
       changeRole(roleModel);
     }
     notifyListeners();
   }
   deleteUser(String userId)async{
     String? success;
    success= await DioClient.dioClient.deleteUsersApp(userId);
    if(success !=null){
      getUsers();
    }

   }
   changeRole(RoleModel roleModel)async{
     log('start change');
     RoleModel? roleModel2;
     roleModel2=  await DioClient.dioClient.changeRole(roleModel);
      roleModel2!=null? getUsers():log('error');
    if (roleModel2!=null ){
log(roleModel2.roleName!);
     }
     notifyListeners();
   }

  postStocktaking(StocktakingModel stocktakingModel)async{
     String? isSuccess;
     isSuccess=await DioClient.dioClient.postStocktaking(stocktakingModel);
     if(isSuccess !=null){
       log('stocktakingModel isSuccess');
     }
  }
  postDeleteRequest(DeleteRequest deleteRequest)async{
     String? isSuccess;
     isSuccess=await DioClient.dioClient.postDeleteRequest(deleteRequest);
     if(isSuccess !=null){
       log('stocktakingModel isSuccess');
     }
  }


  //search
  TextEditingController searchController = TextEditingController();
  runFilter() {

    if (searchController.text.length==0) {
      searchItem = [];
      noResulr=false;
      notifyListeners();
    } else {
      searchItem = allItem!
          .where((product) =>
          product.idscr!.toLowerCase().contains(searchController.text.toLowerCase().trim() ))
          .toList();
      if(searchItem.isEmpty){
        noResulr=true;
      }else{
        noResulr=false;
      }
    }
    notifyListeners();

  }
  Item? item;
  Future<void> scanQR(BuildContext context) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      for (int i = 0; i < allItem!.length; i++) {
        if (allItem![i].icode!.trim().contains(barcodeScanRes.trim())) {
          item = allItem![i];
        }
      }
      if (item == null) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AlertDialog(
                title: Text("فشل البحث"),
                content: Text("لا يوجد أصل مطابق "),
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AlertDialog(
                title: Text("ok البحث"),
                content: Text(" يوجد أصل مطابق "),
              );
            });
        // return;
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

  }
}
