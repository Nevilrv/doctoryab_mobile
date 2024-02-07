import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as d;

class PregnancyTrackerNewController extends GetxController {
  bool isPregnant = false;
  String type = '';
  bool openInfo = false;
  DateTime pregnancyInitialDay = DateTime.now();
  DateTime dueInitialDay = DateTime.now();
  DateTime conceptionInitialDay = DateTime.now();
  String formattedPregnancyDate =
      d.DateFormat('dd/MM/yyyy').format(DateTime.now());
  String formattedDueDate = d.DateFormat('dd/MM/yyyy').format(DateTime.now());
  String formattedConceptionDate =
      d.DateFormat('dd/MM/yyyy').format(DateTime.now());
  int weekCount = 1;

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

  Future<DateTime> showDatePicker({
    BuildContext context,
    DateTime initialDate,
    DateTime firstDate,
    DateTime lastDate,
    DateTime currentDate,
    DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
    SelectableDayPredicate selectableDayPredicate,
    String helpText,
    String cancelText,
    String confirmText,
    Locale locale,
    bool barrierDismissible = true,
    Color barrierColor,
    String barrierLabel,
    bool useRootNavigator = true,
    RouteSettings routeSettings,
    TextDirection textDirection,
    TransitionBuilder builder,
    DatePickerMode initialDatePickerMode = DatePickerMode.day,
    String errorFormatText,
    String errorInvalidText,
    String fieldHintText,
    String fieldLabelText,
    TextInputType keyboardType,
    Offset anchorPoint,
    final ValueChanged<DatePickerEntryMode> onDatePickerModeChange,
    final Icon switchToInputEntryModeIcon,
    final Icon switchToCalendarEntryModeIcon,
  }) async {
    initialDate = initialDate == null ? null : DateUtils.dateOnly(initialDate);
    firstDate = DateUtils.dateOnly(firstDate);
    lastDate = DateUtils.dateOnly(lastDate);
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
    assert(debugCheckHasMaterialLocalizations(context));

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
        context: context,
        locale: locale,
        child: dialog,
      );
    }

    return showDialog<DateTime>(
      context: context,
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
