// import 'dart:io' as Io;

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/services/DioService.dart';
// import 'package:file/file.dart';
// import 'package:dio/dio.dart';

class DrugStoreRepository {
  static Dio dio = AppDioService.getDioInstance();

  static var _cachedDio = AppDioService.getCachedDio;
/*  static Future<List<DrugStore>> fetchDrugStores1(
    int page,
    bool the24Hours, {
    int limitPerPage = 50,
    void onError(e),
    CancelToken cancelToken,
  }) async {
    // TODO move to some utils func
    // _searchCancelToken.cancel();
    // _searchCancelToken = CancelToken();
    return await Utils.parseResponse<DrugStore>(
      () async {
        return await _cachedDio.get(
          '${ApiConsts.drugStoreByCity}/${SettingsController.auth.savedCity.sId}',
          cancelToken: cancelToken,
          queryParameters: {
            "limit": limitPerPage,
            "page": page,
            */ /*   "sort": "name",
            "_24hour": the24Hours,*/ /*
          },
          // data: {"name": name},
          // cancelToken: _searchCancelToken,
          options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
        );
      },
      onError: onError,
    );
  }*/

  Future<Response> fetchDrugStores({
    int page,
    String sort,
    double lat,
    double lon,
    String filterName,
    int limitPerPage = 10,
    void onError(e),
    CancelToken cancelToken,
  }) async {
    Map<String, dynamic> requestParameter = {};
    if (filterName == 'نږدې  درملتون' || filterName == 'نزدیکترین دواخانه' || filterName == 'Nearest Pharmacy') {
      requestParameter = {
        "limit": limitPerPage,
        "page": page,
        "sort": sort,
        "lat": lat,
        "lng": lon,
      };
    } else {
      requestParameter = {
        "limit": limitPerPage,
        "page": page,
        "sort": sort,
      };
    }

    log('---requestParameter>>>>>$requestParameter');
    log('---URL>>>>>${ApiConsts.drugStoreByCity}/${SettingsController.auth.savedCity.sId}}');

    final response = await _cachedDio.get(
      '${ApiConsts.drugStoreByCity}/${SettingsController.auth.savedCity.sId}',
      cancelToken: cancelToken,
      queryParameters: requestParameter,
      // {
      //   "limit": limitPerPage,
      //   "page": page,
      //   "sort": sort,
      //   /*    "_24hour": the24Hours,*/
      // },
      // data: {"name": name},
      // cancelToken: _searchCancelToken,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    print('----response---->>>>$response');

    return response;
  }

  Future<Response> fetchPharmacyService({
    String id,
    void onError(e),
    CancelToken cancelToken,
  }) async {
    print("SettingsController.userToken>>>${SettingsController.userToken}");
    final response = await _cachedDio.get(
      '${ApiConsts.pharmacyService}$id',
      cancelToken: cancelToken,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );
    log("response---------------> ${response.data}");

    return response;
  }

  Future<Response> fetchPharmacyProduct({
    String id,
    void onError(e),
    CancelToken cancelToken,
  }) async {
    print("SettingsController.userToken>>>${SettingsController.userToken}");
    final response = await _cachedDio.get(
      '${ApiConsts.pharmacyProduct}$id',
      cancelToken: cancelToken,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );
    log("response--------------> ${response.data}");

    return response;
  }

  Future<Response> searchDrugStores({
    String name,
    void onError(e),
    CancelToken cancelToken,
  }) async {
    log("name--------------> $name");

    final response = await _cachedDio.get(
      '${ApiConsts.drugStoreBySearch}$name',
      cancelToken: cancelToken,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    return response;
  }

  Future<Response> getDrugDetails({
    String id,
    void onError(e),
    CancelToken cancelToken,
  }) async {
    log("name--------------> ${id}");

    final response = await _cachedDio.get(
      '${ApiConsts.getDrugDetails}1',
      cancelToken: cancelToken,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    return response;
  }

  //*
  Future<Response<dynamic>> fetchCheckup(String drugStoreID) async {
    final response = await _cachedDio.get(
      ApiConsts.drugStoreCheckups + "/$drugStoreID",

      // data: {
      //   "age": age,
      //   "name": name,
      // },
      // cancelToken: loginCancelToken,
      // queryParameters: {"hid": hospitalID},
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );
    return response;
  }
}
