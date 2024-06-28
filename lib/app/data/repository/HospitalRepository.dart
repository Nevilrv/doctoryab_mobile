// import 'dart:io' as Io;

import 'dart:developer';

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

  static Future<List<Hospital>> fetchHospitals({
    int limitPerPage = 10,
    required void onError(e),
    CancelToken? cancelToken,
    int? page,
    String? sort,
    double? lat,
    double? lon,
    String? filterName,
  }) async {
    // TODO move to some utils func
    // _searchCancelToken.cancel();
    // _searchCancelToken = CancelToken();
    log("'${ApiConsts.hospitalByCity}/${SettingsController.auth.savedCity!.sId}'--------------> ${'${ApiConsts.hospitalByCity}/${SettingsController.auth.savedCity!.sId}'}");

    List<Hospital> data = await Utils.parseResponse<Hospital>(
      () async {
        Map<String, dynamic> requestParameter = {};
        if (filterName == 'nearest_hospital'.tr) {
          requestParameter = {
            "limit": limitPerPage,
            "page": page,
            "sort": sort?.isEmpty ?? true ? " " : sort,
            "lat": lat,
            "lng": lon,
          };
        } else {
          requestParameter = {
            "limit": limitPerPage,
            "page": page,
            "sort": sort!.isEmpty ? " " : sort,
          };
        }

        log('---URL>>>>>$requestParameter');

        var respose = await _cachedDio.get(
          '${ApiConsts.hospitalByCity}/${SettingsController.auth.savedCity!.sId}',
          cancelToken: cancelToken,
          queryParameters: requestParameter,
          // data: {"name": name},
          // cancelToken: _searchCancelToken,
          options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
        );
        log("respose--------------> ${respose}");
        return respose;
      },
      onError: onError,
    ) as List<Hospital>;
    return data;
  }

  static Future<List<Hospital>> searchHospitals(int page,
      {int limitPerPage = 10, String? name, required void onError(e), CancelToken? cancelToken}) async {
    // TODO move to some utils func

    List<Hospital> data = await Utils.parseResponse<Hospital>(
      () async {
        var respose = await _cachedDio.get(
          '${ApiConsts.searchHospital}$name',
          cancelToken: cancelToken,
          // queryParameters: {
          //   "limit": limitPerPage,
          //   "page": page,
          //   // "sort": "name",
          // },
          // data: {"name": name},
          // cancelToken: _searchCancelToken,
          options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
        );
        log("respose--------------> ${respose}");
        return respose;
      },
      onError: onError,
    ) as List<Hospital>;
    return data;
  }

  Future<dynamic> fetchReviews(
    int page, {
    int limitPerPage = 10,
    String? hospitalId,
    CancelToken? cancelToken,
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

  Future<dynamic> fetchHospitalDetails({
    String? hospitalId,
    CancelToken? cancelToken,
  }) async {
    assert(SettingsController.auth.savedCity != null);
    // assert(cat != null || loadMyDoctorsMode != null && loadMyDoctorsMode);

    var response = await _cachedDio.get(
      '${ApiConsts.hospitalDetails}/$hospitalId',
      cancelToken: cancelToken,

      // cancelToken: loginCancelToken,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );
    log("response. ${response.data}");

    return response.data;
  }

  Future<dynamic> fetchHospitalDoctors({
    String? hospitalId,
    CancelToken? cancelToken,
  }) async {
    assert(SettingsController.auth.savedCity != null);
    // assert(cat != null || loadMyDoctorsMode != null && loadMyDoctorsMode);

    var response = await _cachedDio.get(
      '${ApiConsts.hospitalDoctors}/$hospitalId',
      cancelToken: cancelToken,

      // cancelToken: loginCancelToken,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    return response.data;
  }

  static Future<List<Hospital>> fetchHospitalsDropdown(int page,
      {int limitPerPage = 1000000,
      // void onError(e),
      CancelToken? cancelToken}) async {
    // TODO move to some utils func
    // _searchCancelToken.cancel();
    // _searchCancelToken = CancelToken();
    List<Hospital> data = await Utils.parseResponse<Hospital>(
      () async {
        var respose = await _cachedDio.get(
          '${ApiConsts.hospitalByCity}/${SettingsController.auth.savedCity!.sId}',
          cancelToken: cancelToken,
          queryParameters: {
            "limit": limitPerPage,
            "page": 1,
            // "sort": "name",
          },
          // data: {"name": name},
          // cancelToken: _searchCancelToken,
          options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
        );
        log("respose--------------> ${respose}");
        return respose;
      },
      onError: (e) {},
      // onError: onError,
    ) as List<Hospital>;

    return data;
  }
}
