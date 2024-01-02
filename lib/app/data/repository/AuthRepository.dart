// import 'dart:io' as Io;
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/controllers/auth_controller.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/services/DioService.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:file/file.dart';
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class AuthRepository {
  static Dio dio = AppDioService.getDioInstance();
  var _cachedDio = AppDioService.getCachedDio;

  //* Login Api
  Future<dynamic> signin() async {
    var fcmToken;
    try {
      fcmToken = await FirebaseMessaging.instance.getToken();
      log("fcmToken--------------> $fcmToken");
    } catch (e, s) {
      Logger().e("", e, s);
    }
    //TODO handle exception
    var _firebaseIdToken =
        await AuthController.to.firebaseAuth.currentUser.getIdToken();
    log("AuthController.to.firebaseAuth.currentUse--------------> $_firebaseIdToken");
    var data = {
      "idtoken": _firebaseIdToken,
      "fcm": fcmToken ?? "",
      "method": "Phone",
      "language": SettingsController.appLanguge
    };
    final response = await dio.post(
      ApiConsts.authPath,
      data: data,
    );
    log('DATA:-----> $data');
    print("API: ${ApiConsts.baseUrl + ApiConsts.authPath}");
    log("response-----1111---------> ${response.data}");
    log("respo-------> ${response.data["jwtoken"]}");
    log('responseresponseresponse$response');

    return response;
  }

  Future<dynamic> signInWithGoogleFacebboklApi(String token) async {
    //TODO handle exception
    var fcmToken;
    try {
      fcmToken = await FirebaseMessaging.instance.getToken();
    } catch (e, s) {
      Logger().e("", e, s);
    }

    final response = await dio.post(
      ApiConsts.authPathGoogleFB,
      data: {
        "idtoken": token,
        "fcm": fcmToken ?? "",
        "language": "English",
        "method": "Google"
      },
    );
    log("response--------------> ${response.data}");

    return response;
  }

  Future<dynamic> signInWithGAppleApi(String token) async {
    //TODO handle exception
    var fcmToken;
    try {
      fcmToken = await FirebaseMessaging.instance.getToken();
    } catch (e, s) {
      Logger().e("", e, s);
    }

    final response = await dio.post(
      ApiConsts.authPathGoogleFB,
      data: {
        "idtoken": token,
        "fcm": fcmToken ?? "",
        "language": "English",
        "method": "Apple"
      },
    );
    log("response--------------> ${response.data}");

    return response;
  }

  Future<dynamic> registerGuestUserApi(
      String name, String phone, String gender, String city) async {
    //TODO handle exception
    var fcmToken;
    try {
      fcmToken = await FirebaseMessaging.instance.getToken();
    } catch (e, s) {
      Logger().e("", e, s);
    }
    var data = {
      "name": name,
      "phone": int.parse(phone),
      "city": city,
      "gender": gender,
      "language": "English",
      "fcm": fcmToken,
      "method": "Guest"
    };
    final response = await dio.post(
      ApiConsts.guestUserLogin,
      data: data,
    );
    log("response--------------> ${response.data}");

    return response.data;
  }

  Future<dynamic> addPersonalInfoApi(
      String name, String phone, String gender, String city) async {
    //TODO handle exception
    var data = {
      "name": name,
      "phone": int.parse(phone),
      "city": city,
      "gender": gender
    };
    log("data--------------> $data");
    log("ApiConsts.addPersonalInfo--------------> ${ApiConsts.addPersonalInfo}");
    log("SettingsController.userToken--------------> ${SettingsController.userToken}");
    log("ApiConsts().commonHeader--------------> ${ApiConsts().commonHeader}");

    try {
      final response = await dio.put(
        ApiConsts.addPersonalInfo,
        data: data,
      );

      log("response------DSDSDS--------> $response");

      // var headers = {
      //   'apikey':
      //       'zwsexdcrfvtgbhnjmk123321321312312313123123123123123lkmjnhbgvfcdxesxdrcftvgybhnujimkorewuirueioruieworuewoiruewoirqwff',
      //   'jwtoken': SettingsController.userToken,
      //   'Content-Type': 'application/json'
      // };
      // var dio1 = Dio();
      // var response1 = await dio1.request(
      //   'https://testserver.doctoryab.app/api/v1/user',
      //   options: Options(
      //     method: 'PUT',
      //     headers: headers,
      //   ),
      //   data: data,
      // );

      return response.data;
    } catch (e) {
      print('==============EEEEEEE============>>$e');
    }
  }

  Future<dynamic> addPersonalInfoPhoneApi(
      String name, String phone, String gender, String city) async {
    //TODO handle exception
    var data = {
      // "age": age,
      "name": name,
      "gender": gender,
      "city": city, "phone": "0777777777"
      // "token": firebaseUserToken,
    };
    log("data--------------> $data");
    log(" ApiConsts.addPersonalInfo--------------> ${ApiConsts.addPersonalInfo}");
    log(" ApiConsts.addPersonalInfo--------------> ${SettingsController.userToken}");

    final response = await dio.put(
      ApiConsts.authPath,
      data: data,
    );
    log("response--------------> ${response.statusCode}");

    return response.data;
  }

  //* update profile image
  Future<dynamic> updateImage(File file,
      [void uploadProgress(double percent)]) async {
    log("file.path--------------> ${file.path}");

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
  Future<dynamic> updateProfile({
    String firebaseUserToken,
    String name,
    int age,
    String gender,
    String cityId,
    String phone,
    String email,
  }) async {
    final response = await dio.put(
      ApiConsts.authPath,
      data: {
        "age": age,
        "name": name,
        "gender": gender,
        "city": cityId,
        "phone": phone,
        "email": email,

        // "phone": "+937440000000"
        // "token": firebaseUserToken,
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

  ///complaint api
  Future<dynamic> complaintApi({
    String title,
    String desc,
  }) async {
    log("ApiConsts.complaint--------------> ${ApiConsts.complaint}");

    final response = await _cachedDio.post(
      ApiConsts.complaint,
      data: {
        "title": title,
        "desc": desc,
      },
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );
    return response;
  }

  ///complaint image api
  Future<dynamic> complaintImageApi({
    File image,
    String id,
  }) async {
    FormData formData = FormData.fromMap(
      {
        "img": image.path != ""
            ? await MultipartFile.fromFile(
                image.path,
                filename: image.path.split('/').last,
                contentType: MediaType('image', 'png'),
                // contentType: MediaType('img', image.path.split('.').last)
              )
            : null,
      },
    );
    final response = await _cachedDio.post(
      "${ApiConsts.complaint}/$id",
      data: formData,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );
    return response;
  }

  ///suggestion api
  Future<dynamic> suggestionApi({
    String title,
    String desc,
  }) async {
    log("ApiConsts.complaint--------------> ${ApiConsts.suggestion}");

    final response = await _cachedDio.post(
      ApiConsts.suggestion,
      data: {
        "title": title,
        "desc": desc,
      },
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );
    return response;
  }

  ///suggestion image api
  Future<dynamic> suggestionImageApi({
    File image,
    String id,
  }) async {
    FormData formData = FormData.fromMap(
      {
        "img": image.path != ""
            ? await MultipartFile.fromFile(
                image.path,
                filename: image.path.split('/').last,
                contentType: MediaType('image', 'png'),
                // contentType: MediaType('img', image.path.split('.').last)
              )
            : null,
      },
    );
    final response = await _cachedDio.post(
      "${ApiConsts.suggestion}/$id",
      data: formData,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );
    return response;
  }
}
