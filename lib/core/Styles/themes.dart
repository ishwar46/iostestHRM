import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrm/core/Styles/app_color.dart';

var lightThemeData = ThemeData(
  fontFamily: GoogleFonts.nunito().fontFamily,
  backgroundColor: AppColor.primary,
 
  splashColor:const Color(0xff5ec6dd),
  textTheme: const TextTheme(
    labelLarge: TextStyle(
        color: AppColor.bgColor, fontSize: 20, fontWeight: FontWeight.w700),
    labelMedium: TextStyle(
        color: AppColor.black, fontSize: 15, fontWeight: FontWeight.w600),
  ),
  appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.primary, foregroundColor: AppColor.whiteText),
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColor.background,
  chipTheme: const ChipThemeData(
    backgroundColor: Colors.white,
    labelStyle: TextStyle(color: AppColor.primary),
  ),
  cardColor: Colors.white,
  colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColor.primary,
          onPrimary: AppColor.whiteText,
          secondary: AppColor.secondary,
          onSecondary: AppColor.secondary,
          error: AppColor.attentionText,
          onError: AppColor.attentionText,
          background: AppColor.primary,
          onBackground: AppColor.primary,
          surface: AppColor.primary,
          onSurface: AppColor.primary)
      .copyWith(background: AppColor.primary),
);

var darkThemeData = ThemeData(
    cardColor: Colors.black87,
  splashColor:const Color(0xff5ec6dd),

    backgroundColor: Colors.black26,
    primaryColor: AppColor.primary,
    chipTheme: const ChipThemeData(
      backgroundColor: Colors.black54,
      labelStyle: TextStyle(color: AppColor.whiteText),
    ),
    buttonTheme: const ButtonThemeData(buttonColor: Colors.black26),
    textTheme: const TextTheme(labelSmall: TextStyle(color: Colors.white), labelMedium: TextStyle(
        color: AppColor.whiteText, fontSize: 15, fontWeight: FontWeight.w600),),
    navigationBarTheme:
        const NavigationBarThemeData(backgroundColor: Colors.black45),
    colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: AppColor.primary,
        onPrimary: AppColor.whiteText,
        secondary: AppColor.secondary,
        onSecondary: AppColor.secondary,
        error: AppColor.attentionText,
        onError: AppColor.attentionText,
        background: AppColor.primary,
        onBackground: AppColor.primary,
        surface: AppColor.primary,
        onSurface: AppColor.primary),
    bottomAppBarColor: Colors.black12,
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.nunito().fontFamily,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black, foregroundColor: AppColor.whiteText),
    scaffoldBackgroundColor: Colors.black26);
