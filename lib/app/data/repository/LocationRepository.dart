// import 'dart:io' as Io;

import 'package:doctor_yab/app/data/ApiConsts.dart';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/services/DioService.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
// import 'package:file/file.dart';
// import 'package:dio/dio.dart';

class LocationRepository {
  Dio dio = AppDioService.getDioInstance();
  var _cachedDio = AppDioService.getCachedDio;

  //* City Load
  Future<dynamic> loadCities(int page, {int limitPerPage = 10}) async {
    final response = await _cachedDio.get(
      ApiConsts.cityPath,
      queryParameters: {
        "limit": limitPerPage,
        "page": page,
      },
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    return response;
  }
}
