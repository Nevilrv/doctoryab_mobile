import 'dart:developer';

import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/city_model.dart';
import 'package:doctor_yab/app/data/repository/AuthRepository.dart';

import 'package:doctor_yab/app/services/DioService.dart';

import 'package:doctor_yab/app/utils/utils.dart';

import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import 'package:doctor_yab/app/data/models/user_model.dart' as u;

class RegisterGuestUserController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController teNewNumber = TextEditingController();
  TextEditingController teAge = TextEditingController();
  TextEditingController teName = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var phoneValid = false.obs;
  var phoneValidationError = "".obs;
  var locations = <City>[].obs;

  var _cachedDio = AppDioService.getCachedDio;

  var selectedLocation = "".obs;
  var selectedLocationId = "60a8951de268152534502e57".obs;
  var genderList = ['Male', "Female", "Other"];
  var selectedGender = "Male".obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    // loadCities();

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
    AuthRepository()
        .registerGuestUserApi(teName.text, teNewNumber.text,
            selectedGender.value, selectedLocationId.value)
        .then((value) {
      log('value-------------->${value}');
      try {
        SettingsController.userToken = value["jwtoken"];
        SettingsController.userProfileComplete = value["profile_completed"];
        SettingsController.userId = value['guestUser']['_id'];
        SettingsController.savedUserProfile =
            u.User.fromJson(value['guestUser']);
        SettingsController.auth.savedCity = City.fromJson(value['city']);
        SettingsController.userLogin = true;
        isLoading.value = false;
        Utils.whereShouldIGo();
        log("SettingsController.savedUserProfile.sId--------------> ${SettingsController.savedUserProfile.name}");
      } catch (e) {
        isLoading.value = false;
        log("e--------------> ${e}");
      }
      log("value--------------> ${value}");
    });
  }
}
