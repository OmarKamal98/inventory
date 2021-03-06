import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory/provider/api_provider.dart';
import 'package:inventory/provider/user_provider.dart';
import 'package:inventory/provider/auth_provider.dart';
import 'package:inventory/resources/router_class.dart';
import 'package:inventory/resources/theme_manager.dart';
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
           theme:getApplicationTheme(),
          home: child,
        );
      },
      child:Splash()
    );
  }
 }
