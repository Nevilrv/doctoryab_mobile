// import 'dart:io' as Io;

import 'dart:convert';
import 'dart:developer';

import 'package:doctor_yab/app/data/ApiConsts.dart';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/blog_like_res_model.dart';
import 'package:doctor_yab/app/data/models/diaease_data_list_res_model.dart';
import 'package:doctor_yab/app/data/models/post.dart';
import 'package:doctor_yab/app/services/DioService.dart';

import '../../utils/utils.dart';

import '../models/blog_categories.dart';
import '../models/diaese_category_res_model.dart';

class DieaseTreatementRepository {
  static Dio dio = AppDioService.getDioInstance();

  static var _cachedDio = AppDioService.getCachedDio;

  static Future<DieaseCategoryResModel> getDieaseCategory() async {
    var headers = ApiConsts().commonHeader;

    var dio = Dio();
    var response = await dio.get(
      ApiConsts.hostUrl +
          "api/v1" +
          ApiConsts.deseasecategory +
          "?page=1&limit=1000000",
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );
    return DieaseCategoryResModel.fromJson(response.data);
  }

  static Future<DieaseDataListResModel> getDieaseData(String title) async {
    var headers = ApiConsts().commonHeader;

    var dio = Dio();
    var response = await dio.get(
      ApiConsts.hostUrl + "api/v1" + ApiConsts.deseaseDatalist + title,
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );
    return DieaseDataListResModel.fromJson(response.data);
  }
}
