import 'dart:developer';

import 'package:doctor_yab/app/controllers/auth_controller.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/city_model.dart';
import 'package:doctor_yab/app/data/repository/AuthRepository.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/services/DioService.dart';
import 'package:doctor_yab/app/utils/PhoneNumberValidator.dart';
import 'package:doctor_yab/app/utils/exception_handler/FirebaseAuthExceptionHandler.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:doctor_yab/app/data/models/user_model.dart' as u;

class AddPersonalInfoController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController teNewNumber = TextEditingController();
  TextEditingController teAge = TextEditingController();
  TextEditingController teName = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var loginType = '';
  var phoneValid = false.obs;
  var phoneValidationError = "".obs;
  var locations = <City>[].obs;

  var _cachedDio = AppDioService.getCachedDio;

  var selectedLocation = "".obs;
  var selectedLocationId = "".obs;
  var genderList = ['Male', "Female", "Other"];
  var selectedGender = "Male".obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    loginType = Get.arguments ?? "";
    loadCities();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  //* City Load
  Future<dynamic> loadCities() async {
    final response = await _cachedDio.get(
      ApiConsts.cityPath,
      queryParameters: {
        "limit": '20000',
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

  void addPersonalInfo() {
    isLoading.value = true;
    if (loginType == "") {
      AuthRepository()
          .addPersonalInfoApi(teName.text, teNewNumber.text,
              selectedGender.value, selectedLocationId.value)
          .then((value) {
        try {
          // SettingsController.userToken = value["jwtoken"];
          SettingsController.userProfileComplete = value["profile_completed"];
          SettingsController.userId = value['user']['_id'];
          SettingsController.savedUserProfile = u.User.fromJson(value['user']);
          SettingsController.userLogin = true;
          isLoading.value = false;
          if (SettingsController.auth.savedCity == null) {
            Get.offAllNamed(Routes.CITY_SELECT);
          } else {
            Utils.whereShouldIGo();
          }

          log("SettingsController.savedUserProfile.sId--------------> ${SettingsController.savedUserProfile.name}");
        } catch (e) {
          isLoading.value = false;
          log("e--------------> ${e}");
        }
        log("value--------------> ${value}");
      });
    }
  }
}
