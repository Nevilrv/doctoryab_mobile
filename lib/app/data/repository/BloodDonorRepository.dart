// import 'dart:io' as Io;

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/blood_donor_search_model.dart';
import 'package:doctor_yab/app/data/models/blood_donors.dart';
import 'package:doctor_yab/app/services/DioService.dart';
import 'package:place_picker/entities/location_result.dart';

import '../../utils/utils.dart';
// import 'package:file/file.dart';
// import 'package:dio/dio.dart';

class BloodDonorRepository {
  static Dio dio = AppDioService.getDioInstance();

  static var _cachedDio = AppDioService.getCachedDio;
  Future<dynamic> updateBloodDonorProfile(
    String bloodGroup,
    LocationResult location,
    int gender,
  ) async {
    log("data---------- ${{
      "bloodGroup": bloodGroup,
      "location": location?.locality,
      "gender": gender,
      "geometry": {
        "coordinates": [location.latLng.longitude, location.latLng.latitude]
      }
    }}");

    final response = await dio.post(
      ApiConsts.updateAndRegisterBloodDonor,
      data: {
        "bloodGroup": bloodGroup,
        "location": location?.locality,
        // "gender": gender,
        "gender": gender,
        "geometry": {
          "coordinates": [location.latLng.longitude, location.latLng.latitude]
        }
      },
      // cancelToken: loginCancelToken,
    );
    return response;
  }

  //* Search doctors
  static Future<List<BloodDonor>> search(
    int page,
    BloodDonorSearchModel b, {
    int limitPerPage = 10,
    void onError(e),
    CancelToken cancelToken,
  }) async {
    // TODO move to some utils func
    // _searchCancelToken.cancel();
    // _searchCancelToken = CancelToken();
    return await Utils.parseResponse<BloodDonor>(
      () async {
        // var doctorReports;
        var data = await _cachedDio.post(
          // '/findBloodDonors/profile',
          '/findBloodDonors/profile',
          cancelToken: cancelToken,
          queryParameters: {
            "limit": limitPerPage,
            "page": page,
          },
          data: {
            "bloodGroup": b.bloodGroup,
            "bloodUnits": b.bloodUnits,
            "critical": true,
            "condition": "",
            "name": b.name,
            "number": b.number,
            "geometry": {
              "type": "Point",
              "coordinates": [
                b.geometry.coordinates[0],
                b.geometry.coordinates[1]
              ]
            }
          },
          // cancelToken: _searchCancelToken,
          options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
        );
        log("data--------------> ${data}");

        return data;
      },
      onError: onError,
    );
  }
}
