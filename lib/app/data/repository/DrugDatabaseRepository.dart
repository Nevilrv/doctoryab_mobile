import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/services/DioService.dart';

class DrugDatabaseRepository {
  static Dio dio = AppDioService.getDioInstance();

  static var _cachedDio = AppDioService.getCachedDio;

  Future<Response> fetchDrugs(
    int page,
    String name, {
    int limitPerPage = 6,
    void onError(e),
    CancelToken cancelToken,
  }) async {
    print("Query---Parameter---${{
      "limit": limitPerPage,
      "page": page,
      "name": name
    }}");
    final response = await _cachedDio.get(
      '${ApiConsts.drugDatabase}',
      cancelToken: cancelToken,
      queryParameters: {"limit": limitPerPage, "page": page, "name": name},
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    return response;
  }
}
