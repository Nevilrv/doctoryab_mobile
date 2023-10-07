import 'package:doctor_yab/app/data/repository/BloodDonorRepository.dart';
import 'package:doctor_yab/app/utils/AppGetDialog.dart';
import 'package:doctor_yab/app/utils/exception_handler/DioExceptionHandler.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:place_picker/entities/location_result.dart';

class BloodDonorController extends GetxController {
  final selectedBloodDonorGroupItem = 0.obs;
  final selectedGender = 0.obs;
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

  Rx<LocationResult> locationResult = LocationResult().obs;
  var iAmOver18 = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeSelectedBloodDonorGroupItem(int i) {
    selectedBloodDonorGroupItem.value = i;
  }

  bool isThisTheSelectedOne(int thisIndex) {
    return thisIndex == selectedBloodDonorGroupItem.value;
  }

  bool canSave() {
    return iAmOver18.value && locationResult()?.locality != null;
  }

  void save() async {
    EasyLoading.show(status: "please_wait".tr);

    try {
      var result = await BloodDonorRepository().updateBloodDonorProfile(
          selectGroup[selectedBloodDonorGroupItem()],
          locationResult(),
          selectedGender());
      // BloodDonorUpdateResponseModel bloodDonorUpdateResponseModel =
      //     BloodDonorUpdateResponseModel.fromJson(result.data);
      Get.back();
      AppGetDialog.showSuccess(middleText: "done".tr, onTap: () => Get.back());

      EasyLoading.dismiss();
    } catch (e, s) {
      EasyLoading.dismiss();

      DioExceptionHandler.handleException(exception: e, retryCallBak: save);
      FirebaseCrashlytics.instance.recordError(e, s);
    }
  }
}
