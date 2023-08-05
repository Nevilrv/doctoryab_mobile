// import 'dart:io' as Io;

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
  static Future<List<Report>> fetchReports(
    int page,
    REPORT_TYPE reportType, {
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
        return await _cachedDio.get(
          '${reportType == REPORT_TYPE.doctor ? ApiConsts.doctorReportsPath : ApiConsts.labReportsPath}',
          cancelToken: cancelToken,
          queryParameters: {
            "limit": limitPerPage,
            "page": page,
          },
          // data: {"name": name},
          // cancelToken: _searchCancelToken,
          options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
        );
      },
      onError: onError,
    );
  }
}

enum REPORT_TYPE { doctor, lab }
