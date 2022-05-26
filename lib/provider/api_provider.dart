import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:inventory/data/api/dio_client.dart';
import 'package:inventory/modle/item_model.dart';
import 'package:inventory/modle/users_app_model.dart';

class APIProvider extends ChangeNotifier {
  APIProvider() {
    getItem();
    getUsers();
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
   postUser(AddUserRequest userRequest)async{
     String? isSucccess;
     isSucccess = await DioClient.dioClient.postUsersApp(userRequest);
     if(isSucccess !=null){
       getUsers();
     }
     notifyListeners();
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
