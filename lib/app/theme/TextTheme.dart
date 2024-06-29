import 'package:doctor_yab/app/theme/AppFonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///h -> ExtraBold
///b -> Bold
///m -> Medium
///r -> Regular
///l -> Light
class AppTextTheme {
  //headings

  ///Heading (ExtraBold) with custom size
  static TextStyle h(double size) {
    return Get.textTheme.bodyLarge!
        .copyWith(fontSize: size, fontWeight: AppFontWeight.EXTRA_BOLD);
  }

  ///29, ExtraBold
  static TextStyle h1() {
    return Get.textTheme.bodyLarge!
        .copyWith(fontSize: 29, fontWeight: AppFontWeight.EXTRA_BOLD);
  }

  ///20, ExtraBold
  static TextStyle h2() {
    return Get.textTheme.bodyLarge!
        .copyWith(fontSize: 20, fontWeight: AppFontWeight.EXTRA_BOLD);
  }

  ///16, ExtraBold
  static TextStyle h3() {
    return Get.textTheme.bodyLarge!
        .copyWith(fontSize: 16, fontWeight: AppFontWeight.EXTRA_BOLD);
  }

  ///bold with custom size
  static TextStyle b(double size) {
    return Get.textTheme.bodyLarge!
        .copyWith(fontSize: size, fontWeight: AppFontWeight.BOLD);
  }

  ///18, Bold
  static TextStyle b1() {
    return Get.textTheme.bodyLarge!
        .copyWith(fontSize: 18, fontWeight: AppFontWeight.BOLD);
  }

  ///16, Bold
  static TextStyle b2() {
    return Get.textTheme.bodyLarge!
        .copyWith(fontSize: 16, fontWeight: AppFontWeight.BOLD);
  }

  ///14, Bold
  static TextStyle b3() {
    return Get.textTheme.bodyLarge!
        .copyWith(fontSize: 14, fontWeight: AppFontWeight.BOLD);
  }

  ///11, Bold
  static TextStyle b4() {
    return Get.textTheme.bodyLarge!
        .copyWith(fontSize: 11, fontWeight: AppFontWeight.BOLD);
  }

//semi bold
  // static TextStyle sb2() {
  //   return Get.textTheme.bodyText1
  //       .copyWith(fontSize: 20, fontWeight: AppFontWeight.semiBold);
  // }

  ///Regular with custom size
  static TextStyle r(double size) {
    return Get.textTheme.bodyLarge!
        .copyWith(fontSize: size, fontWeight: AppFontWeight.REGULAR);
  }

  // static TextStyle r2() {
  //   return Get.textTheme.bodyText1
  //       .copyWith(fontSize: 27, fontWeight: AppFontWeight.REGULAR);
  // }

  ///Medium with custom size
  static TextStyle m(double size) {
    return Get.textTheme.bodyLarge!
        .copyWith(fontSize: size, fontWeight: AppFontWeight.MEDIUM);
  }

  // static TextStyle m3() {
  //   return Get.textTheme.bodyText1
  //       .copyWith(fontSize: 16, fontWeight: AppFontWeight.MEDIUM);
  // }

  ///Light with custom size
  static TextStyle l(double size) {
    return Get.textTheme.bodyLarge!
        // return Get.textTheme.bodyText1!
        .copyWith(fontSize: size, fontWeight: AppFontWeight.LIGHT);
  }

  // static TextStyle l4() {
  //   return Get.textTheme.bodyText1
  //       .copyWith(fontSize: 16, fontWeight: AppFontWeight.LIGHT);
  // }
}
