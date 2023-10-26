import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/ads_model.dart';
import 'package:doctor_yab/app/services/DioService.dart';

class StoriesRepository {
  static Dio dio = AppDioService.getDioInstance();

  static var _cachedDio = AppDioService.getCachedDio;
  static Future<AdsModel> fetchAds(
      {int limitPerPage = /*10*/ 50, CancelToken cancelToken}) async {
    print(
        "SettingsController.auth.savedCity.sId>>>>${SettingsController.auth.savedCity.sId}");

    var data = await dio.get(
      '${ApiConsts.storiesPath}/${SettingsController.auth.savedCity.sId}',
      cancelToken: cancelToken,
      queryParameters: {
        // "limit": limitPerPage,
        // "page": page,
      },
      // data: {"name": name},
      // cancelToken: _searchCancelToken,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );
    return AdsModel.fromJson(data.data);
  }
}
