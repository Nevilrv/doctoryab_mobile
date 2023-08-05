import 'package:dio/dio.dart';
import 'package:doctor_yab/app/controllers/auth_controller.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:logger/logger.dart';

class ForceLogoutInterceptor extends Interceptor {
  @override
  void onError(DioError e, ErrorInterceptorHandler handler) {
    if (e.response?.statusCode == HttpStatus.unauthorized) {
      AuthController.to.signOut().then((value) {
        Utils.whereShouldIGo();
        Get.snackbar(
          "error",
          "you_have_to_sign_in_again".tr,
          icon: Icon(Icons.alarm),
          //TODO Make this Stylish
        );
      });
    }
    // handler.next(e);
    super.onError(e, handler);
  }
}
