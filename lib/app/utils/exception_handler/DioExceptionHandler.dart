import 'package:dio/dio.dart';
import 'package:doctor_yab/app/utils/AppGetDialog.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
// import 'package:logger/logger.dart';

class DioExceptionHandler {
  static handleException(
      {required exception,
      Function? retryCallBak,
      String? operationTitle,
      String? retryButtonText}) {
    try {
      FirebaseCrashlytics.instance
          .recordError(exception, (exception as DioError).stackTrace);
    } catch (e) {}
    EasyLoading.dismiss();
    // Logger().d(exception.type, "error DIO Type");
    if (exception is DioError) {
      switch (exception.type) {
        case DioErrorType.connectTimeout:
          {
            AppGetDialog.showWithRetryCallBack(
              middleText: "connection_timed_out".tr +
                  ", " +
                  "check_internet_connection_and_retry".tr,
              operationTitle: operationTitle,
              retryButtonText: retryButtonText,
              retryCallBak: retryCallBak,
            );
            break;
          }
        case DioErrorType.sendTimeout:
          {
            AppGetDialog.showWithRetryCallBack(
              middleText: "connection_send_out".tr +
                  ", " +
                  "check_internet_connection_and_retry".tr,
              operationTitle: operationTitle,
              retryButtonText: retryButtonText,
              retryCallBak: retryCallBak,
            );
            break;
          }
        case DioErrorType.receiveTimeout:
          {
            AppGetDialog.showWithRetryCallBack(
              middleText: "connection_recive_out".tr +
                  ", " +
                  "check_internet_connection_and_retry".tr,
              operationTitle: operationTitle,
              retryButtonText: retryButtonText,
              retryCallBak: retryCallBak,
            );
            break;
          }
        case DioErrorType.response:
          {
            var responseMessage;
            try {
              responseMessage = exception.response?.data["message"];
            } catch (e, s) {
              FirebaseCrashlytics.instance.recordError(e, s);
            }
            // = exception.response?.data["message"];
            AppGetDialog.showWithRetryCallBack(
              middleText: "unexpected_server_error_occured".tr +
                  "\n" +
                  "server_error_response".tr +
                  ": ${exception.response?.statusCode ?? responseMessage ?? 'null'}\n" +
                  "recheck_the_request_and_retry".tr,
              operationTitle: operationTitle,
              retryButtonText: retryButtonText,
              retryCallBak: retryCallBak,
            );
            break;
          }
        case DioErrorType.cancel:
          {
            // AppGetDialog.showWithRetryCallBack(
            //   middleText: "connection_canceled".tr +
            //       ", " +
            //       "check_internet_connection_and_retry".tr,
            //   operationTitle: operationTitle,
            //   retryButtonText: retryButtonText,
            //   retryCallBak: retryCallBak,
            // );
            break;
          }
        case DioErrorType.other:
          {
            AppGetDialog.showWithRetryCallBack(
              middleText: "${exception?.response?.statusCode ?? ""}" +
                  "check_internet_connection_and_retry".tr,
              operationTitle: operationTitle,
              retryButtonText: retryButtonText,
              retryCallBak: retryCallBak,
            );
            break;
          }
      }
    } else {
      Logger().w(exception,
          "unxcepcted error (${exception.runtimeType}) passed to DIO ExceptionHandler");
    }
  }
}
