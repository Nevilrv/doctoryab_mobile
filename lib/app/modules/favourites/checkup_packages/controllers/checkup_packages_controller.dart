import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/checkUp_packge_res_model.dart';
import 'package:doctor_yab/app/data/models/checkupPackages_res_model.dart';
import 'package:doctor_yab/app/data/models/city_model.dart';
import 'package:doctor_yab/app/data/models/hospital_lab_schedule_res_model.dart';
import 'package:doctor_yab/app/data/repository/CheckUpRepository.dart';
import 'package:doctor_yab/app/services/DioService.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/AppGetDialog.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:doctor_yab/app/utils/exception_handler/DioExceptionHandler.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speech/flutter_speech.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  var isCheckBox = false.obs;
  var selectedDate = "".obs;
  TextEditingController teName = TextEditingController();
  TextEditingController teNewNumber = TextEditingController();
  TextEditingController teAge = TextEditingController();
  var genderList = ['Male', "Female", "Other"];
  var selectedGender = "Male".obs;
  var selectedType = "".obs;
  selectDate(DateTime picked) async {
    selectedDate.value = picked.toString();
    timeList.clear();
    selectedTime.value = "";

    update();
    List<String> data = [];

    scheduleList.forEach((element) {
      if (element.dayOfWeek.toString() == picked.weekday.toString()) {
        data.addAll(element.times);
        update();
      } else if (picked.weekday.toString() == "7") {
        if (element.dayOfWeek.toString() == "0") {
          data.addAll(element.times);
          update();
        }
      }
    });
    data.forEach((element) {
      timeList.add(
          "${DateTime(picked.year, picked.month, picked.day, int.parse(element.split(":").first), int.parse(element.split(":").last), 0, 0, 0).toLocal()}");
    });

    update();
  }

  var timeList = <String>[].obs;
  var selectedTime = "".obs;
  @override
  void onInit() {
    selectedTest = 0;
    update();
    teName.text = SettingsController.savedUserProfile.name ?? "";
    teNewNumber.text = SettingsController.savedUserProfile.phone ?? "";
    teAge.text = SettingsController.savedUserProfile.age.toString() ?? "";
    update();
    pagingController.addPageRequestListener((pageKey) {
      fetchCheckUpPackages(pageKey);
    });
    loadCities();

    activateSpeechRecognizer();
    super.onInit();
  }

  var loading = false.obs;
  Future<void> bookNow({
    String packageId,
  }) async {
    loading.value = true;

    await PackageRepository()
        .bookTime(
            hospitalId: selectedHospitalLabId.value,
            packageId: packageId,
            labId: selectedTime.value,
            type: selectedType.value,
            time: DateTime.parse(selectedTime.value)
                .toLocal()
                .toIso8601String()
                .toString())
        .then((value) {
      loading.value = false;
      var response = value.data;
      Get.until((route) => route.isFirst);
      // Get.offAllNamed(Routes.HOME, arguments: {'id': 0});
      var patId = response['data']['patientId']?.toString() ?? "null";
      Get.dialog(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: Container(
              width: Get.width,
// height: Get.height * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColors.white,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.height * 0.03, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    SvgPicture.asset(
                      AppImages.success,
                      height: 230,
                      width: 230,
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Text(
                      "book_success".tr,
                      style: AppTextStyle.boldPrimary24
                          .copyWith(color: AppColors.green3),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Text(
                      "Your booking request succesfully, check your e-mail other details!",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.mediumBlack16
                          .copyWith(color: AppColors.black3, fontSize: 15),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        Get.back();
                      },
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.primary),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Center(
                              child: Text("back_to_checkup_list".tr,
                                  style: AppTextStyle.boldWhite15)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
// confirm: Text("cooo"),
// actions: <Widget>[Text("aooo"), Text("aooo")],
// cancel: Text("bla bla"),
// content: Text("bla bldddda"),
      );
    }).catchError(
      (e, s) {
        loading.value = false;

        if (e.type == DioErrorType.response) {
          AppGetDialog.showWithRetryCallBack(
            middleText: e.response.data['message'] ??
                "check_internet_connection_and_retry".tr,
            // "check_internet_connection_and_retry".tr,
            operationTitle: "",
            retryButtonText: "",
            retryCallBak: bookNow,
          );
        } else {
          DioExceptionHandler.handleException(
            exception: e,
            retryCallBak: bookNow,
          );
        }
        FirebaseCrashlytics.instance.recordError(e, s);
      },
    );
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

    if (response.data['data'] != null) {
      response.data['data'].forEach((element) {
        locations.add(City.fromJson(element));
      });
    }

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

  List<PackageHistory> packageHistory = [];
  bool historyLoading = false;
  getPackageHistory() {
    packageHistory.clear();
    historyLoading = true;
    update();
    PackageRepository.fetchPackageHistory(
      cancelToken: cancelToken,
    ).then((value) {
      CheckUpPackageResModel checkUpPackageResModel =
          CheckUpPackageResModel.fromJson(value);
      packageHistory.addAll(checkUpPackageResModel.data);
      historyLoading = false;
      update();
    }).catchError((e, s) {
      historyLoading = false;
      update();
      if (!(e is DioError && CancelToken.isCancel(e))) {}
      log(e.toString());
      FirebaseCrashlytics.instance.recordError(e, s);
    });
  }

  var scheduleList = <Schedule>[].obs;
  var scheduleListDate = <DateTime>[].obs;
  getLabScheduleList({String labId, String hospitalId, String type}) {
    scheduleList.clear();
    scheduleListDate.clear();

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
        scheduleList.forEach((element) {
          for (var i = 0; i < 15; i++) {
            if (DateTime.now().add(Duration(days: i)).weekday ==
                element.dayOfWeek) {
              scheduleListDate.add(DateTime.now().add(Duration(days: i)));
              scheduleListDate.sort((a, b) {
                return a.compareTo(b);
              });
            }
          }
        });
      });
    } else {
      PackageRepository.fetchHospitalSchedule(
        cancelToken: cancelToken,
        hospitalId: hospitalId,
      ).then((value) {
        HospitalLabScheduleResModel resModel =
            HospitalLabScheduleResModel.fromJson(value);
        scheduleList.addAll(resModel.data);
        scheduleList.forEach((element) {
          for (var i = 0; i < 15; i++) {
            if (DateTime.now().add(Duration(days: i)).weekday ==
                element.dayOfWeek) {
              scheduleListDate.add(DateTime.now().add(Duration(days: i)));
              scheduleListDate.sort((a, b) {
                return a.compareTo(b);
              });
            }
          }
        });
      });
    }
    update();
  }

  getLabAndHospitalList(List<dynamic> data) {
    selectHospitalLabList.clear();
    selectedHospitalLabId.value = "";
    selectedHospitalLabName.value = "";
    scheduleList.clear();
    selectedTime.value = "";
    timeList.clear();
    selectedDate.value = "";
    selectHospitalLabList.addAll(data);
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
    }).catchError((e, s) {
      isLoading = false;
      update();
      if (!(e is DioError && CancelToken.isCancel(e))) {}
      log(e.toString());
      FirebaseCrashlytics.instance.recordError(e, s);
    });
  }

  void addPackageFeedback({String packageId, String rating}) {
    Get.back();
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

        if (newItems == null || newItems.length == 0) {
          pagingController.appendLastPage(newItems);
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
