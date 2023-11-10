import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/appointment_history_res_model.dart';
import 'package:doctor_yab/app/services/DioService.dart';

class AppointmentRepository {
  static Dio dio = AppDioService.getDioInstance();

  static var _cachedDio = AppDioService.getCachedDio;

  static Future<AppointmentHistoryResModel> fetchAppointmentHistory(
      {CancelToken cancelToken}) async {
    var data = await dio.get(
      // '${ApiConsts.getAppointmentHistory}/60a8b056e8c8b437ad3d2d06',
      '${ApiConsts.getAppointmentHistory}/${SettingsController.userId}',
      cancelToken: cancelToken,
      queryParameters: {},
      // data: {"name": name},
      // cancelToken: _searchCancelToken,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );
    log("data.data--------------> ${data.data}");

    return AppointmentHistoryResModel.fromJson(data.data);
  }
}
