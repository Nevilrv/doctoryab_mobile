import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/drug_database_model.dart';
import 'package:doctor_yab/app/data/models/drug_feedback_res_model.dart';
import 'package:doctor_yab/app/data/repository/DrugDatabaseRepository.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class DrugsController extends GetxController {
  String filterSearch = "";
  TextEditingController searchController = TextEditingController();
  TextEditingController searchSaveController = TextEditingController();
  TextEditingController comment = TextEditingController();
  var pageController = PagingController<int, Datum>(firstPageKey: 1);
  CancelToken cancelToken = CancelToken();
  @override
  void onInit() {
    bannerAds();
    pageController.addPageRequestListener((pageKey) {
      drugData(pageKey);
    });
    // bannerAds();
    super.onInit();
  }

  search(String s) {
    filterSearch = s;
    update();
  }

  @override
  void onClose() {
    bannerAd.dispose();
    // TODO: implement onClose
    super.onClose();
  }

  final List medicinesNames = [
    "VITAMIN D3 (1000IU)",
    "VITAMIN C3 (1100IU)",
    "VITAMIN A2 (1000IU)",
    "VITAMIN W3 (1100IU)",
    "VITAMIN C4 (1000IU)",
    "VITAMIN D6 (1200IU)",
    "VITAMIN A4 (1100IU)",
  ];

  final List data = [
    {"image": AppImages.medicine, "title": "drug_type", "text": "capsule"},
    {"image": AppImages.pillbox, "title": "box_cont", "text": "pack_cont"},
    {"image": AppImages.coin, "title": "price", "text": "drug_price"}
  ];

  void drugData(int page) {
    DrugDatabaseRepository()
        .fetchDrugs(page, searchController.text.trim(),
            cancelToken: cancelToken)
        .then((data) {
      //TODO handle all in model

      if (data != null) {
        if (data == null) {
          data.data["data"] = [];
        }
        print('==Datum=Drug==>${data.data}');

        var newItems = <Datum>[];
        data.data["data"].forEach((item) {
          newItems.add(Datum.fromJson(item));
        });
        // var newItems = DrugStoresModel.fromJson(data.data).data;
        print('==Datum=Drug==>${newItems.length}======${page}');
        if (newItems == null || newItems.length == 0) {
          pageController.appendLastPage(newItems);
        } else {
          pageController.appendPage(newItems, page + 1);
        }
      } else {}
    }).catchError((e, s) {
      if (!(e is DioError && CancelToken.isCancel(e))) {
        pageController.error = e;
      }
      log(e.toString());
      FirebaseCrashlytics.instance.recordError(e, s);
    });
  }

  Datum argumentsData;

  setData(Datum value) {
    print('======>value===>${value}');

    argumentsData = value ?? Datum();

    print('======>argumentsData===>${argumentsData.toJson()}');
  }

  BannerAd bannerAd;
  bool isLoadAd = false;

  bannerAds() {
    bannerAd = BannerAd(
        size: AdSize(height: (200).round(), width: Get.width.round()),
        // size: AdSize.banner,
        adUnitId: Utils.bannerAdId,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            // isLoadAd = true;
            // update();
            log('Banner Ad Loaded...');
          },
          onAdFailedToLoad: (ad, error) {
            log('Banner Ad failed...$error');
            ad.dispose();
          },
        ),
        request: AdRequest());
    return bannerAd.load();
  }

  List<DrugFeedback> drugFeedback = [];
  bool isLoading = false;
  bool isLoadingFeedback = false;
  double ratings = 0.0;
  void drugReview({String drugId}) {
    isLoading = true;
    update();
    DrugDatabaseRepository()
        .fetchDrugsReview(drugId: drugId, cancelToken: cancelToken)
        .then((data) {
      drugFeedback.clear();
      if (data.data['data'] != null) {
        data.data['data'].forEach((element) {
          drugFeedback.add(DrugFeedback.fromJson(element));
        });
      }
      isLoading = false;
      update();
      log("data--------------> ${data.data}");
      log("drugFeedback--------------> ${drugFeedback.length}");
    }).catchError((e, s) {
      isLoading = false;
      update();
      if (!(e is DioError && CancelToken.isCancel(e))) {}
      log(e.toString());
      FirebaseCrashlytics.instance.recordError(e, s);
    });
  }

  void addDrugFeedback({String drugId, String rating}) {
    isLoadingFeedback = true;
    update();
    FocusManager.instance.primaryFocus?.unfocus();
    DrugDatabaseRepository()
        .addDrugsReview(
            drugId: drugId,
            comment: comment.text,
            rating: rating,
            cancelToken: cancelToken)
        .then((data) {
      comment.clear();
      ratings = 0.0;
      isLoadingFeedback = false;
      update();
      drugReview(drugId: drugId);
      log("data--------------> ${data.data}");
      log("drugFeedback--------------> ${drugFeedback.length}");
    }).catchError((e, s) {
      isLoadingFeedback = false;
      update();
      if (!(e is DioError && CancelToken.isCancel(e))) {}
      log(e.toString());
      FirebaseCrashlytics.instance.recordError(e, s);
    });
  }
}
