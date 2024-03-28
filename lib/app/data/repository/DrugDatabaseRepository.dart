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
    print("Query---Parameter---${{"limit": limitPerPage, "page": page, "name": name}}");
    final response = await _cachedDio.get(
      '${ApiConsts.drugDatabase}',
      cancelToken: cancelToken,
      queryParameters: {"limit": limitPerPage, "page": page, "name": name},
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    return response;
  }

  /// Updated Fetch Drugs

  Future<Response> updatedFetchDrugs(
    int page,
    String name, {
    int limitPerPage = 10,
    void onError(e),
    CancelToken cancelToken,
  }) async {
    print("Query---Parameter---${{"limit": limitPerPage, "page": page, "name": name}}");
    final response = await _cachedDio.get(
      '${ApiConsts.drugDatabaseUpdated}',
      cancelToken: cancelToken,
      queryParameters: {"limit": limitPerPage, "page": page, "name": name},
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    return response;
  }

  Future<Response> fetchDrugsReview({
    String drugId,
    void onError(e),
    CancelToken cancelToken,
  }) async {
    final response = await _cachedDio.get(
      '${ApiConsts.drugDatabaseReview}$drugId',
      cancelToken: cancelToken,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    return response;
  }

  Future<Response> addDrugsReview({
    String drugId,
    String rating,
    String comment,
    void onError(e),
    CancelToken cancelToken,
  }) async {
    var data = {"comment": comment, "rating": rating, "drugId": drugId};
    final response = await _cachedDio.post(
      '${ApiConsts.giveFeedbackToDrug}',
      cancelToken: cancelToken,
      data: data,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    return response;
  }
}
