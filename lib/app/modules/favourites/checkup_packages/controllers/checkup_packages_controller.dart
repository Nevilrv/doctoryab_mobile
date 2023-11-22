import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/HospitalsModel.dart';
import 'package:doctor_yab/app/data/models/checkupPackages_res_model.dart';
import 'package:doctor_yab/app/data/models/city_model.dart';
import 'package:doctor_yab/app/data/models/hospital_lab_schedule_res_model.dart';
import 'package:doctor_yab/app/data/models/labs_model.dart';
import 'package:doctor_yab/app/data/repository/CheckUpRepository.dart';
import 'package:doctor_yab/app/services/DioService.dart';
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
  var selectHospitalLabList = <dynamic>[].obs;
  var selectedHospitalLabId = "".obs;
  var selectedHospitalLabName = "".obs;
  var selectedDate = "".obs;
  TextEditingController teName = TextEditingController();
  TextEditingController teNewNumber = TextEditingController();
  TextEditingController teAge = TextEditingController();
  var genderList = ['Male', "Female", "Other"];
  var selectedGender = "Male".obs;
  Future<void> selectDate(BuildContext context) async {
    timeList.clear();
    selectedTime.value = "";
    update();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null) {
      selectedDate.value = "${picked.year}-${picked.month}-${picked.day}";

      log("scheduleList--------------> ${scheduleList.length}");

      List<String> data = [];
      log("picked.weekday.toString()--------------> ${picked.weekday.toString()}");

      scheduleList.forEach((element) {
        if (element.dayOfWeek.toString() == picked.weekday.toString()) {
          data.addAll(element.times);
          update();
          log("element--------------> ${element}");
        } else if (picked.weekday.toString() == "7") {
          if (element.dayOfWeek.toString() == "0") {
            data.addAll(element.times);
            update();
            log("element--------------> ${element}");
          }
        }
      });
      data.forEach((element) {
        timeList.add(
            "${DateTime(picked.year, picked.month, picked.day, int.parse(element.split(":").first), int.parse(element.split(":").last), 0, 0, 0).toLocal()}");
      });
      log("timeList--------------> ${timeList}");

      update();
    }
  }

  var timeList = <String>[].obs;
  var selectedTime = "".obs;
  @override
  void onInit() {
    selectedTest = 0;
    update();
    pagingController.addPageRequestListener((pageKey) {
      fetchCheckUpPackages(pageKey);
    });
    loadCities();

    activateSpeechRecognizer();
    super.onInit();
  }

  var locations = <City>[].obs;

  var _cachedDio = AppDioService.getCachedDio;

  var selectedLocation = "".obs;
  var selectedLocationId = "".obs;
  Future<dynamic> loadCities() async {
    final response = await _cachedDio.get(
      ApiConsts.cityPath,
      queryParameters: {
        "limit": '200000',
        "page": '1',
      },
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );
    log("response--------------> ${response.data}");
    log("response-statusCode-------------> ${response.statusCode}");
    if (response.data['data'] != null) {
      response.data['data'].forEach((element) {
        locations.add(City.fromJson(element));
      });
    }
    log("response--------------> ${locations.length}");

    return response;
  }

  @override
  void onClose() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      selectedTest = 0;
      update();
    });
    // TODO: implement onClose
    super.onClose();
  }

  var scheduleList = <Schedule>[].obs;
  getLabScheduleList({String labId, String hospitalId, String type}) {
    scheduleList.clear();

    selectedTime.value = "";
    timeList.clear();
    selectedDate.value = "";
    if (type == "lab") {
      PackageRepository.fetchLabsSchedule(
              cancelToken: cancelToken, labId: labId)
          .then((value) {
        HospitalLabScheduleResModel resModel =
            HospitalLabScheduleResModel.fromJson(value);
        scheduleList.addAll(resModel.data);
        log("value---value-----------> ${value}");
        log("resModel---resModel-----------> ${resModel}");
      });
    } else {
      PackageRepository.fetchHospitalSchedule(
        cancelToken: cancelToken,
        hospitalId: hospitalId,
      ).then((value) {
        HospitalLabScheduleResModel resModel =
            HospitalLabScheduleResModel.fromJson(value);
        scheduleList.addAll(resModel.data);

        log("value---value-----------> ${value}");
        log("resModel---resModel-----------> ${resModel}");
      });
    }
    update();
  }

  List<dynamic> labHospitalList = [];
  getLabAndHospitalList() {
    selectHospitalLabList.clear();
    selectedHospitalLabId.value = "";
    selectedHospitalLabName.value = "";
    scheduleList.clear();
    selectedTime.value = "";
    timeList.clear();
    selectedDate.value = "";
    PackageRepository.fetchHospitals(
            cancelToken: cancelToken, cityId: selectedLocationId.value)
        .then((value) {
      List<Hospital> hospitalList = [];
      hospitalList.addAll(value);
      hospitalList.forEach((element) {
        selectHospitalLabList
            .add({"id": element.id, "name": element.name, "type": "hospital"});
      });
      log("hospitalList--------------> ${hospitalList.length}");

      log("value---fetchHospitals-----------> ${selectHospitalLabList.length}");
    });
    update();
    PackageRepository.fetchLabs(
            cancelToken: cancelToken, cityId: selectedLocationId.value)
        .then((value) {
      List<Labs> labs = [];
      LabsModel labsModel = LabsModel.fromJson(value);

      labs.addAll(labsModel.data);
      labs.forEach((element) {
        selectHospitalLabList
            .add({"id": element.datumId, "name": element.name, "type": "lab"});
      });
      log("labHospitalList--------------> ${selectHospitalLabList.length}");
      log("value----fetchLabs----------> ${labs.length}");
    });
    update();
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
