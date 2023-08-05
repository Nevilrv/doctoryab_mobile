import 'package:doctor_yab/app/controllers/auth_controller.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

import '../controllers/login_verify_controller.dart';

class LoginVerifyView extends GetView<LoginVerifyController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: TextButton(
            child: Text(
                "${"logout".tr} ${AuthController.to.getUserPhoneNumber(numberType: NUMBER_TYPE.LOCAL)}"),
            onPressed: () {
              AuthController.to.signOut().then((val) {
                Utils.whereShouldIGo();
              });
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 11,
              child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Lottie.asset("assets/lot/lf30_editor_pkkoxkbf.json")),
            ),
            // Expanded(flex: 1, child: Container()),
            Container(
              width: 250,
              child: Text(
                "please_wait_a_moment_we_want_to_verify_somethings".tr,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
            ),
            Expanded(flex: 1, child: Container()),
            CircularProgressIndicator(
              backgroundColor: Get.theme.primaryColor,
            ),

            Expanded(flex: 1, child: Container()),
          ],
        ));
  }
}
