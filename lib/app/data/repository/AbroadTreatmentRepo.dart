import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/services/DioService.dart';
import 'package:http_parser/http_parser.dart';

class AbroadRepository {
  static Dio dio = AppDioService.getDioInstance();
  var _cachedDio = AppDioService.getCachedDio;

  Future<dynamic> abroadTreatmentApi({
    String? desc,
    String? country,
    bool? visaSupport,
    bool? accomization,
    bool? service,
    bool? translator,
  }) async {
    log("ApiConsts.abroadTreatment--------------> ${ApiConsts.abroadTreatment}");

    final response = await _cachedDio.post(
      ApiConsts.abroadTreatment,
      data: {
        "desc": desc,
        "country": country,
        "visa_support": visaSupport,
        "accomization": accomization,
        "pick_service": service,
        "translator": translator
      },
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );
    return response.data;
  }

  ///complaint image api
  Future<dynamic> abroadImageApi({
    File? image,
    String? id,
  }) async {
    FormData formData = FormData.fromMap(
      {
        "imgs": image!.path != ""
            ? await MultipartFile.fromFile(
                image.path,
                filename: image.path.split('/').last,
                contentType: MediaType('image', 'png'),
                // contentType: MediaType('img', image.path.split('.').last)
              )
            : null,
      },
    );
    final response = await _cachedDio.post(
      "${ApiConsts.abroadTreatmentImageUpload}/$id",
      data: formData,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );
    return response;
  }

  Future<dynamic> abroadPDFApi({
    File? pdf,
    String? id,
  }) async {
    FormData formData = FormData.fromMap(
      {
        "file": pdf!.path != ""
            ? await MultipartFile.fromFile(
                pdf.path,
                filename: pdf.path.split('/').last,
                contentType: MediaType('application', 'pdf'),
                // contentType: MediaType('img', image.path.split('.').last)
              )
            : null,
      },
    );
    final response = await _cachedDio.post(
      "${ApiConsts.abroadTreatmentPDFUpload}/$id",
      data: formData,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );
    return response;
  }
}
