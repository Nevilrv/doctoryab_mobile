import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/interceptor/ApiTokenInterceptor.dart';
import 'package:doctor_yab/app/data/interceptor/ForceLogoutInterceptor.dart';
import 'package:doctor_yab/app/data/interceptor/JwtTokenInjector.dart';

class AppDioService {
  static Dio _dio = () {
    var _dio = Dio();
    BaseOptions options = new BaseOptions(
      baseUrl: ApiConsts.baseUrl,
      connectTimeout: 15000,
      receiveTimeout: 13000,
    );

    _dio.options = options;
    _dio.interceptors
          ..add(ForceLogoutInterceptor())
          ..add(ApiTokenInterceptor())
          ..add(JwtTokenInjector())
        // ..add(PrettyDioLogger(
        //   requestHeader: true,
        //   requestBody: true,
        //   responseBody: true,
        //   responseHeader: false,
        //   error: true,
        //   compact: true,
        //   maxWidth: 90,
        // ))

        ;
    // if ((kDebugMode  || ApiConsts.debugModeOnRelease) &&!Platform.isIOS ) {
    //   _dio.interceptors.add(Get.find<Alice>().getDioInterceptor());
    // }

    // ..add(RequestInterceptor())
    // ..add(Get.find<Alice>().getDioInterceptor())

    // ..add(LogInterceptor(
    //   responseBody: true,
    //   requestHeader: true,
    //   request: true,
    //   responseHeader: true,
    //   error: true,
    // ))
    return _dio;
  }();
  static Dio _cachedDio = () {
    var _cachedDio = Dio();
    _cachedDio.options = _dio.options;
    _cachedDio.interceptors.addAll(_dio.interceptors);
    _cachedDio.interceptors.add(
      DioCacheManager(
        CacheConfig(baseUrl: ApiConsts.hostUrl),
      ).interceptor,
    );
    return _cachedDio;
  }();
  static Dio getDioInstance() {
    print("base1: ${ApiConsts.baseUrl} ${_dio.options.baseUrl}");
    return _dio;
  }

  static Dio get getCachedDio {
    return _cachedDio;
  }

  static Options cachedDioOption(Duration duration) {
    return buildCacheOptions(duration, maxStale: Duration(days: 10));
  }

  static void switchServer() {
    if (ApiConsts.hostUrl == ApiConsts.liveHostUrl) {
      ApiConsts.hostUrl = ApiConsts.localHostUrl;
    } else {
      ApiConsts.hostUrl = ApiConsts.liveHostUrl;
    }
    _dio.options.baseUrl = ApiConsts.baseUrl;
    _cachedDio.options.baseUrl = ApiConsts.baseUrl;
  }
}
