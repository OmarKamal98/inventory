import 'dart:developer';
import 'dart:io';
import 'dart:io' show Platform;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:inventory/data/api/dio_client.dart';
import 'package:inventory/modle/delete_request.dart';
import 'package:inventory/modle/edit_request.dart';
import 'package:inventory/modle/item_model.dart';
import 'package:inventory/modle/post_Stocktaking.dart';
import 'package:inventory/modle/role_model.dart';
import 'package:inventory/modle/users_app_model.dart';
import 'package:inventory/resources/constants_manager.dart';
import 'package:inventory/resources/router_class.dart';
import 'package:inventory/ui/category_screen/category_screen.dart';
import 'package:inventory/ui/no_interner_screen.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class APIProvider extends ChangeNotifier {
  APIProvider() {
    getItem();
    getUsers();
    getDeleteRequest();
    getEditRequest();
    getStocktaking();
    checkPlatform();
  }
  bool admin=false;
  bool delete=false;
  bool edit=false;
  changeAdminRoleAddUser(){
    admin = !admin;
    notifyListeners();
  }
  bool isAndroid=false;
  bool isIos=false;
  checkPlatform(){
    if (Platform.isAndroid) {
      isAndroid=true;
    } else if (Platform.isIOS) {
        isIos=true;
    }
  }
  changeDeleteRoleAddUser(){
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
  }
  changeSelectedSectionAr(String ss){
    selectedSectionAr=ss;
    notifyListeners();
  }
  List<Item>? allItem=[];
  List<Item> searchItem=[];
  List<UsersApp>? allUser=[];
  List<DeleteRequest>? allDeletedRequest=[];
  List<EditRequest>? allEditRequest=[];
  List<StocktakingModel>? allStocktakingModel=[];
  List<StocktakingModel>? allStocktaking1=[];
  List<StocktakingModel>? allStocktaking2=[];
  bool noResulr=false;
  getItem()async{


    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      allItem=await DioClient.dioClient.getItem();
      if(allItem!=null){
        searchItem=allItem!;  }
    } else {
      RouterClass.routerClass.pushWidget((NOInternerScreen()));
    }
     notifyListeners();
   }
  getUsers()async{
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      allUser=await DioClient.dioClient.getUsersApp();
      allUser!.removeWhere((element) => element.id==AppConstants.userApi!.id);
    } else {
      RouterClass.routerClass.pushWidget((NOInternerScreen()));
    }
     notifyListeners();
   }
  postUser(AddUserRequest  userRequest)async{
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
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
    } else {
      RouterClass.routerClass.pushWidget((NOInternerScreen()));
    }

     notifyListeners();
   }
  deleteUser(String userId)async{
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      String? success;
    success= await DioClient.dioClient.deleteUsersApp(userId);
    if(success !=null){
      getUsers();
    }
     } else {
      RouterClass.routerClass.pushWidget((NOInternerScreen()));
    }


   }
  changeRole(RoleModel roleModel)async{
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      RoleModel? roleModel2;
      roleModel2=  await DioClient.dioClient.changeRole(roleModel);
      roleModel2!=null? getUsers():log('error');

    } else {
      RouterClass.routerClass.pushWidget((NOInternerScreen()));
    }


     notifyListeners();
   }
  postStocktaking(StocktakingModel stocktakingModel)async{

    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      await DioClient.dioClient.postStocktaking(stocktakingModel);
    } else {
      RouterClass.routerClass.pushWidget((NOInternerScreen()));
    }


  }
  deleteStocktaking(BuildContext context)async{
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      List<StocktakingModel> listToExcel= context.locale==Locale('en')?selectedSection=='Section One'?allStocktaking1!:allStocktaking2!: selectedSectionAr=='الفرع الاول'? allStocktaking1!:allStocktaking2!;
    for(int i=0;i<listToExcel.length;i++) {
      await DioClient.dioClient.deleteStocktaking(listToExcel[i].invrecid.toString());
    }
    getStocktaking();
    } else {
      RouterClass.routerClass.pushWidget((NOInternerScreen()));
    }



  }
  postDeleteRequest(DeleteRequest deleteRequest)async{
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      await DioClient.dioClient.postDeleteRequest(deleteRequest);
    } else {
      RouterClass.routerClass.pushWidget((NOInternerScreen()));
    }


  }
  postEditRequest(EditRequest editRequest)async{
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      await DioClient.dioClient.postEditRequest(editRequest);
    } else {
      RouterClass.routerClass.pushWidget((NOInternerScreen()));
    }


  }
  getDeleteRequest()async{
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      if(AppConstants.userApi!.roleName!.first.toLowerCase()=='founder'||AppConstants.userApi!.roleName!.first.toLowerCase()=='admin') {
      allDeletedRequest = await DioClient.dioClient.getDeleteRequest();
      notifyListeners();
    }
    } else {
      RouterClass.routerClass.pushWidget((NOInternerScreen()));
    }

  }
  getEditRequest()async{
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      if(AppConstants.userApi!.roleName!.first.toLowerCase()=='founder'||AppConstants.userApi!.roleName!.first.toLowerCase()=='admin'){
      allEditRequest =await DioClient.dioClient.getEditRequest();
      notifyListeners();
    }
    } else {
      RouterClass.routerClass.pushWidget((NOInternerScreen()));
    }

  }
  getStocktaking()async{
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      if(AppConstants.userApi!.roleName!.first.toLowerCase()=='founder'||AppConstants.userApi!.roleName!.first.toLowerCase()=='admin') {
      allStocktakingModel = await DioClient.dioClient.getStocktaking();
      allStocktaking1 =
          allStocktakingModel!.where((element) => element.branches ==
              'Section One' || element.branches == 'الفرع الاول').toList();
      allStocktaking2 =
          allStocktakingModel!.where((element) => element.branches ==
              'Section Two' || element.branches == 'الفرع الثاني').toList();
      notifyListeners();
    }

    } else {
      RouterClass.routerClass.pushWidget((NOInternerScreen()));
    }

  }
  upDateItem(Item item)async{
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      String? isSuccess;
    isSuccess=await DioClient.dioClient.upDateItem(item);
    if(isSuccess !=null){
      allItem!.removeWhere((element) => element.icode==item.icode);
      allItem!.add(item);
      searchItem=allItem!;

      notifyListeners();
    }
    } else {
      RouterClass.routerClass.pushWidget((NOInternerScreen()));
    }

  }
  deleteRequstModification(String id)async{
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      String? isSuccess;
    isSuccess=  await DioClient.dioClient.deleteTheREquestModification(id);
    if(isSuccess !=null){
      getEditRequest();
      log('delete request true');
    }
    } else {
      RouterClass.routerClass.pushWidget((NOInternerScreen()));
    }

  }
  deleteTheREquestDeletion(String id)async{
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      String? isSuccess;
    isSuccess=  await DioClient.dioClient.deleteTheREquestDeletion(id);
    if(isSuccess !=null){
      getDeleteRequest();
      log('delete request true');
    }
    } else {
      RouterClass.routerClass.pushWidget((NOInternerScreen()));
    }

  }
  deleteItem(String icode)async{
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      String? isSuccess;
    isSuccess=  await DioClient.dioClient.deleteItem(icode);
    if(isSuccess !=null){
      allItem!.removeWhere((element) => element.icode==icode);
      searchItem=allItem!;
      notifyListeners();
      log('delete item true');
    }
    } else {
      RouterClass.routerClass.pushWidget((NOInternerScreen()));
    }

  }
  postItem(Item item)async{
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {String? item2;
    item2= await DioClient.dioClient.postItem(item);
    if(item2!=null){
      log('post item success');
    }
    } else {
      RouterClass.routerClass.pushWidget((NOInternerScreen()));
    }

  }
  List<Item> itemSearch=[];
  searchwhenPost(String icode){
  itemSearch = allItem!
      .where((product) =>
      product.icode==icode.trim() ||product.icode1==icode.trim()||product.icode2==icode.trim()||product.icode3==icode.trim())
      .toList();
}
  Future<void> createExcel(List<StocktakingModel> listToExcel) async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    sheet.getRangeByName('a1').setText('Product code');
    sheet.getRangeByName('b1').setText('Product Name');
    sheet.getRangeByName('c1').setText('piece');
    sheet.getRangeByName('d1').setText('Section');
    for(int i=0;i<listToExcel.length;i++){
      sheet.getRangeByName('a'+(i+2).toString()).setText(listToExcel[i].icode);
      sheet.getRangeByName('b'+(i+2).toString()).setText(listToExcel[i].idscr);
      sheet.getRangeByName('c'+(i+2).toString()).setText(listToExcel[i].invqty.toString());
      sheet.getRangeByName('d'+(i+2).toString()).setText(listToExcel[i].branches);
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName = '$path/Output.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);

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
          product.idscr!.toLowerCase().contains(
              searchController.text.toLowerCase().trim())||product.icode!.contains(searchController.text.trim()) ||product.icode1!.contains(searchController.text.trim()) ||product.icode2!.contains(searchController.text.trim()) ||product.icode3!.contains(searchController.text.trim())
      )
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
        if (allItem![i].icode!.trim()==barcodeScanRes.trim()||allItem![i].icode1!.trim()==barcodeScanRes.trim()||allItem![i].icode2!.trim()==barcodeScanRes.trim()||allItem![i].icode3!.trim()==barcodeScanRes.trim()) {
          item = allItem![i];
        }
      }
      if (item == null) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return  AlertDialog(
                title: Text('errorSearch'.tr()),
                content: Text('noResultFound'.tr()),
              );
            });
      } else {
        RouterClass.routerClass.pushWidget(CategoryScreen(item: item!));
        item = null;
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

  }
  Future<Item?> scanQRFill(BuildContext context) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      for (int i = 0; i < allItem!.length; i++) {
        if (allItem![i].icode!.trim()==barcodeScanRes.trim()||allItem![i].icode1!.trim()==barcodeScanRes.trim()||allItem![i].icode2!.trim()==barcodeScanRes.trim()||allItem![i].icode3!.trim()==barcodeScanRes.trim()) {
          item = allItem![i];
        }
      }
      if (item == null) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return  AlertDialog(
                title: Text('errorSearch'.tr()),
                content: Text('noResultFound'.tr()),
              );
            });
      } else {
       return item!;
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
      return null;

    }

  }
}
