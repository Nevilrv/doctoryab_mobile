// import 'dart:io' as Io;

import 'dart:developer';

import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/HospitalsModel.dart';
import 'package:doctor_yab/app/data/models/categories_model.dart';
import 'package:doctor_yab/app/data/models/doctors_model.dart';
import 'package:doctor_yab/app/services/DioService.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:logger/logger.dart';
// import 'package:file/file.dart';
// import 'package:dio/dio.dart';

class PackageRepository {
  static Dio dio = AppDioService.getDioInstance();
  static var _cachedDio = AppDioService.getCachedDio;

  //* update profile
  Future<dynamic> checkupPackages(int page, String text,
      {int limitPerPage = 10 /*10*/, CancelToken cancelToken}) async {
    print("Get---psckshes---${ApiConsts.checkupPackage}");
    final response = await _cachedDio.get(
      '${ApiConsts.checkupPackage}',
      queryParameters: {
        "limit": limitPerPage,
        "page": page,
        "title": text,
      },
      cancelToken: cancelToken,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );
    return response;
  }

  //*
  static Future<List<Category>> categoryByDoctor(int page, Doctor doctor,
      {int limitPerPage = 10, void onError(e)}) async {
    //TODO move to some utils func
    List<Category> _cats;
    try {
      final response = await dio.get(
        '${ApiConsts.doctorsCategories}',
        queryParameters: {
          "limit": limitPerPage,
          "page": page,
        },
        // data: {"name": name},
        // cancelToken: _searchCancelToken,
        // options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
      );
      List<dynamic> _data = response.data['data'];
      if (_data == null) return <Category>[]; //TODO take care of this

      _cats = _data.map((e) => Category.fromJson(e)).toList();
    } catch (e, s) {
      Logger().e(e.toString());
      if (onError != null) {
        if (!(e is DioError && CancelToken.isCancel(e))) {
          onError(e);
        }
      }
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    return _cats;
  }

  Future<dynamic> fetchPackageReview({
    String packageId,
    void onError(e),
    CancelToken cancelToken,
  }) async {
    final response = await _cachedDio.get(
      '${ApiConsts.checkupPackageReview}$packageId',
      cancelToken: cancelToken,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    return response;
  }

  Future<dynamic> addPackageReview({
    String packageId,
    String rating,
    String comment,
    void onError(e),
    CancelToken cancelToken,
  }) async {
    var data = {"comment": comment, "rating": rating, "packageId": packageId};
    final response = await _cachedDio.post(
      '${ApiConsts.giveFeedbackTocheckupPackage}',
      cancelToken: cancelToken,
      data: data,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    return response;
  }

  static Future<List<Hospital>> fetchHospitals(
      {void onError(e), String cityId, CancelToken cancelToken}) async {
    // TODO move to some utils func

    return await Utils.parseResponse<Hospital>(
      () async {
        var respose = await _cachedDio.get(
          '${ApiConsts.hospitalByCity}/${cityId}',
          cancelToken: cancelToken,
          options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
        );
        log("respose--------------> ${respose}");
        return respose;
      },
      onError: onError,
    );
  }

  static Future<dynamic> fetchLabs({
    void onError(e),
    String cityId,
    CancelToken cancelToken,
  }) async {
    final response = await _cachedDio.get(
      '${ApiConsts.labsByCity}',
      cancelToken: cancelToken,
      queryParameters: {"cityId": "${cityId}"},
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    return response.data;
  }

  static Future<dynamic> fetchLabsSchedule({
    void onError(e),
    String labId,
    CancelToken cancelToken,
  }) async {
    final response = await _cachedDio.get(
      '${ApiConsts.labSchedule}${labId}',
      cancelToken: cancelToken,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    return response.data;
  }

  static Future<dynamic> fetchHospitalSchedule({
    void onError(e),
    String hospitalId,
    CancelToken cancelToken,
  }) async {
    final response = await _cachedDio.get(
      '${ApiConsts.hospitalSchedule}${hospitalId}',
      cancelToken: cancelToken,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    return response.data;
  }
}
