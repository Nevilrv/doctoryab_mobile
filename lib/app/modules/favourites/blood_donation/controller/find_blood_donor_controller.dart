import 'package:doctor_yab/app/controllers/auth_controller.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/models/blood_donor_search_model.dart';
import 'package:doctor_yab/app/data/static.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:place_picker/place_picker.dart';

import '../../../../data/models/blood_donor_update.dart';

class FindBloodDonorController extends GetxController {
  var user = SettingsController.savedUserProfile;
  //*text Edtings
  TextEditingController teName = TextEditingController();
  TextEditingController teNewNumber = TextEditingController();

  //*
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var formValid = false.obs;

  Rx<LocationResult> locationResult = LocationResult().obs;
  var selectedBloodGroupIndex = 0.obs;
  var selectedBloodUnitsIndex = 0.obs;
  final selectedCritical = 0.obs;
  final List<String> selectGroup = [
    'A+',
    'B+',
    'AB+',
    'O+',
    'A-',
    'B-',
    'AB-',
    'O-'
  ];

  var selectedGroup = "A+".obs;
  final List<String> bloodUnits = [
    '1',
    '2',
    '3',
    '4',
  ];
  final List<String> aboutConditionList = [
    'Need for pregnant woman.',
    'Need for pregnant woman.1',
    'Need for pregnant woman.2',
    'Need for pregnant woman.3',
  ];
  var selectedUnit = "1".obs;
  var selectedAboutCondition = "Need for pregnant woman.".obs;
  @override
  void onInit() {
    locationResult.value.locality = "Kabul";
    locationResult.value.latLng = LatLng(
      34.529699,
      69.171531,
    );
    //locationResult.value.locality = "Kabul";
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    teName.text = user?.name?.toString() ?? "";
    teNewNumber.text = AuthController.to.getUser.phoneNumber
            .replaceFirst(AppStatics.envVars.countryCode, "0") ??
        "";
  }

  @override
  void onClose() {
    super.onClose();
  }

  //*
  void validateForm() {
    formValid(formKey.currentState.validate());
    print(formKey.currentState.validate());
  }

  //*
  void search() {
    Get.toNamed(
      Routes.BLOOD_DONORS_RESULTS,
      arguments: BloodDonorSearchModel(
        bloodGroup: selectGroup[selectedBloodGroupIndex()],
        bloodUnits: int.tryParse(bloodUnits[selectedBloodUnitsIndex()]),
        condition: "",
        name: teName.text,
        number: teNewNumber.text,
        geometry: Geometry(coordinates: [
          locationResult().latLng.longitude,
          locationResult().latLng.latitude
        ]),
      ),
    );
  }
}
