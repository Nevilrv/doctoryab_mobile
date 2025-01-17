import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/models/pregnancy_details_model.dart';
import 'package:doctor_yab/app/data/repository/PregnancyTrackerRepository.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as d;
import 'package:logger/logger.dart';
import 'package:shamsi_date/shamsi_date.dart';

class PregnancyTrackerNewController extends GetxController {
  CancelToken cancelToken = CancelToken();
  bool isPregnant = false;
  String type = "";
  bool openInfo = false;
  DateTime pregnancyInitialDay = DateTime.now();
  DateTime dueInitialDay = DateTime.now();
  DateTime conceptionInitialDay = DateTime.now();

  // String conceptionInitialDay = '';
  String formattedPregnancyDate = SettingsController.appLanguge == 'English'
      ? d.DateFormat('dd-MM-yyyy').format(DateTime.now())
      : /*${DateTime.now().toJalali().formatter.wN}, */ '${DateTime.now().toJalali().formatter.yyyy}-${DateTime.now().toJalali().formatter.mm}-${DateTime.now().toJalali().formatter.d}';

  String formattedDueDate = SettingsController.appLanguge == 'English'
      ? d.DateFormat('dd/MM/yyyy').format(DateTime.now())
      : /*${DateTime.now().toJalali().formatter.wN}, */ '${DateTime.now().toJalali().formatter.yyyy}-${DateTime.now().toJalali().formatter.mm}-${DateTime.now().toJalali().formatter.d}';
  String formattedConceptionDate = SettingsController.appLanguge == 'English'
      ? d.DateFormat('dd/MM/yyyy').format(DateTime.now())
      : /*${DateTime.now().toJalali().formatter.wN},*/ '${DateTime.now().toJalali().formatter.yyyy}-${DateTime.now().toJalali().formatter.mm}-${DateTime.now().toJalali().formatter.d}';
  int weekCount = 0;

  changeBool(bool value) {
    isPregnant = value;
    update();
  }

  changeCalculationType(String value) {
    type = value;

    update();
  }

  incrementTrimster() {
    weekCount++;
    update();
  }

  decrementTrimster() {
    weekCount--;
    update();
  }

  @override
  void onInit() {
    type = Get.arguments == null ? "" : Get.arguments['type'];
    update();
    if (Get.arguments == null) {
      checkPregnancy();
    }

    super.onInit();
  }

  /// API INTEGRATION ----------------------------------------------------------

  bool isLoading = false;
  List<PtModule> ptModules = [];
  PregnancyData? pregnancyData;
  bool isSaved = false;
  bool isRecalculate = true;
  void checkPregnancy() {
    isLoading = true;
    update();

    PregnancyTrackerRepo()
        .checkPregnancy(cancelToken: cancelToken)
        .then((value) async {
      if (value.data != null) {
        if (value.isSaved == true) {
          Get.offAndToNamed(Routes.PREGNANCY_TRIMSTER);
        }

        pregnancyData = value.data;

        pregnancyData!.ptModules?.sort(
          (a, b) => a.week!.compareTo(b.week!),
        );

        pregnancyData!.ptModules!.forEach((element) {
          if (element.week == value.data!.currentWeek) {
            weekCount = value.data!.ptModules!.indexWhere(
                (element) => element.week == value.data!.currentWeek);
          }
        });
      }
      isLoading = false;
      update();
    }).catchError((e, s) {
      isLoading = false;
      update();
      Logger().e("message", e, s);
      Future.delayed(Duration(seconds: 3), () {
        // if (this != null) checkPregnancy();
      });
    });
  }

  void pregnancyCalculation({Map<String, dynamic>? body}) {
    isLoading = true;
    update();
    PregnancyTrackerRepo()
        .calculateDate(body: body, cancelToken: cancelToken)
        .then((value) async {
      if (value.data != null) {
        log('value ---------->>>>>>>> ${jsonEncode(value.data)}');
        pregnancyData = value.data;
        // value.data.ptModules.forEach((element) {
        //   if (element.week == value.data.currentWeek) {
        log('value ---------->>>>>>>> ${value.data!.ptModules}');
        weekCount = value.data!.ptModules!.indexWhere((element) {
          log('element -----week----->>>>>>>> ${element.week}');
          log('value.data.currentWeek ---------->>>>>>>> ${value.data!.currentWeek}');
          return element.week == value.data!.currentWeek;
        });
        // }
        // });

        isLoading = false;
        update();
      }
      isLoading = false;
      update();
    }).catchError((e, s) {
      isLoading = false;
      update();
      Logger().e("message", e, s);
      Future.delayed(Duration(seconds: 3), () {});
    });
  }

  bool isDeleteLoading = false;
  void deleteTracker({String? id, BuildContext? context}) {
    isDeleteLoading = true;
    update();
    PregnancyTrackerRepo()
        .deleteTracker(id: id, cancelToken: cancelToken)
        .then((value) async {
      isDeleteLoading = false;
      update();
    }).catchError((e, s) {
      // Get.offNamedUntil(Routes.PREGNANCY_TRACKER_NEW, (route) => false,
      //     arguments: {'type': 'LastPeriod', 'isCheck': true});

      isDeleteLoading = false;
      update();
      Logger().e("message", e, s);
      Future.delayed(Duration(seconds: 3), () {});
    });
  }

  Future<DateTime?> showDatePicker({
    BuildContext? context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? currentDate,
    DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
    SelectableDayPredicate? selectableDayPredicate,
    String? helpText,
    String? cancelText,
    String? confirmText,
    Locale? locale,
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    TextDirection? textDirection,
    TransitionBuilder? builder,
    DatePickerMode initialDatePickerMode = DatePickerMode.day,
    String? errorFormatText,
    String? errorInvalidText,
    String? fieldHintText,
    String? fieldLabelText,
    TextInputType? keyboardType,
    Offset? anchorPoint,
    final ValueChanged<DatePickerEntryMode>? onDatePickerModeChange,
    final Icon? switchToInputEntryModeIcon,
    final Icon? switchToCalendarEntryModeIcon,
  }) async {
    initialDate = initialDate == null ? null : DateUtils.dateOnly(initialDate);
    firstDate = DateUtils.dateOnly(firstDate!);
    lastDate = DateUtils.dateOnly(lastDate!);
    assert(
      !lastDate.isBefore(firstDate),
      'lastDate $lastDate must be on or after firstDate $firstDate.',
    );
    assert(
      initialDate == null || !initialDate.isBefore(firstDate),
      'initialDate $initialDate must be on or after firstDate $firstDate.',
    );
    assert(
      initialDate == null || !initialDate.isAfter(lastDate),
      'initialDate $initialDate must be on or before lastDate $lastDate.',
    );
    assert(
      selectableDayPredicate == null ||
          initialDate == null ||
          selectableDayPredicate(initialDate),
      'Provided initialDate $initialDate must satisfy provided selectableDayPredicate.',
    );
    assert(debugCheckHasMaterialLocalizations(context!));

    Widget dialog = Theme(
      data: ThemeData(
        colorScheme: ColorScheme.light(
          primary: AppColors.primary,
          onPrimary: Colors.white,
          surface: AppColors.primary,
          onSurface: AppColors.black,
        ),
      ),
      child: DatePickerDialog(
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
        currentDate: currentDate,
        initialEntryMode: initialEntryMode,
        selectableDayPredicate: selectableDayPredicate,
        helpText: helpText,
        cancelText: cancelText,
        confirmText: confirmText,
        initialCalendarMode: initialDatePickerMode,
        errorFormatText: errorFormatText,
        errorInvalidText: errorInvalidText,
        fieldHintText: fieldHintText,
        fieldLabelText: fieldLabelText,
        keyboardType: keyboardType,
        // onDatePickerModeChange: onDatePickerModeChange,
        // switchToInputEntryModeIcon: switchToInputEntryModeIcon,
        // switchToCalendarEntryModeIcon: switchToCalendarEntryModeIcon,
      ),
    );

    if (textDirection != null) {
      dialog = Directionality(
        textDirection: textDirection,
        child: dialog,
      );
    }

    if (locale != null) {
      dialog = Localizations.override(
        context: context!,
        locale: locale,
        child: dialog,
      );
    }

    return showDialog<DateTime>(
      context: context!,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      builder: (BuildContext context) {
        return builder == null ? dialog : builder(context, dialog);
      },
      anchorPoint: anchorPoint,
    );
  }
}
