import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/categories_model.dart';
import 'package:doctor_yab/app/data/repository/CategoriesRepository.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TabTabHomeController extends GetxController {
  var pagingController = PagingController<int, Category>(firstPageKey: 1);
  //*DIO
  CancelToken cancelToken = CancelToken();
  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      fetchCategories(pageKey);
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void fetchCategories(int pageKey) {
    CategoriesRepository()
        .getCategories(pageKey, cancelToken: cancelToken)
        .then((data) {
      // cancelToken = new CancelToken();
      // print(10 / 0);
      //TODO handle all in model
      if (data != null) {
        if (data.data["data"] == null) {
          data.data["data"] = [];
        }
        var newItems = Categories.fromJson(data.data).data;
        if (newItems == null || newItems.length == 0) {
          pagingController.appendLastPage(newItems!);
        } else {
          pagingController.appendPage(newItems, pageKey + 1);
        }
        // values.addAll( City.fromJson(data.data["data"]));
        // print(data.value.success);
      } else {}
    }).catchError((e, s) {
      // cancelToken = new CancelToken();
      if (!(e is DioError && CancelToken.isCancel(e))) {
        pagingController.error = e;
      }
      log(e.toString());
      FirebaseCrashlytics.instance.recordError(e, s);
    });
  }
}
