import 'package:doctor_yab/app/modules/intro/controllers/intro_controller.dart';
import 'package:doctor_yab/app/modules/intro/views/intro_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  @override
  Widget build(BuildContext context) {
    return IntroView(splashScreenMode: false);
    // return Scaffold(
    //     // appBar: AppBar(
    //     //   backgroundColor: Colors.transparent,
    //     //   elevation: 0,
    //     //   title: TextButton(
    //     //     child: Text(
    //     //         "خارج شدن از حساب ${AuthController.to.getUserPhoneNumber(numberType: NUMBER_TYPE.LOCAL)}"),
    //     //     onPressed: () {
    //     //       AuthController.to.signOut().then((val) {
    //     //         Utils.whereShouldIGo();
    //     //       });
    //     //     },
    //     //   ),
    //     // ),
    //     body: Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     Expanded(
    //       flex: 11,
    //       child: Padding(
    //         padding: const EdgeInsets.all(15.0),
    //         child: Lottie.asset("assets/lot/21474-medical-frontliners.json"),
    //       ),
    //     ),
    //     // Expanded(flex: 1, child: Container()),
    //     Container(
    //       width: 250,
    //       child: Text(
    //         "please_wait".tr,
    //         textAlign: TextAlign.center,
    //         style: TextStyle(color: Colors.black),
    //       ),
    //     ),
    //     Expanded(flex: 1, child: Container()),
    //     CircularProgressIndicator(
    //       backgroundColor: Get.theme.primaryColor,
    //     ),

    //     Expanded(flex: 1, child: Container()),
    //   ],
    // ));
  }
}
