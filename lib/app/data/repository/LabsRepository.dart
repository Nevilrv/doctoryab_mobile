import 'dart:developer';

import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/labs_model.dart';
import 'package:doctor_yab/app/services/DioService.dart';
import 'package:doctor_yab/app/utils/utils.dart';

class LabsRepository {
  static Dio dio = AppDioService.getDioInstance();

  static var _cachedDio = AppDioService.getCachedDio;

  Future<Response> fetchLabs({
    int page,
    int limitPerPage = 50,
    String sort,
    double lat,
    double lon,
    String filterName,
    void onError(e),
    CancelToken cancelToken,
  }) async {
    Map<String, dynamic> requestParameter = {};
    if (filterName == 'nearest_lab') {
      requestParameter = {
        "limit": limitPerPage,
        "page": page,
        "sort": sort,
        "lat": lat,
        "lng": lon,
      };
    } else {
      requestParameter = {
        "limit": limitPerPage,
        "page": page,
        "sort": sort,
      };
    }

    print('---URL>>>>>$requestParameter');

    print("Get---Category---${ApiConsts.categoriesByCityPath}");
    final response = await _cachedDio.get(
      '${ApiConsts.labsByCity}',
      cancelToken: cancelToken,
      queryParameters: {
        "limit": limitPerPage,
        "page": page,
        "cityId": "${SettingsController.auth.savedCity.sId}",
        // "sort": "name",
        // "cityId": "${SettingsController.auth.savedCity.sId}",
      },

      // data: {"name": name},
      // cancelToken: _searchCancelToken,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    return response;
  }

  Future<Response> searchLabs({
    String name,
    void onError(e),
    CancelToken cancelToken,
  }) async {
    log("name--------------> ${name}");

    final response = await _cachedDio.get(
      '${ApiConsts.labsBySearch}$name',
      cancelToken: cancelToken,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    return response;
  }

  //*
  Future<Response<dynamic>> fetchCheckup(String hospitalID) async {
    final response = await _cachedDio.get(
      ApiConsts.hospitalCheckups + "/$hospitalID",

      // data: {
      //   "age": age,
      //   "name": name,
      // },
      // cancelToken: loginCancelToken,
      // queryParameters: {"hid": hospitalID},
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );
    return response;
  }
}
