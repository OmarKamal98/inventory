import 'package:flutter/material.dart';

class APIProvider extends ChangeNotifier {
  APIProvider();
  late bool isLoading = false;
  changeIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  late bool isCheckorder = false;
  cahngeIscheckOrder() {
    isCheckorder = !isCheckorder;
    notifyListeners();
  }


}
