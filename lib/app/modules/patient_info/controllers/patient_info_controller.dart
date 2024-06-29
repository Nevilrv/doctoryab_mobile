import 'package:doctor_yab/app/controllers/booking_controller.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/modules/home/controllers/tab_meeting_time_controller.dart';
import 'package:doctor_yab/app/utils/AppGetDialog.dart';
import 'package:doctor_yab/app/utils/PhoneNumberValidator.dart';
import 'package:doctor_yab/app/utils/exception_handler/DioExceptionHandler.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:intl/intl.dart';
import '../../../data/repository/DoctorsRepository.dart';

class PatientInfoController extends GetxController {
  var doctor = BookingController.to.selectedDoctor;
  final formKey = GlobalKey<FormState>();
  final TextEditingController teName = TextEditingController();
  final TextEditingController teAge = TextEditingController();
  final TextEditingController tePhoneNumber = TextEditingController();
  final RxBool iamIll = false.obs;
  final formValid = false.obs;
  var _patId = "";
  @override
  void onInit() {
    super.onInit();
    teName.addListener(() {
      validateForm();
    });
    teAge.addListener(() {
      validateForm();
    });
    tePhoneNumber.addListener(() {
      validateForm();
    });

    ever(iamIll, (_) {
      if (iamIll()) {
        teName.text = SettingsController.savedUserProfile?.name ?? "";
        teAge.text = SettingsController.savedUserProfile?.age.toString() ?? "";
        tePhoneNumber.text = "0" +
            SettingsController.savedUserProfile!.phone!
                .substring(3, 12)
                .toString();
        _patId = SettingsController.savedUserProfile?.patientID ?? "";
        print('_patId: ${SettingsController.savedUserProfile?.patientID}');
        formValid(true);
      } else {
        _patId = "";
        validateForm();
      }
    });
  }

  @override
  void onReady() {
    iamIll(true);
    super.onReady();
  }

  @override
  void onClose() {}

  // void bookNow() {
  //   EasyLoading.show(status: "please_wait".tr);
  //   DoctorsRepository()
  //       .bookTime(
  //     _patId,
  //     BookingController.to.selectedDoctor(),
  //     BookingController.to.selectedCategory(),
  //     teName.text,
  //     teAge.text,
  //     tePhoneNumber.text,
  //     BookingController.to.selectedDate().toUtc().toIso8601String(),
  //   )
  //       .then((value) {
  //     EasyLoading.dismiss();
  //     var response = value.data;
  //     Get.until((route) => route.isFirst);
  //     var patId = response['data']['patientId']?.toString() ?? "null";
  //     // Navigator.of(Get.context).popUntil((route) => route.isFirst);
  //     AppGetDialog.showSuccess(
  //       middleText: "done".tr +
  //           "\n\n" +
  //           "remember_pat_id_for_reference".trArgs([patId]),
  //     );
  //     //refresh history if there is any
  //     TabMeetingTimeController tabMeetingTimeController = Get.find();
  //     if (tabMeetingTimeController != null) {
  //       tabMeetingTimeController.reloadAll();
  //     }
  //   }).catchError(
  //     (e, s) {
  //       DioExceptionHandler.handleException(
  //         exception: e,
  //         retryCallBak: bookNow,
  //       );
  //       FirebaseCrashlytics.instance.recordError(e, s);
  //     },
  //   );
  // }

  //? Move to Booking controller?
  String get formatedDate {
    var _str = BookingController.to
        .selectedDate()!
        .toPersianDateStr(useAfghaniMonthName: true);

    return _str.split(" ")[0] + " " + _str.split(" ")[1];
  }

  //? Move to Booking controller?
  String get formatedTime {
    var _tmp = BookingController.to.selectedDate()!.toLocal();

    return DateFormat.jm()
        .format(_tmp)
        .toUpperCase()
        .replaceAll(RegExp(r'(AM)'), "AM".tr)
        .replaceAll(RegExp(r'(PM)'), "PM".tr);
  }

  //TODO there is multiple of this is code. replace all
  String? nameValidator(String value) {
    if (value.length < 5) {
      return "too_short_min_5".tr;
      // nameValid.value = false;
    } else if (value.length > 30) {
      return "very_long_max_30".tr;
    }
    return null;
  }

  String? ageValidatore(String value) {
    if (!value.isNum) return "not_a_valid_number".tr;

    if (int.tryParse(value)! < 0) {
      return "must_be_greater_than_zero".tr;
      // nameValid.value = false;
    }
    if (int.tryParse(value)! > 120) {
      return "must_be_less_than_120".tr;
      // nameValid.value = false;
    }
    return null;
  }

  String? numberValidator(String value) {
    PhoneValidatorUtils phoneValidatorUtils =
        PhoneValidatorUtils(number: value);
    if (phoneValidatorUtils.isValid()) {
      return null;
    }
    return phoneValidatorUtils.errorMessage;
    // phoneValidatorUtils = null;
  }

  void validateForm() {
    formValid(formKey.currentState?.validate());
    print(formKey.currentState?.validate());
  }
}
