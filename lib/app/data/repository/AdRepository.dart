import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/ads_model.dart';
import 'package:doctor_yab/app/services/DioService.dart';

class AdsRepository {
  static Dio dio = AppDioService.getDioInstance();

  static var _cachedDio = AppDioService.getCachedDio;
  static Future<AdsModel> fetchAds(
      {int limitPerPage = 10, CancelToken cancelToken}) async {
    var data = await dio.get(
      '${ApiConsts.adsPath}/${SettingsController.auth.savedCity.sId}',
      cancelToken: cancelToken,
      queryParameters: {},
      // data: {"name": name},
      // cancelToken: _searchCancelToken,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );
    return AdsModel.fromJson(data.data);
  }
}
