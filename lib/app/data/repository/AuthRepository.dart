// import 'dart:io' as Io;
import 'dart:io';

import 'package:doctor_yab/app/controllers/auth_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:logger/logger.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/services/DioService.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:file/file.dart';
import 'package:http_parser/http_parser.dart';
// import 'package:dio/dio.dart';

class AuthRepository {
  static Dio dio = AppDioService.getDioInstance();
  var _cachedDio = AppDioService.getCachedDio;

  //* Login Api
  Future<dynamic> signin() async {
    var fcmToken;
    try {
      fcmToken = await FirebaseMessaging.instance.getToken();
    } catch (e, s) {
      Logger().e("", e, s);
    }
    //TODO handle exception
    var _firebaseIdToken =
        await AuthController.to.firebaseAuth.currentUser.getIdToken();

    final response = await dio.post(
      ApiConsts.authPath,
      data: {"idtoken": _firebaseIdToken, "fcm": fcmToken ?? ""},
    );

    return response;
  }

  //* update profile image
  Future<dynamic> updateImage(File file,
      [void uploadProgress(double percent)]) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "img": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
        contentType: MediaType('image', 'png'),
      ),
    });
    final response = await dio.post(
      ApiConsts.updateImagePath, data: formData,
      onSendProgress: (received, total) {
        if (total != -1) {
          print((received / total * 100).toStringAsFixed(0) + "%");
          if (uploadProgress != null) uploadProgress(received / total * 100);
        }
      },

      // cancelToken: loginCancelToken,
    );
    // print(response);
    return response;
  }

  //* update profile
  Future<dynamic> updateProfile(String name, int age,
      {String firebaseUserToken}) async {
    final response = await dio.put(
      ApiConsts.authPath,
      data: {
        "age": age,
        "name": name,
        "token": firebaseUserToken,
      },
      // cancelToken: loginCancelToken,
    );
    return response;
  }

  //* update profile
  Future<Response<dynamic>> fetchProfile() async {
    final response = await _cachedDio.get(
      ApiConsts.authPath,

      // data: {
      //   "age": age,
      //   "name": name,
      // },
      // cancelToken: loginCancelToken,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );
    return response;
  }

  static Future<bool> numberExists(String number) async {
    final response =
        await dio.get(ApiConsts.checkIfNumberExistsPath, queryParameters: {
      "phone": number.toEnglishDigit(),
    }
            // cancelToken: loginCancelToken,
            );
    return (response?.data['isExist'] ?? true);
  }
}