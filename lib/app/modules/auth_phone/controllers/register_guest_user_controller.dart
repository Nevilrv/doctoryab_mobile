import 'dart:developer';

import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/city_model.dart';
import 'package:doctor_yab/app/data/models/user_model.dart' as u;
import 'package:doctor_yab/app/data/repository/AuthRepository.dart';
import 'package:doctor_yab/app/services/DioService.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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
  var selectedLocationId = "".obs;
  var genderList = ['Male', "Female", "Other"];
  var selectedGender = "Male".obs;
  var isLoading = false.obs;
  @override
  void onInit() {
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
    // SettingsController.userToken =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1MmYwZGUwZWYyNzFlMDgxZjdkNDUyNSIsInJvbGUiOiJ1c2VyIiwiZW1haWwiOiJkb2N0b3J5YWIuZGV2QGdtYWlsLmNvbSIsImlhdCI6MTY5OTA3ODM2OSwiZXhwIjoxNzA3NzE4MzY5fQ.YUg9swVvFcM_ao2-D1J0xEBvRwvoPruOERoNs_VWuyg";
    // SettingsController.userProfileComplete = true;
    // SettingsController.userId = "652f0de0ef271e081f7d4525";
    // SettingsController.savedUserProfile = u.User.fromJson({
    //   "geometry": {
    //     "type": "Point",
    //     "coordinates": [69.2075, 34.5553]
    //   },
    //   "photo": "/profiles/no-image.jpg",
    //   "_id": "652f0de0ef271e081f7d4525",
    //   "email": "abc@gmail.com",
    //   "language": "English",
    //   "fcm":
    //       "cvEfx1PETw2xmlZlFqODjL:APA91bE60kDFoSgOTS4xtwBR3ZRta-6OeEUWOszbEbbz0vcKUR7c-SlfS08sfjMDMxX6x5w8Q4tVgdRcFqqLaHYQYKYnQNMwq_Mg2D40Fu6OLW8a-U881davfHPyZmPiz19EQS42PCND",
    //   "createAt": "2023-10-17T22:42:40.470Z",
    //   "patientID": "00007625",
    //   "__v": 0,
    //   "city": "60a8951de268152534502e57",
    //   "gender": "Male",
    //   "name": "Muneeb",
    //   "phone": "2323232",
    //   "age": 22
    // });
    // SettingsController.auth.savedCity = City.fromJson({
    //   "_id": "62b69bb3d768500ff79614d7",
    //   "is_deleted": false,
    //   "e_name": "Herat",
    //   "p_name": "هرات",
    //   "f_name": "هرات",
    //   "r_name": "Герат",
    //   "u_name": "Hirot",
    //   "__v": 0,
    //   "createdAt": "2023-07-23T19:57:14.442Z",
    //   "updatedAt": "2023-07-25T19:57:14.889Z"
    // });
    // SettingsController.userLogin = true;
    // isLoading.value = false;
    // Utils.whereShouldIGo();
    AuthRepository()
        .registerGuestUserApi(teName.text, teNewNumber.text,
            selectedGender.value, selectedLocationId.value)
        .then((value) {
      log('value-------------->${value}');
      log('value---------profile_completed----->${value["profile_completed"]}');
      try {
        SettingsController.userToken = value["jwtoken"];
        SettingsController.userProfileComplete =
            value["profile_completed"] ?? true;
        SettingsController.userId = value['guestUser']['_id'];
        SettingsController.savedUserProfile =
            u.User.fromJson(value['guestUser']);
        SettingsController.auth.savedCity = City.fromJson(value['city']);
        SettingsController.userLogin = true;
        isLoading.value = false;
        Utils.whereShouldIGo();
      } catch (e) {
        isLoading.value = false;
        log('e ---------->>>>>>>> ${e}');
      }
    });
  }
}
