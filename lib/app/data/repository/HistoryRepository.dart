// import 'dart:io' as Io;

import 'package:doctor_yab/app/data/ApiConsts.dart';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/histories.dart';
import 'package:doctor_yab/app/services/DioService.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
// import 'package:file/file.dart';
// import 'package:dio/dio.dart';

class HistoryRepository {
  static Dio dio = AppDioService.getDioInstance();

  static var _cachedDio = AppDioService.getCachedDio;

  //* Search doctors
  static Future<List<History>> fetchHistory(int page,
      {int limitPerPage = 10,
      required void onError(e),
      CancelToken? cancelToken}) async {
    // TODO move to some utils func
    // _searchCancelToken.cancel();
    // _searchCancelToken = CancelToken();
    List<History> data = await Utils.parseResponse<History>(
      () async {
        return await _cachedDio.get(
          '${ApiConsts.historyPath}',
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
    ) as List<History>;
    return data;
  }
}
