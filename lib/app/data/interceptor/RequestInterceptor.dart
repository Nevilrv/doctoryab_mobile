import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class RequestInterceptor extends Interceptor {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // if (options.data is FormData) {
    //   FormData formData = options.data;
    //   Logger().d(formData.fields);
    // } else
    Logger().d(options.data);
    return options;
  }
}
