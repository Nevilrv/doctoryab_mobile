import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/city_model.dart';
import 'package:doctor_yab/app/data/models/user_model.dart' as u;
import 'package:doctor_yab/app/data/repository/AuthRepository.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/services/DioService.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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

    if (response.data['data'] != null) {
      response.data['data'].forEach((element) {
        locations.add(City.fromJson(element));
      });
    }

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
        } catch (e) {
          isLoading.value = false;
        }
      });
    }
  }
}
