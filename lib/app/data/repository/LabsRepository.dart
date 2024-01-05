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

    print('===============....$filterName');

    if (filterName == 'Nearest Lab' ||
        filterName == 'نزدیکترین لابراتوار' ||
        filterName == 'نږدې لابراتوار') {
      requestParameter = {
        "limit": limitPerPage,
        "page": page,
        "sort": sort,
        "lat": lat,
        "lng": lon,
      };
    } else if (filterName == 'Promoted' ||
        filterName == "حمایت شده" ||
        filterName == "سپانسر شوی") {
      requestParameter = {
        "limit": limitPerPage,
        "page": page,
      };
    } else {
      requestParameter = {
        "limit": limitPerPage,
        "page": page,
        "sort": sort,
      };
    }

    log('---RequestParameter---->>>>>$requestParameter');

    final response = await _cachedDio.get(
      ApiConsts.labsByCity,
      cancelToken: cancelToken,
      queryParameters: requestParameter,
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
