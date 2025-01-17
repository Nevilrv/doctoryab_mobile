import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/appointment_history_res_model.dart';
import 'package:doctor_yab/app/data/models/histories.dart';
import 'package:doctor_yab/app/services/DioService.dart';

class AppointmentRepository {
  static Dio dio = AppDioService.getDioInstance();

  static var _cachedDio = AppDioService.getCachedDio;

  static Future<Histories> fetchAppointmentHistory(
      {CancelToken? cancelToken}) async {
    // log("url===========>${ApiConsts.getAppointmentHistory}/${SettingsController.userId}");
    var data = await _cachedDio.get(
      // '${ApiConsts.getAppointmentHistory}/60a8b056e8c8b437ad3d2d06',
      '${ApiConsts.getAppointmentHistory}',
      cancelToken: cancelToken,
      queryParameters: {},
      // data: {"name": name},
      // cancelToken: _searchCancelToken,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    return Histories.fromJson(data.data);
  }

  ///cancel appointment
  Future<dynamic> cancelAppointment({
    String? id,
    String? patientId,
  }) async {
    var headers = ApiConsts().commonHeader;
    var data = {"id": id, "status": "cancelled", "patientId": patientId};
    log(" $data");

    var response = await dio.put(
      ApiConsts.baseUrl + ApiConsts.cancelAppointment,
      options: Options(
        method: 'PUT',
        headers: headers,
      ),
      data: data,
    );
    return response.data;
  }
}
