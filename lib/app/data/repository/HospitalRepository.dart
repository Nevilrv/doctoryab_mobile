// import 'dart:io' as Io;

import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/HospitalsModel.dart';
import 'package:doctor_yab/app/services/DioService.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

// import 'package:file/file.dart';
// import 'package:dio/dio.dart';

class HospitalRepository {
  static Dio dio = AppDioService.getDioInstance();

  static var _cachedDio = AppDioService.getCachedDio;
  static Future<List<Hospital>> fetchHospitals(int page,
      {int limitPerPage = 10, void onError(e), CancelToken cancelToken}) async {
    // TODO move to some utils func
    // _searchCancelToken.cancel();
    // _searchCancelToken = CancelToken();

    return await Utils.parseResponse<Hospital>(
      () async {
        return await _cachedDio.get(
          '${ApiConsts.hospitalByCity}/${SettingsController.auth.savedCity.sId}',
          cancelToken: cancelToken,
          queryParameters: {
            "limit": limitPerPage,
            "page": page,
            "sort": "name",
          },
          // data: {"name": name},
          // cancelToken: _searchCancelToken,
          options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
        );
      },
      onError: onError,
    );
  }

  Future<dynamic> fetchReviews(
    int page, {
    int limitPerPage = 10,
    String hospitalId,
    CancelToken cancelToken,
  }) async {
    assert(SettingsController.auth.savedCity != null);
    // assert(cat != null || loadMyDoctorsMode != null && loadMyDoctorsMode);

    var response = await _cachedDio.get(
      '${ApiConsts.hospitalReviews}/$hospitalId',
      cancelToken: cancelToken,
      queryParameters: {
        // "limit": limitPerPage,
        "page": page,
      },
      // cancelToken: loginCancelToken,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    return response;
  }
}
