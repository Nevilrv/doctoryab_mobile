// import 'dart:io' as Io;

import 'package:doctor_yab/app/data/ApiConsts.dart';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/post.dart';
import 'package:doctor_yab/app/services/DioService.dart';

import '../../utils/utils.dart';
import '../models/blog_categories.dart';
// import 'package:file/file.dart';
// import 'package:dio/dio.dart';

class BlogRepository {
  static Dio dio = AppDioService.getDioInstance();

  static var _cachedDio = AppDioService.getCachedDio;

  //* Search doctors
  static Future<List<BlogCategory>> fetchCategories({
    // int limitPerPage = 10,
    void onError(e),
    CancelToken cancelToken,
  }) async {
    // TODO move to some utils func
    // _searchCancelToken.cancel();
    // _searchCancelToken = CancelToken();
    return await Utils.parseResponse<BlogCategory>(
      () async {
        // var doctorReports;
        return await _cachedDio.get(
          // '/findBloodDonors/profile',
          '/blogCategory/AllCategories',
          cancelToken: cancelToken,
          queryParameters: {
            // "limit": limitPerPage,
            // "page": page,
          },

          // cancelToken: _searchCancelToken,
          options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
        );
      },
      onError: onError,
    );
  }

  //* Search doctors
  static Future<List<Post>> fetchPostsByCategory(
    int page,
    BlogCategory blogCategory, {
    int limitPerPage = 10,
    void onError(e),
    CancelToken cancelToken,
  }) async {
    // TODO move to some utils func
    // _searchCancelToken.cancel();
    // _searchCancelToken = CancelToken();
    return await Utils.parseResponse<Post>(
      () async {
        // var doctorReports;
        return await _cachedDio.get(
          // '/findBloodDonors/profile',
          '/blogs/getBlogsByCategory/${blogCategory.category}',
          cancelToken: cancelToken,
          queryParameters: {
            "limit": limitPerPage,
            "page": page,
          },
          // data: {
          //   "bloodGroup": b.bloodGroup,
          //   "bloodUnits": b.bloodUnits,
          //   "critical": true,
          //   "condition": "",
          //   "name": b.name,
          //   "number": b.number,
          //   "geometry": {
          //     "type": "Point",
          //     "coordinates": [
          //       b.geometry.coordinates[0],
          //       b.geometry.coordinates[1]
          //     ]
          //   }
          // },
          // cancelToken: _searchCancelToken,
          options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
        );
      },
      onError: onError,
    );
  }
}
