import 'package:dio/dio.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';

class JwtTokenInjector extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["jwtoken"] = SettingsController.userToken ?? "";
    //  handler.next(options);
    super.onRequest(options, handler);
  }
}
