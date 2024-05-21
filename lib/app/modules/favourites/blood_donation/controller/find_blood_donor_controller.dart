import 'package:dio/dio.dart';
import 'package:doctor_yab/app/controllers/auth_controller.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/models/HospitalsModel.dart';
import 'package:doctor_yab/app/data/models/blood_donor_search_model.dart';
import 'package:doctor_yab/app/data/repository/HospitalRepository.dart';
import 'package:doctor_yab/app/data/static.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:place_picker/place_picker.dart';

import '../../../../data/models/blood_donor_update.dart';

class FindBloodDonorController extends GetxController {
  var user = SettingsController.savedUserProfile;
  //*text Edtings
  TextEditingController fullname = TextEditingController();
  TextEditingController condition = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  CancelToken cancelToken = CancelToken();
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
  List<String> selectedCheckBox = [];
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
  var nearByHospitalList = <Hospital>[].obs;

  List hospitalList = <Hospital>[].obs;
  var selectedUnit = "1".obs;
  var selectedAboutCondition = "Need for pregnant woman.".obs;
  var selectedNearByHospital = "".obs;
  Hospital? selectedNearByHospitalData;
  @override
  void onInit() {
    locationResult.value.locality = "Kabul";
    locationResult.value.latLng = LatLng(
      34.529699,
      69.171531,
    );
    getHospitalData();
    //locationResult.value.locality = "Kabul";
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    fullname.text = user?.name?.toString() ?? "";
    phoneNumber.text = AuthController.to.getUser.phoneNumber!
            .replaceFirst(AppStatics.envVars.countryCode, "0") ??
        "";
  }

  @override
  void onClose() {
    super.onClose();
  }

  //*
  void validateForm() {
    formValid(formKey.currentState!.validate());
    print(formKey.currentState!.validate());
  }

  //*
  void search() {
    Get.toNamed(
      Routes.BLOOD_DONORS_RESULTS,
      arguments: BloodDonorSearchModel(
        bloodGroup: selectedGroup.value,
        bloodUnits: int.parse(selectedUnit.value),
        condition: condition.text,
        critical: selectedCritical.value == 0 ? true : false,
        name: fullname.text,
        number: phoneNumber.text,
        geometry: selectedNearByHospitalData != null
            ? Geometry(
                coordinates: selectedNearByHospitalData!.geometry!.coordinates)
            : Geometry(coordinates: [
                locationResult().latLng!.longitude,
                locationResult().latLng!.latitude
              ]),
      ),
    );

    // Get.toNamed(
    //   Routes.BLOOD_DONORS_RESULTS,
    //   arguments: BloodDonorSearchModel(
    //     bloodGroup: selectGroup[selectedBloodGroupIndex()],
    //     bloodUnits: int.tryParse(bloodUnits[selectedBloodUnitsIndex()]),
    //     condition: "",
    //     name: teName.text,
    //     number: teNewNumber.text,
    //     geometry: Geometry(coordinates: [
    //       locationResult().latLng.longitude,
    //       locationResult().latLng.latitude
    //     ]),
    //   ),
    // );
  }

  void getHospitalData() {
    HospitalRepository.fetchHospitalsDropdown(
      1,
      cancelToken: cancelToken,
    ).then((value) {
      nearByHospitalList.addAll(value);
    });
  }
}
