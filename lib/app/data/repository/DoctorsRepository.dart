// import 'dart:io' as Io;

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/categories_model.dart';
import 'package:doctor_yab/app/data/models/doctors_model.dart';
import 'package:doctor_yab/app/modules/doctors/controllers/doctors_controller.dart';
import 'package:doctor_yab/app/services/DioService.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logger/logger.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
// import 'package:file/file.dart';
// import 'package:dio/dio.dart';

class DoctorsRepository {
  Dio dio = AppDioService.getDioInstance();
  static Dio staticDio = AppDioService.getDioInstance();
  var _cachedDio = AppDioService.getCachedDio;
  static var _searchCancelToken = CancelToken();

  //* fetchDoctorsByCat
  Future<dynamic> fetchDoctors(
    int page, {
    Category cat,
    int limitPerPage = 50,
    DOCTORS_LOAD_ACTION action = DOCTORS_LOAD_ACTION.fromCategory,
    String hospitalId,
    CancelToken cancelToken,
    String sort,
    double lat,
    double lon,
    String filterName,
  }) async {
    assert(SettingsController.auth.savedCity != null);
    // assert(cat != null || loadMyDoctorsMode != null && loadMyDoctorsMode);
    var response;

    Map<String, dynamic> requestParameter = {};
    if (filterName == 'Nearest Doctor') {
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

    response = await _cachedDio.get(
      '${ApiConsts.doctorsPath}/${SettingsController.auth.savedCity.sId}/${cat.id}',
      cancelToken: cancelToken,
      queryParameters: requestParameter,
      // cancelToken: loginCancelToken,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    /* switch (action) {
      case DOCTORS_LOAD_ACTION.fromCategory:
        {
          log("City----Url---${ApiConsts.doctorsPath}/${SettingsController.auth.savedCity.sId}/${cat.id}");
          response = await _cachedDio.get(
            '${ApiConsts.doctorsPath}/${SettingsController.auth.savedCity.sId}/${cat.id}',
            cancelToken: cancelToken,
            queryParameters: {
              "limit": limitPerPage,
              "page": page,
              // "sort": sort,
              // "lat": lat,
              // "lng": lon,
            },
            // cancelToken: loginCancelToken,
            options:
                AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
          );
          break;
        }
      case DOCTORS_LOAD_ACTION.myDoctors:
        {
          response = await _cachedDio.get(
            '${ApiConsts.myDoctorsPath}',
            cancelToken: cancelToken,
            queryParameters: {
              "limit": limitPerPage,
              "page": page,
            },
            // cancelToken: loginCancelToken,
            options:
                AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
          );
          break;
        }
      case DOCTORS_LOAD_ACTION.ofhospital:
        {
          assert(hospitalId != null);
          response = await _cachedDio.get(
            '${ApiConsts.hospitalPath}/$hospitalId',
            cancelToken: cancelToken,
            queryParameters: {
              "limit": limitPerPage,
              "page": page,
              "sort": sort,
              "lat": lat,
              "lng": lon,
            },
            // cancelToken: loginCancelToken,
            options:
                AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
          );
          break;
        }
    }*/

    return response;
  }

  Future<dynamic> fetchMyDoctors({
    CancelToken cancelToken,
  }) async {
    assert(SettingsController.auth.savedCity != null);
    // assert(cat != null || loadMyDoctorsMode != null && loadMyDoctorsMode);
    var response;

    response = await _cachedDio.get(
      '${ApiConsts.myDoctorsPath}',
      cancelToken: cancelToken,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );

    return response;
  }

  //* fetchDoctorsTimeTable
  Future<dynamic> fetchDoctorsTimeTable(int page, Doctor doctor,
      {int limitPerPage = 10}) async {
    assert(SettingsController.auth.savedCity != null);
    final response = await _cachedDio.get(
      '${ApiConsts.doctorTimeTablePath}/${doctor.datumId}',
      // '${ApiConsts.doctorTimeTablePath}/${doctor.datumId}',
      queryParameters: {
        "limit": limitPerPage,
        "page": page,
      },
      // cancelToken: loginCancelToken,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );
    return response;
  }

  //* book
  // Future<dynamic> bookTime({
  //   String patId,
  //   String doctor,
  //   String name,
  //   String age,
  //   String phone,
  //   String time,
  //   String cancelToken,
  // }) async {
  //   log("doctor--------------> ${doctor}");
  //
  //   var body = {
  //     "visit_date": "2023-11-25T18:00:52.121Z",
  //     // "name": name,
  //     // "age": age.toEnglishDigit(),
  //     // "phone": phone.toEnglishDigit(),
  //     // "patientId": patId,
  //   };
  //   log("body--------------> ${body}");
  //
  //   log("ApiConsts.doctorBookPath--------------> ${'${ApiConsts.doctorBookPath}/'}");
  //
  //   // assert(SettingsController.auth.savedCity != null);
  //   final response = await _cachedDio.post(
  //     '${ApiConsts.doctorBookPath}/${doctor}',
  //     data: body,
  //     // cancelToken: cancelToken,
  //     options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
  //   );
  //   return response;
  // }

  //* Search doctors
  Future<dynamic> bookTime({
    String patId,
    Doctor doctor,
    Category cat,
    String name,
    String age,
    String phone,
    String time,
  }) async {
    log("${ApiConsts.doctorBookPath}/${doctor.id}--------------> ${ApiConsts.doctorBookPath}/${doctor.datumId}");
    log("ttt------------.${{
      "visit_date": time,
      "name": name,
      "age": age.toEnglishDigit(),
      "phone": phone.toEnglishDigit(),
      "patientId": patId,
    }}");

    assert(SettingsController.auth.savedCity != null);

    final response = await dio.post(
      '${ApiConsts.doctorBookPath}/${doctor.datumId}',
      data: {
        "visit_date": time,
        "name": name,
        "age": age.toEnglishDigit().toString(),
        "phone": phone.toEnglishDigit().toString(),
        "patientId": patId,
      },
      // cancelToken: loginCancelToken,
      // options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );
    return response;
  }

  static Future<List<Doctor>> searchDoctors(int page, String name,
      {int limitPerPage = 10, void onError(e)}) async {
    //TODO move to some utils func
    _searchCancelToken.cancel();
    _searchCancelToken = CancelToken();
    List<Doctor> _doctors;
    try {
      final response = await staticDio.post(
        '${ApiConsts.searchPath}',
        queryParameters: {
          "limit": limitPerPage,
          "page": page,
        },
        data: {"name": name},
        cancelToken: _searchCancelToken,
        options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
      );
      // var _doctors =
      //     Doctors.fromJson(response.data).data.map((e) => e.doctor).toList();
      List<dynamic> _data = response.data['data'];
      if (_data == null) return <Doctor>[]; //TODO take care of this

      _doctors = _data.map((e) => Doctor.fromJson(e)).toList();
    } catch (e, s) {
      log("e--------------> ${e}");

      Logger().e(e.toString());
      if (onError != null) {
        if (!(e is DioError && CancelToken.isCancel(e))) {
          onError(e);
        }
      }
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    return _doctors;
  }

  //* rate doctor
  static Future<void> rateDoctorByPatId(
    String pid,
    double cleaningForDoc,
    double knowledgeForDoc,
    double treatmentForDoc,
  ) async {
    final response = await staticDio.post('${ApiConsts.rateDoctor}', data: {
      "starsForDoc": (cleaningForDoc + knowledgeForDoc + treatmentForDoc) / 3,
      "cleaningForDoc": cleaningForDoc,
      "knowledgeForDoc": knowledgeForDoc,
      "treatmentForDoc": treatmentForDoc,
      "comment": "sdfsdfs",
      "id": pid,
    }
        // options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
        );
    return response;
  }

  Future<Response<dynamic>> fetchDoctorFullData(String doctorID,
      {CancelToken cancelToken}) async {
    assert(SettingsController.auth.savedCity != null);
    final response = await _cachedDio.get(
      '${ApiConsts.doctorsFullData}/$doctorID',
      cancelToken: cancelToken,
      queryParameters: {},
      // cancelToken: loginCancelToken,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );
    return response;
  }

  Future<Response<dynamic>> postDoctorFeedback(
      {CancelToken cancelToken, var body, String url}) async {
    log("url--------------> ${url}");

    final response = await _cachedDio.post(
      url,
      cancelToken: cancelToken,
      data: body,
      // cancelToken: loginCancelToken,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );
    return response;
  }

  Future<Response<dynamic>> getDoctorFeedback(
      {CancelToken cancelToken, String url}) async {
    final response = await _cachedDio.get(
      url,
      cancelToken: cancelToken,

      // cancelToken: loginCancelToken,
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );
    return response;
  }
}
