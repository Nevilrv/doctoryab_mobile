import 'package:dio/dio.dart';

import '../../services/DioService.dart';
import '../ApiConsts.dart';

class NotificationRepository {
  Dio dio = AppDioService.getDioInstance();
  var _cachedDio = AppDioService.getCachedDio;

  //* Notification Load
  Future<dynamic> loadNotification() async {
    final response = await _cachedDio.get(
      ApiConsts.notification,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    return response.data;
  }
}
