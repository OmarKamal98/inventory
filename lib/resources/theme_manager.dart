
import 'package:flutter/material.dart';
import 'package:inventory/resources/color_manager.dart';
import 'package:inventory/resources/font_manager.dart';
import 'package:inventory/resources/styles_manager.dart';
import 'package:inventory/resources/values_manager.dart';
ThemeData getApplicationTheme() {
  return ThemeData(
    // main colors
    primaryColor: ColorManager.primary,
    splashColor: ColorManager.primary,
    // ripple effect color
    // cardview theme
    cardTheme: CardTheme(
        color: ColorManager.white,
        elevation: AppSize.s4),
    // app bar theme
    // appBarTheme: AppBarTheme(
    //     centerTitle: true,
    //     color: ColorManager.parent,
    //     elevation: 0,
    //     shadowColor: ColorManager.lightPrimary,
    //     titleTextStyle:
    //         getBoldStyle(fontSize: FontSize.s16, color: ColorManager.black)),
    // button theme
    buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: ColorManager.white,
        buttonColor: ColorManager.primary,
        ),

    // elevated button them
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getBoldStyle(
                color: ColorManager.black, fontSize: FontSize.s14),
            primary: ColorManager.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12)))),

    // textTheme: TextTheme(
    //     displayLarge:
    //         getLightStyle(color: ColorManager.white, fontSize: FontSize.s22),
    //     headlineLarge: getExtraBoldStyle(
    //         color: ColorManager.grey1, fontSize: FontSize.s16),
    //     titleMedium: getMediumStyle(
    //         color: ColorManager.lightGrey, fontSize: FontSize.s14),
    //     bodyLarge: getRegularStyle(color: ColorManager.grey1),
    //     bodySmall: getRegularStyle(color: ColorManager.grey)),

  );
}
