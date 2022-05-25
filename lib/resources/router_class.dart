import 'package:flutter/material.dart';

class RouterClass {
  RouterClass._();
  static RouterClass routerClass = RouterClass._();
  GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
  pushByName(String screenName) {
    navKey.currentState?.pushNamed(screenName);
  }

  pushWidget(Widget widget) {
    // BuildContext context= navKey.currentState.context;
    navKey.currentState?.push(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

  pushWidgetReplacement(Widget widget) {
    // BuildContext context = navKey.currentState.context;
    navKey.currentState?.pushReplacement(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }
  pushWidgetRemovePrev(Widget widget,BuildContext context){
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => widget
        ),
        ModalRoute.withName("NavHome")
    );
  }

  popFunction() {
    navKey.currentState?.pop();
  }

  Map<String, Widget Function(BuildContext)> map = {
      // 'NavHome': (context) => MainNavBar(),
    //  'login': (context) => LoginScreen(),
    // 'signup': (context) => SignUp(),
  };
}
