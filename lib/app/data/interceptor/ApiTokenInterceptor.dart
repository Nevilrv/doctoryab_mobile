import 'dart:developer';

import 'package:dio/dio.dart';
import '../ApiConsts.dart';

class ApiTokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["apikey"] = ApiConsts.apiKey;

    log('options.headers["apikey"] ::::::::::::::::::: ${options.headers["apikey"]}');
    // handler.next(options);
    super.onRequest(options, handler);
  }
}
