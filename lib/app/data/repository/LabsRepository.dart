import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/labs_model.dart';
import 'package:doctor_yab/app/services/DioService.dart';
import 'package:doctor_yab/app/utils/utils.dart';

class LabsRepository {
  static Dio dio = AppDioService.getDioInstance();

  static var _cachedDio = AppDioService.getCachedDio;
  static Future<List<Labs>> fetchLabs(int page,
      {int limitPerPage = 10, void onError(e), CancelToken cancelToken}) async {
    return await Utils.parseResponse<Labs>(
      () async {
        return await _cachedDio.get(
          '${ApiConsts.labsByCity}',
          cancelToken: cancelToken,
          queryParameters: {
            "limit": limitPerPage,
            "page": page,
            "sort": "name",
            "cityId": "${SettingsController.auth.savedCity.sId}",
          },
          // data: {"name": name},
          // cancelToken: _searchCancelToken,
          options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
        );
      },
      onError: (e) => onError(e),
    );
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
