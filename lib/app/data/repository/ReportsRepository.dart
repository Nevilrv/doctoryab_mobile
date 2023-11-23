// import 'dart:io' as Io;

import 'dart:developer';

import 'package:doctor_yab/app/data/ApiConsts.dart';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/reports.dart';
import 'package:doctor_yab/app/services/DioService.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
// import 'package:file/file.dart';
// import 'package:dio/dio.dart';

class ReportsRepository {
  static Dio dio = AppDioService.getDioInstance();

  static var _cachedDio = AppDioService.getCachedDio;

  //* Search doctors
  static Future<List<Report>> fetchLabReports(
    int page, {
    int limitPerPage = 10,
    void onError(e),
    CancelToken cancelToken,
  }) async {
    // TODO move to some utils func
    // _searchCancelToken.cancel();
    // _searchCancelToken = CancelToken();
    return await Utils.parseResponse<Report>(
      () async {
        // var doctorReports;
        var res = await _cachedDio.get(
          '${ApiConsts.labReportsPath}',
          cancelToken: cancelToken,
          queryParameters: {
            "limit": limitPerPage,
            "page": page,
          },
          // data: {"name": name},
          // cancelToken: _searchCancelToken,
          options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
        );
        log("res--------------> ${res}");

        return res;
      },
      onError: onError,
    );
  }

  static Future<List<Report>> fetchDoctorReports(
    int page, {
    int limitPerPage = 10,
    void onError(e),
    CancelToken cancelToken,
  }) async {
    log('vall api');
    // TODO move to some utils func
    // _searchCancelToken.cancel();
    // _searchCancelToken = CancelToken();
    return await Utils.parseResponse<Report>(
      () async {
        // var doctorReports;
        var res = await _cachedDio.get(
          '${ApiConsts.doctorReportsPath}',
          cancelToken: cancelToken,
          queryParameters: {
            "limit": limitPerPage,
            "page": page,
          },
          // data: {"name": name},
          // cancelToken: _searchCancelToken,
          options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
        );
        log("res--------------> ${res}");

        return res;
      },
      onError: onError,
    );
  }
}

enum REPORT_TYPE { doctor, lab }
