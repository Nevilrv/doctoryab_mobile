// import 'dart:io' as Io;

import 'dart:developer';
import 'dart:io';

import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/chat_list_api_model.dart';
import 'package:doctor_yab/app/services/DioService.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';

import '../../utils/utils.dart';
import '../models/chat_model.dart';
// import 'package:file/file.dart';
// import 'package:dio/dio.dart';

class ChatRepository {
  static Dio dio = AppDioService.getDioInstance();

  static var _cachedDio = AppDioService.getCachedDio;

  //* Search doctors
  static Future<List<ChatListApiModel>> fetchChatList(
    String searchValue, {
    int limitPerPage = 100,
    int page,
    void onError(e),
    CancelToken cancelToken,
  }) async {
    // TODO move to some utils func
    // _searchCancelToken.cancel();
    // _searchCancelToken = CancelToken();
    return await Utils.parseResponse<ChatListApiModel>(
      () async {
        // var doctorReports;
        // return await _cachedDio.get(
        return await dio.get(
          // '/findBloodDonors/profile',
          '/chat',
          cancelToken: cancelToken,
          queryParameters: {
            "limit": limitPerPage,
            "page": page,
            "searchVal": searchValue,
          },

          // cancelToken: _searchCancelToken,
          options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
        );
      },
      onError: onError,
    );
  }

  static Future<List<ChatApiModel>> fetchChatsById(
    String chatID, {
    int limitPerPage = 10,
    int page,
    void onError(e),
    CancelToken cancelToken,
  }) async {
    // TODO move to some utils func
    // _searchCancelToken.cancel();
    // _searchCancelToken = CancelToken();
    return await Utils.parseResponse<ChatApiModel>(
      () async {
        // var doctorReports;
        return await dio.get(
          // '/findBloodDonors/profile',
          '/message/$chatID',
          cancelToken: cancelToken,
          queryParameters: {
            "limit": limitPerPage,
            "page": page,
            // "searchVal": searchValue,
          },

          // cancelToken: _searchCancelToken,
          options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
        );
      },
      onError: onError,
    );
  }

  static Future<ChatApiModel> sendMessage(
    String chatID,
    String message, {
    void onError(e),
    CancelToken cancelToken,
  }) async {
    // TODO move to some utils func
    // _searchCancelToken.cancel();
    // _searchCancelToken = CancelToken();
    var response;
    try {
      response = await dio.post(
        // '/findBloodDonors/profile',
        '/message/',
        cancelToken: cancelToken,
        data: {
          "chatId": "$chatID",
          "content": "$message",
        },
        options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
      );
    } catch (e, s) {
      if (onError != null) {
        Logger().e("send message error", e, s);

        if (e is DioError) {
          if (!CancelToken.isCancel(e)) {
            onError(e);
          } //make sure not collecting error of canceling dio requests
        } else {
          onError(e);
        }
      }
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    var _r = response.data;

    ///TODO have a note that we areforce removing this, because they dont match here
    _r["readBy"] = [];
    if (_r["chat"] != null) _r["chat"]["users"] = [];
    return ChatApiModel.fromJson(response.data);
    // onError: onError,
  }

  Future<dynamic> uploadImage({
    List<File> file,
  }) async {
    List uploadList = [];
    // FormData formData;
    for (var i = 0; i < file.length; i++) {
      log("file[i].path--------------> ${file[i].path}");

      uploadList.add(await MultipartFile.fromFile(file[i].path,
          filename: file[i].path.split('/').last,
          contentType: MediaType(
              file[i].path.split("/")[0], file[i].path.split("/")[1])));
    }

    log("uploadList--------------> ${uploadList}");

    var data = FormData.fromMap({
      'files': uploadList,
    });
    log("data--------------> ${data}");

    var dio = Dio();
    var response = await dio.request(
      'https://testserver.doctoryab.app/api/v1/message/imgs',
      options: Options(
        method: 'POST',
        headers: {
          'apikey':
              "zwsexdcrfvtgbhnjmk123321321312312313123123123123123lkmjnhbgvfcdxesxdrcftvgybhnujimkorewuirueioruieworuewoiruewoirqwff",
          'jwtoken': SettingsController.userToken.toString(),
          'Content-Type': 'application/json'
        },
      ),
      data: data,
    );

    log("response--------------> ${response.data}");
    log("response--------------> ${response.statusCode}");

    // print(response);
    return response.data;
  }

  static Future<ChatApiModel> createNewChat(
    String title,
    String message, {
    void onError(e),
    CancelToken cancelToken,
  }) async {
    // TODO move to some utils func
    // _searchCancelToken.cancel();
    // _searchCancelToken = CancelToken();
    var response;
    try {
      response = await dio.post(
        // '/findBloodDonors/profile',
        '/chat/createChatAndSendMessage/',
        cancelToken: cancelToken,
        data: {
          "reason": "$title",
          "content": "$message",
        },
        options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
      );
    } catch (e, s) {
      if (onError != null) {
        Logger().e("create new chat error", e, s);

        if (e is DioError) {
          if (!CancelToken.isCancel(e)) {
            onError(e);
          } //make sure not collecting error of canceling dio requests
        } else {
          onError(e);
        }
      }
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    var _r = response.data;

    ///TODO have a note that we areforce removing this, because they dont match here
    _r["readBy"] = [];
    if (_r["chat"] != null) _r["chat"]["users"] = [];
    return ChatApiModel.fromJson(response.data);
    // onError: onError,
  }
}
