import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/pregnancy_details_model.dart';
import 'package:doctor_yab/app/services/DioService.dart';

class PregnancyTrackerRepo {
  Dio dio = AppDioService.getDioInstance();
  var _cachedDio = AppDioService.getCachedDio;

  Future<PregnancyDetailsModel> checkPregnancy() async {
    var response = await _cachedDio.get(
      ApiConsts.checkPregnancy,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    return PregnancyDetailsModel.fromJson(response.data);
  }

  Future<dynamic> calculateDate() async {
    var response = await _cachedDio.get(
      ApiConsts.calculateDate,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    return response;
  }
}
