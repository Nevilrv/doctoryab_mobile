import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../services/DioService.dart';
import '../ApiConsts.dart';

class NotificationRepository {
  Dio dio = AppDioService.getDioInstance();
  var _cachedDio = AppDioService.getCachedDio;

  Future<dynamic> loadNotification() async {
    final response = await _cachedDio.get(
      ApiConsts.notification,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    return response.data;
  }

  Future<dynamic> notificationStatus(String notificationId) async {
    final response = await _cachedDio.put(
      ApiConsts.notification,
      queryParameters: {'_id': notificationId},
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );
    return response.data;
  } Future<dynamic> changeLanguage(String language) async {
    log("{'language': language}---------------->${{'language': language}}");

    var headers = ApiConsts().commonHeader;
    var data =
  {'language': language};
    log("data--------------> $data");

    var dio = Dio();
    var response = await dio.put(
      ApiConsts.baseUrl + ApiConsts.updateLanguage,
      options: Options(
        method: 'PUT',
        headers: headers,
      ),
      data: data,
    );
    // final response = await _cachedDio.put(
    //   ApiConsts.updateLanguage,
    //   queryParameters: {'language': language},
    //   options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    // );
    return response.data;
  }
}
