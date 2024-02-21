import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/pregnancy_details_model.dart';
import 'package:doctor_yab/app/services/DioService.dart';

class PregnancyTrackerRepo {
  Dio dio = AppDioService.getDioInstance();
  var _cachedDio = AppDioService.getCachedDio;

  Future<PregnancyDetailsModel> checkPregnancy(
      {CancelToken cancelToken}) async {
    var response = await _cachedDio.get(
      ApiConsts.checkPregnancy,
      cancelToken: cancelToken,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    log('------vvv----${response.statusCode}');

    if (response.statusCode == 200) {
      return PregnancyDetailsModel.fromJson(response.data);
    } else {
      return response.data;
    }
  }

  Future<PregnancyDetailsModel> calculateDate(
      {Map<String, dynamic> body, CancelToken cancelToken}) async {
    var response = await _cachedDio.post(
      ApiConsts.calculateDate,
      data: body,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    log('-----response------${response.statusCode}');

    return PregnancyDetailsModel.fromJson(response.data);
  }
}
