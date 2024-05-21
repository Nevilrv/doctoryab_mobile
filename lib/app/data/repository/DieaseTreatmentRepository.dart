// import 'dart:io' as Io;

import 'package:doctor_yab/app/data/ApiConsts.dart';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/diaease_data_list_res_model.dart';
import 'package:doctor_yab/app/services/DioService.dart';
import '../models/diaese_category_res_model.dart';

class DieaseTreatementRepository {
  static Dio dio = AppDioService.getDioInstance();
  static var _cachedDio = AppDioService.getCachedDio;
  static Future<DieaseCategoryResModel> getDieaseCategory() async {
    // var headers = ApiConsts().commonHeader;
    // var dio = Dio();
    // var response = await dio.get(
    //   ApiConsts.hostUrl +
    //       "api/v1" +
    //       ApiConsts.deseasecategory +
    //       "?page=1&limit=1000000",
    //   options: Options(
    //     method: 'GET',
    //     headers: headers,
    //   ),
    // );
    // var _cachedDio = AppDioService.getCachedDio;

    final response = await _cachedDio.get(
      ApiConsts.deseasecategory,
      queryParameters: {
        "limit": '1000000',
        "page": '1',
      },
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    return DieaseCategoryResModel.fromJson(response.data);
  }

  static Future<DieaseDataListResModel> getDieaseData(String title) async {
    // var headers = ApiConsts().commonHeader;
    // var dio = Dio();
    // var response = await dio.get(
    //   ApiConsts.hostUrl + "api/v1" + ApiConsts.deseaseDatalist + title,
    //   options: Options(
    //     method: 'GET',
    //     headers: headers,
    //   ),
    // );

    final response = await _cachedDio.get(
      ApiConsts.deseaseDatalist + title + "?page=1&limit=1000000000000",
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );
    return DieaseDataListResModel.fromJson(response.data);
  }
}
