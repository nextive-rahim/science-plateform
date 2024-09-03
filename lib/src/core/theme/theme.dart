import 'package:flutter/material.dart';
import 'package:science_platform/src/core/theme/colors.dart';

ThemeData themeData = ThemeData(
  fontFamily: 'NotoSerifBengali',
  scaffoldBackgroundColor: AppColors.pageBackgroundColor,
  appBarTheme: const AppBarTheme(
    color: AppColors.white,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: AppColors.black,
      fontSize: 18,
    ),
    iconTheme: IconThemeData(
      color: AppColors.black,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: AppColors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      maximumSize: const Size(double.infinity, 40),
      minimumSize: const Size(double.infinity, 40),
      // maximumSize: double.infinity,
      textStyle: const TextStyle(
        fontFamily: 'NotoSerifBengali',
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    errorStyle: const TextStyle(
      fontSize: 0.01,
      height: 0.01,
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 10,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(
        color: AppColors.primary,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(
        color: AppColors.primary,
        width: 0.5,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 0.5,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 0.5,
      ),
    ),
  ),
);
