import 'dart:developer';
import 'dart:io' show Platform;

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/drug_database_updated_model.dart';
import 'package:doctor_yab/app/data/models/drug_feedback_res_model.dart';
import 'package:doctor_yab/app/data/repository/DrugDatabaseRepository.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speech/flutter_speech.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class DrugsController extends GetxController {
  String filterSearch = "";
  TextEditingController searchController = TextEditingController();
  TextEditingController searchSaveController = TextEditingController();
  TextEditingController comment = TextEditingController();

  // var pageController = PagingController<int, Datum>(firstPageKey: 1);
  var pageController = PagingController<int, UpdatedDrug>(firstPageKey: 1);
  CancelToken cancelToken = CancelToken();

  @override
  void onInit() {
    bannerAds();
    pageController.addPageRequestListener((pageKey) {
      // drugData(pageKey);
      updatedDrugData(pageKey);
    });
    activateSpeechRecognizer();

    // bannerAds();
    super.onInit();
  }

  search(String s) {
    filterSearch = s;
    update();
  }

  @override
  void onClose() {
    bannerAd!.dispose();
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
  List<dynamic> listAd = [];

  // void drugData(int page) {
  //   DrugDatabaseRepository()
  //       .fetchDrugs(page, searchController.text.trim(),
  //           cancelToken: cancelToken)
  //       .then((data) {
  //     //TODO handle all in model
  //
  //     if (data != null) {
  //       if (data == null) {
  //         data.data["data"] = [];
  //       }
  //       print('==Datum=Drug==>${data.data}');
  //
  //       var newItems = <Datum>[];
  //       var promotedItems = <Datum>[];
  //       data.data["data"].forEach((item) {
  //
  //         if (item['active'] == true) {
  //           promotedItems.add(Datum.fromJson(item));
  //         } else {
  //           newItems.add(Datum.fromJson(item));
  //         }
  //       });
  //       // data.data["data"].forEach((item) {
  //       //   newItems.add(Datum.fromJson(item));
  //       // });
  //       newItems.forEach((element) {
  //         promotedItems.add(element);
  //       });
  //
  //       // var newItems = DrugStoresModel.fromJson(data.data).data;
  //       print('==Datum=Drug==>${promotedItems.length}======$page');
  //       if (promotedItems == null || promotedItems.length == 0) {
  //         pageController.appendLastPage(promotedItems);
  //       } else {
  //         pageController.appendPage(promotedItems, page + 1);
  //       }
  //     } else {}
  //   }).catchError((e, s) {
  //     if (!(e is DioError && CancelToken.isCancel(e))) {
  //       pageController.error = e;
  //     }
  //     log(e.toString());
  //     FirebaseCrashlytics.instance.recordError(e, s);
  //   });
  // }

  void updatedDrugData(int page) {
    DrugDatabaseRepository().updatedFetchDrugs(page, searchController.text, cancelToken: cancelToken).then((data) {
      //TODO handle all in model

      log('-----data------${data.data}');

      if (data == null) {
        data.data["data"] = [];
      }
      log('==Datum=Drug==>${data.data}');

      var newItems = <UpdatedDrug>[];
      var promotedItems = <UpdatedDrug>[];
      data.data["data"].forEach((item) {
        if (item['active'] == true) {
          promotedItems.add(UpdatedDrug.fromJson(item));
        } else {
          newItems.add(UpdatedDrug.fromJson(item));
        }
      });
      // data.data["data"].forEach((item) {
      //   newItems.add(Datum.fromJson(item));
      // });
      newItems.forEach((element) {
        promotedItems.add(element);
      });

      // var newItems = DrugStoresModel.fromJson(data.data).data;
      log('==Datum=Drug==>${promotedItems.length}======$page');
      if (promotedItems == null || promotedItems.length == 0) {
        pageController.appendLastPage(promotedItems);
      } else {
        pageController.appendPage(promotedItems, page + 1);
      }
    }).catchError((e, s) {
      if (!(e is DioError && CancelToken.isCancel(e))) {
        pageController.error = e;
      }
      log(e.toString());
      FirebaseCrashlytics.instance.recordError(e, s);
    });
  }

  Widget bannerAdWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: isLoadAd == false
          ? SizedBox()
          : Container(
              height: Get.height * 0.154,
              width: bannerAd!.size.width.toDouble(),
              alignment: Alignment.center,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: AdWidget(ad: bannerAd!),
              ),
            ),
    );
  }

  UpdatedDrug? argumentsData;

  setData(UpdatedDrug value) {
    print('======>value===>${value}');

    argumentsData = value ?? UpdatedDrug();

    print('======>argumentsData===>${argumentsData!.toJson()}');
  }

  BannerAd? bannerAd;
  bool isLoadAd = false;

  bannerAds() {
    bannerAd = BannerAd(
        size: AdSize(height: (200).round(), width: Get.width.round()),
        // size: AdSize.banner,
        adUnitId: Platform.isAndroid ? Utils.bannerAdId : Utils.bannerAdIOSId,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            isLoadAd = true;
            update();
            log('Banner Ad Loaded...');
          },
          onAdFailedToLoad: (ad, error) {
            log('Banner Ad failed...$error');
            isLoadAd = false;
            update();
            ad.dispose();
          },
        ),
        request: AdRequest());
    update();
    return bannerAd!.load();
  }

  List<DrugFeedback> drugFeedback = [];
  bool isLoading = false;
  bool isLoadingFeedback = false;
  double ratings = 5.0;

  void drugReview({String? drugId}) {
    isLoading = true;
    update();
    DrugDatabaseRepository().fetchDrugsReview(drugId: drugId, cancelToken: cancelToken).then((data) {
      drugFeedback.clear();
      if (data.data['data'] != null) {
        data.data['data'].forEach((element) {
          drugFeedback.add(DrugFeedback.fromJson(element));
        });
      }
      isLoading = false;
      update();
    }).catchError((e, s) {
      isLoading = false;
      update();
      if (!(e is DioError && CancelToken.isCancel(e))) {}
      log(e.toString());
      FirebaseCrashlytics.instance.recordError(e, s);
    });
  }

  void addDrugFeedback({String? drugId, String? rating}) {
    isLoadingFeedback = true;
    update();
    FocusManager.instance.primaryFocus?.unfocus();
    DrugDatabaseRepository().addDrugsReview(drugId: drugId, comment: comment.text, rating: rating, cancelToken: cancelToken).then((data) {
      comment.clear();
      ratings = 0.0;
      isLoadingFeedback = false;
      update();
      drugReview(drugId: drugId);
    }).catchError((e, s) {
      isLoadingFeedback = false;
      update();
      if (!(e is DioError && CancelToken.isCancel(e))) {}
      log(e.toString());
      FirebaseCrashlytics.instance.recordError(e, s);
    });
  }

  int selectedTest = 0;
  SpeechRecognition? speech;
  bool speechRecognitionAvailable = false;
  bool isListening = false;

  void activateSpeechRecognizer() {
    isListening = false;
    // print('_MyAppState.activateSpeechRecognizer... ');
    speech = SpeechRecognition();
    speech?.setAvailabilityHandler(onSpeechAvailability);
    speech?.setRecognitionStartedHandler(onRecognitionStarted);
    speech?.setRecognitionResultHandler(onRecognitionResult);
    speech?.setRecognitionCompleteHandler(onRecognitionComplete);
    speech?.setErrorHandler(errorHandler);
    speech?.activate('en_US').then((res) {
      speechRecognitionAvailable = res;
      update();
    });
  }

  void start() => speech?.activate('en_US').then((_) {
        return speech?.listen().then((result) {
          // print('_MyAppState.start => result $result');

          isListening = result;
          update();
        });
      });

  void stop() => speech!.stop().then((_) {
        isListening = false;
        update();
      });

  void onSpeechAvailability(bool result) {
    speechRecognitionAvailable = result;
    update();
  }

  void onRecognitionStarted() {
    isListening = true;
    update();
  }

  void onRecognitionResult(String text) {
    log('_MyAppState.onRecognitionResult... $text');
    searchController.text = text;
    update();
  }

  void onRecognitionComplete(String text) {
    log('_MyAppState.onRecognitionComplete... $text');
    isListening = false;
    update();
  }

  void errorHandler() => activateSpeechRecognizer();
}
