// import 'dart:io' as Io;

import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/categories_model.dart';
import 'package:doctor_yab/app/data/models/doctors_model.dart';
import 'package:doctor_yab/app/services/DioService.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:logger/logger.dart';
// import 'package:file/file.dart';
// import 'package:dio/dio.dart';

class CategoriesRepository {
  static Dio dio = AppDioService.getDioInstance();
  static var _cachedDio = AppDioService.getCachedDio;

  //* update profile
  Future<dynamic> getCategories(int page,
      {int limitPerPage = 10, CancelToken cancelToken}) async {
    assert(SettingsController.auth.savedCity != null);
    final response = await _cachedDio.get(
      '${ApiConsts.categoriesByCityPath}',
      queryParameters: {
        "limit": limitPerPage,
        "page": page,
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
}
