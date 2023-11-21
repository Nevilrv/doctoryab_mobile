import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/HospitalsModel.dart';
import 'package:doctor_yab/app/data/models/checkupPackages_res_model.dart';
import 'package:doctor_yab/app/data/models/labs_model.dart';
import 'package:doctor_yab/app/data/repository/CheckUpRepository.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speech/flutter_speech.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../data/models/checkup_package_feedback_res_model.dart';

class CheckupPackagesController extends GetxController {
  TextEditingController searchController = TextEditingController();
  String filterSearch = "";
  CancelToken cancelToken = CancelToken();
  TextEditingController comment = TextEditingController();
  final List<String> selectHospitalLabList = [
    'Ankara Hastanesi Laboratuvarı Kan Testi Bölümü',
    'Ankara Hastanesi Laboratuvarı Kan Testi Bölümü1',
    'Ankara Hastanesi Laboratuvarı Kan Testi Bölümü2',
    'Ankara Hastanesi Laboratuvarı Kan Testi Bölümü3',
    'Ankara Hastanesi Laboratuvarı Kan Testi Bölümü4',
    'Ankara Hastanesi Laboratuvarı Kan Testi Bölümü5',
    'Ankara Hastanesi Laboratuvarı Kan Testi Bölümü6-',
    'Ankara Hastanesi Laboratuvarı Kan Testi Bölümü7'
  ];
  var selectedHospitalLab =
      "Ankara Hastanesi Laboratuvarı Kan Testi Bölümü".obs;

  final List<String> dateList = [
    "27.08.2023",
    "28.08.2023",
    "29.08.2023",
    "30.08.2023",
    "31.08.2023",
  ];
  var selectedDate = "27.08.2023".obs;
  final List<String> timeList = [
    "21:09 AM",
    "22:09 AM",
    "23:09 AM",
    "24:09 AM",
  ];
  var selectedTime = "21:09 AM".obs;
  @override
  void onInit() {
    selectedTest = 0;
    update();
    pagingController.addPageRequestListener((pageKey) {
      fetchCheckUpPackages(pageKey);
    });
    getLabAndHospitalList();
    activateSpeechRecognizer();
    super.onInit();
  }

  @override
  void onClose() {
    selectedTest = 0;
    update();
    // TODO: implement onClose
    super.onClose();
  }

  List<dynamic> labHospitalList = [];
  getLabAndHospitalList() {
    PackageRepository.fetchHospitals(cancelToken: cancelToken).then((value) {
      List<Hospital> hospitalList = [];
      hospitalList.addAll(value);
      hospitalList.forEach((element) {
        labHospitalList
            .add({"id": element.id, "name": element.name, "type": "hospital"});
      });
      log("value---fetchHospitals-----------> ${labHospitalList.length}");
    });
    PackageRepository.fetchLabs(cancelToken: cancelToken).then((value) {
      List<Labs> labs = [];
      LabsModel labsModel = LabsModel.fromJson(value);

      labs.addAll(labsModel.data);
      labs.forEach((element) {
        labHospitalList
            .add({"id": element.id, "name": element.name, "type": "lab"});
      });
      log("value----fetchLabs----------> ${labs.length}");
    });
    log("labHospitalList--------------> ${labHospitalList.length}");
  }

  List<PackageFeedback> packageFeedback = [];
  bool isLoading = false;
  bool isLoadingFeedback = false;
  double ratings = 0.0;
  void packageReview({String packageId}) {
    isLoading = true;
    update();
    PackageRepository()
        .fetchPackageReview(packageId: packageId, cancelToken: cancelToken)
        .then((data) {
      packageFeedback.clear();
      if (data.data['data'] != null) {
        data.data['data'].forEach((element) {
          packageFeedback.add(PackageFeedback.fromJson(element));
        });
      }
      isLoading = false;
      update();
      log("data--------------> ${data.data}");
      log("drugFeedback--------------> ${packageFeedback.length}");
    }).catchError((e, s) {
      isLoading = false;
      update();
      if (!(e is DioError && CancelToken.isCancel(e))) {}
      log(e.toString());
      FirebaseCrashlytics.instance.recordError(e, s);
    });
  }

  void addPackageFeedback({String packageId, String rating}) {
    isLoadingFeedback = true;
    update();
    FocusManager.instance.primaryFocus?.unfocus();
    PackageRepository()
        .addPackageReview(
            packageId: packageId,
            comment: comment.text,
            rating: rating,
            cancelToken: cancelToken)
        .then((data) {
      comment.clear();
      ratings = 0.0;
      isLoadingFeedback = false;
      update();
      packageReview(packageId: packageId);
      log("data--------------> ${data.data}");
      log("drugFeedback--------------> ${packageFeedback.length}");
    }).catchError((e, s) {
      isLoadingFeedback = false;
      update();
      if (!(e is DioError && CancelToken.isCancel(e))) {}
      log(e.toString());
      FirebaseCrashlytics.instance.recordError(e, s);
    });
  }

  int selectedTest = 0;
  SpeechRecognition speech;
  bool speechRecognitionAvailable = false;
  bool isListening = false;

  void activateSpeechRecognizer() {
    isListening = false;
    // print('_MyAppState.activateSpeechRecognizer... ');
    speech = SpeechRecognition();
    speech.setAvailabilityHandler(onSpeechAvailability);
    speech.setRecognitionStartedHandler(onRecognitionStarted);
    speech.setRecognitionResultHandler(onRecognitionResult);
    speech.setRecognitionCompleteHandler(onRecognitionComplete);
    speech.setErrorHandler(errorHandler);
    speech.activate('en_US').then((res) {
      speechRecognitionAvailable = res;
      update();
    });
  }

  void start() => speech.activate('en_US').then((_) {
        return speech.listen().then((result) {
          // print('_MyAppState.start => result $result');

          isListening = result;
          update();
        });
      });

  void stop() => speech.stop().then((_) {
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

  search(String s) {
    filterSearch = s;
    update();
  }

  var pagingController = PagingController<int, Package>(firstPageKey: 1);
  void fetchCheckUpPackages(int pageKey) {
    PackageRepository()
        .checkupPackages(pageKey, searchController.text,
            cancelToken: cancelToken)
        .then((data) {
      // cancelToken = new CancelToken();
      // print(10 / 0);
      //TODO handle all in model
      if (data != null) {
        if (data.data["data"] == null) {
          data.data["data"] = [];
        }
        var newItems = CheckupPackagesResModel.fromJson(data.data).data;
        log("newItems--------------> ${newItems}");

        if (newItems == null || newItems.length == 0) {
          pagingController.appendLastPage(newItems);
        } else {
          pagingController.appendPage(newItems, pageKey + 1);
        }
        // values.addAll( City.fromJson(data.data["data"]));
        // print(data.value.success);
      } else {}
    }).catchError((e, s) {
      log("e--------------> ${e}");

      // cancelToken = new CancelToken();
      if (!(e is DioError && CancelToken.isCancel(e))) {
        pagingController.error = e;
      }
      log(e.toString());
      FirebaseCrashlytics.instance.recordError(e, s);
    });
  }
}
