import 'dart:developer';
import 'dart:io';

import 'package:country_provider2/country_provider2.dart';
import 'package:doctor_yab/app/data/repository/AbroadTreatmentRepo.dart';
import 'package:doctor_yab/app/utils/AppGetDialog.dart';
import 'package:doctor_yab/app/utils/exception_handler/DioExceptionHandler.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TreatmentAbroadController extends GetxController {
  var selectedCountry = "".obs;
  var visaSupport = "".obs;
  var airportService = "".obs;
  var translator = "".obs;
  var accomization = "".obs;
  TextEditingController tellAbout = TextEditingController();
  @override
  void onInit() {
    log('hello-------------');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getAllCountries();
    });
    // TODO: implement onInit
    super.onInit();
  }

  RxList<Country> countries = <Country>[].obs;
  var isLoading = false.obs;
  Future<void> getAllCountries() async {
    isLoading.value = true;

    try {
      // List<Country> countries = await CountryProvider.getAllCountries();
      // Get all countries
      // List<Country>? countries = await CountryProvider.getAllCountries();
      List<Country> result = await CountryProvider.instance.getAllCountries();
      // log("countries--------------> ${result}");
      countries.value = result;
      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      log("e--------------> ${e}");
    }
  }

  var apiLoading = false.obs;
  abroadApi(BuildContext context) {
    apiLoading.value = true;
    AbroadRepository()
        .abroadTreatmentApi(
            desc: tellAbout.text,
            accomization: accomization.value == "YES" ? true : false,
            country: selectedCountry.value,
            service: airportService.value == "YES" ? true : false,
            translator: translator.value == "YES" ? true : false,
            visaSupport: visaSupport.value == "YES" ? true : false)
        .then((value) {
      log("value['data']['_id']--------------> ${value['data']['_id']}");

      if (attachmentFile.value != "") {
        AbroadRepository()
            .abroadImageApi(
                image: File(attachmentFile.value), id: value['data']['_id'])
            .then((value) {
          Get.back();

          AppGetDialog.showSuccess(
              middleText: "done".tr + "\n\n" + "abroad_success".tr);

          apiLoading.value = false;
          log("value--------------> ${value}");
        }).catchError((e, s) {
          apiLoading.value = false;
        });
      } else {
        Get.back();
        AppGetDialog.showSuccess(
            middleText: "done".tr + "\n\n" + "abroad_success".tr);
        apiLoading.value = false;
      }

      log("value--------------> ${value}");
    }).catchError((e, s) {
      apiLoading.value = false;
      DioExceptionHandler.handleException(
          //(e,sTODO not tesetd yet
          exception: e,
          retryCallBak: () {
            // complaintApi(context);
          });
      FirebaseCrashlytics.instance.recordError(e, s);
    });
  }

  var attachmentFile = "".obs;
  void pickAttachment() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpeg', 'JPEG', 'png', 'PNG', 'JPG', 'jpg'],
        allowMultiple: false);
    attachmentFile.value = result.files[0].path;
  }
}
