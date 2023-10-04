import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppFonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      fontFamily: AppFonts.poppins,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.scaffoldColor,
      primaryColor: AppColors.primary,
      // accentColor: Colors.white,
      // primarySwatch: AppColors.primary,
      textTheme: ThemeData.light().textTheme.apply(
            bodyColor: AppColors.black2,
            // fontFamily: AppFonts.avenir_regular,
            fontFamily: AppFonts.poppins,
          ),
      // primaryTextTheme: ThemeData.light().textTheme.apply(
      //       fontFamily: AppFonts.acuminSemiCond,
      //     ),
      // accentTextTheme: ThemeData.light().textTheme.apply(
      //       fontFamily: AppFonts.acuminSemiCond,
      //     ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            // primary: Colors.white,
            ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide:
              BorderSide(color: Colors.white.withOpacity(0.5), width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        // labelStyle: TextStyle(color: Colors.white),
      ),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      // hintColor: Colors.white,
      // appBarTheme: ThemeData.light().appBarTheme.copyWith(
      //       color: AppColors.scaffoldColor,
      //       elevation: 0,
      //       // textTheme: ThemeData.light()
      //       //     .appBarTheme
      //       //     .textTheme
      //       //     .apply(bodyColor: AppColors.lgt1),
      //       iconTheme: IconThemeData(color: AppColors.lgt1),
      //     ),
      // errorColor: AppColors.superRed,
    );
  }

  static secondaryTheme() {
    return light().copyWith(
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.lgt2, width: 2.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide:
              BorderSide(color: AppColors.lgt2.withOpacity(0.5), width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        // labelStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  static newTheme() {
    return light().copyWith(
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primary, width: 1.0),
          borderRadius: BorderRadius.circular(5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide:
              BorderSide(color: AppColors.primary.withOpacity(0.5), width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        labelStyle: TextStyle(color: AppColors.primary),
      ),
    );
  }
}
