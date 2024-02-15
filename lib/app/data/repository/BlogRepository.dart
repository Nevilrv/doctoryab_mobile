// import 'dart:io' as Io;

import 'dart:convert';
import 'dart:developer';

import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/blog_like_res_model.dart';
import 'package:doctor_yab/app/data/models/post.dart';
import 'package:doctor_yab/app/services/DioService.dart';

import '../../utils/utils.dart';
import '../interceptor/JwtTokenInjector.dart';
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
          ApiConsts.blogCategories,
          cancelToken: cancelToken,
          queryParameters: {
            "limit": 50,
            "page": 1,
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
        log('-------url-url-url-----${ApiConsts.blogByCategories}${blogCategory.id}');

        // var doctorReports;
        var res = await _cachedDio.get(
          // '/findBloodDonors/profile',
          '${ApiConsts.blogByCategories}${blogCategory.id}',
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
        log("res---blog category-----------> ${res.data}");

        return res;
      },
      onError: onError,
    );
  }

  // static Future<BlogLikeResModel> blogLike({
  //   String postId,
  //   String userId,
  //   void onError(e),
  //   CancelToken cancelToken,
  // }) async {
  //   try {} catch (e) {}
  //   return await Utils.parseResponse<Post>(
  //     () async {
  //       return await _cachedDio.put(
  //         '/blogs/like',
  //         cancelToken: cancelToken,
  //         data: {"postId": postId, "userId": userId},
  //         options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
  //       );
  //     },
  //     onError: onError,
  //   );
  // }
  static Future<BlogLikeResModel> blogLike(
      {String postId, String userId, CancelToken cancelToken}) async {
    var headers = ApiConsts().commonHeader;
    var data =
        json.encode({"postId": postId.toString(), "userId": userId.toString()});
    log("data--------------> $data");

    var dio = Dio();
    var response = await dio.put(
      ApiConsts.baseUrl + ApiConsts.blogLike,
      options: Options(
        method: 'PUT',
        headers: headers,
      ),
      data: data,
    );
    return BlogLikeResModel.fromJson(response.data);
  }

  static Future<BlogLikeResModel> blogShare(
      {String postId, String userId, CancelToken cancelToken}) async {
    var headers = ApiConsts().commonHeader;
    var data =
        json.encode({"postId": postId.toString(), "userId": userId.toString()});
    log("data--------------> $data");
    log("ApiConsts.baseUrl + ApiConsts.blogShare,--------------> ${ApiConsts.baseUrl + ApiConsts.blogShare}");

    var dio = Dio();
    var response = await dio.put(
      ApiConsts.baseUrl + ApiConsts.blogShare,
      options: Options(
        method: 'PUT',
        headers: headers,
      ),
      data: data,
    );
    return BlogLikeResModel.fromJson(response.data);
  }

  static Future<BlogLikeResModel> blogComment(
      {String postId,
      String userId,
      String text,
      CancelToken cancelToken}) async {
    var headers = ApiConsts().commonHeader;
    var data = json.encode({
      "postId": postId.toString(),
      "userId": userId.toString(),
      "text": text
    });

    log('-----65ca3826af16733144b4d9ee------$data');

    Dio dio = AppDioService.getDioInstance();

    // var dio = Dio();
    var response = await dio.put(
      // ApiConsts.hostUrl + "api/v1" + ApiConsts.blogComment,
      ApiConsts.blogComment,
      // options: Options(
      //   method: 'PUT',
      //   headers: headers,
      // ),
      data: data,
    );
    return BlogLikeResModel.fromJson(response.data);
  }
}
