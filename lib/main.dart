import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/provider/api_provider.dart';
import 'package:inventory/provider/user_provider.dart';
import 'package:inventory/provider/auth_provider.dart';
import 'package:inventory/resources/router_class.dart';
import 'package:inventory/resources/theme_manager.dart';
import 'package:inventory/ui/no_interner_screen.dart';
import 'package:inventory/ui/splash.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
    ChangeNotifierProvider<APIProvider>(create: (_) => APIProvider()),
    ChangeNotifierProvider<UserAppProvider>(create: (_) => UserAppProvider()),
  ], child:EasyLocalization(
    supportedLocales: const[
       Locale('en'),
        Locale('ar'),
    ],
    path: 'assets/language',
    fallbackLocale:const Locale('en'),
    child: const MyApp(),
  )));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale:context.locale,
          navigatorKey: RouterClass.routerClass.navKey,
          title: 'First Method',
           theme:getApplicationTheme(),
          home: child,
        );
      },
      child:Splash()
    );
  }
 }
//
// OfflineBuilder(
// connectivityBuilder: (BuildContext context, ConnectivityResult value, Widget child) {
// bool connected =  value != ConnectivityResult.none;
// return connected? Splash():  NOInternerScreen();
// },
// child: Container(),)
// import 'package:flutter/material.dart';
// import 'package:inventory/ui/test.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Offline Demo',
//       theme: ThemeData.dark(),
//       home: Builder(
//         builder: (BuildContext context) {
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               ElevatedButton(
//                 onPressed: () {
//                   // navigate(context, const Demo1());
//                 },
//                 child: const Text('Demo 1'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   // navigate(context, const Demo2());
//                 },
//                 child: const Text('Demo 2'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                     navigate(context,  DemoPage());
//                 },
//                 child: const Text('Demo 3'),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   void navigate(BuildContext context, Widget widget) {
//     Navigator.of(context).push<void>(
//       MaterialPageRoute<void>(
//         builder: (BuildContext context) => DemoPage(),
//       ),
//     );
//   }
// }