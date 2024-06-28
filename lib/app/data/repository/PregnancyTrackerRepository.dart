import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/pregnancy_details_model.dart';
import 'package:doctor_yab/app/services/DioService.dart';

class PregnancyTrackerRepo {
  Dio dio = AppDioService.getDioInstance();
  var _cachedDio = AppDioService.getCachedDio;

  Future<PregnancyDetailsModel> checkPregnancy({CancelToken? cancelToken}) async {
    // var response = await _cachedDio.get(
    //   ApiConsts.checkPregnancy,
    //   // cancelToken: cancelToken,
    //   options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    // );
    log("ApiConsts().commonHeader--------------> ${ApiConsts().commonHeader}");

    var headers = ApiConsts().commonHeader;

    var dio = Dio();
    var response = await dio.get(
      ApiConsts.baseUrl + ApiConsts.checkPregnancy,
      options: Options(
        method: 'Get',
        headers: headers,
      ),
    );

    // return BlogLikeResModel.fromJson(response.data);

    log('------vvv----${response.statusCode}');
    log("response.data--------------> ${response.data}");

    if (response.statusCode == 200) {
      return PregnancyDetailsModel.fromJson(response.data);
    } else {
      return PregnancyDetailsModel.fromJson({});
    }
  }

  Future<PregnancyDetailsModel> calculateDate({Map<String, dynamic>? body, CancelToken? cancelToken}) async {
    var response = await _cachedDio.post(
      ApiConsts.calculateDate,
      data: body,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    log('-calculateDate----response------${response.statusCode}');

    return PregnancyDetailsModel.fromJson(response.data);
  }

  Future<Map<String, dynamic>> deleteTracker({String? id, CancelToken? cancelToken}) async {
    var response = await _cachedDio.delete(
      ApiConsts.deleteTracker + id!,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    log('-----response------${response.statusCode}');

    return response.data;
  }
}
