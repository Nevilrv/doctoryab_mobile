import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../data/static.dart'; //import

class DateSquare extends StatelessWidget {
  final DateTime date;
  final Color? color;
  final int? length;

  const DateSquare({
    Key? key,
    required this.date,
    this.color,
    this.length,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> parsedDate = date
        .toPersianDateStr(showDayStr: true, useAfghaniMonthName: true)
        .split(' ');
    bool extraSpaceMode = parsedDate.length == 6;
    String month = extraSpaceMode ? parsedDate[3] : parsedDate[2];
    String day = extraSpaceMode ? parsedDate[2] : parsedDate[1];
    String dayText =
        extraSpaceMode ? parsedDate[0] + " " + parsedDate[1] : parsedDate[0];

    if (AppStatics.envVars.isUzbekApp) {
      day = date.day.toString();
      month = DateFormat("MMM").format(date);
      dayText = DateFormat("E").format(date);
    }
    return Column(
      // mainAxisSize: MainAxisSize.min,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          day.toEnglishDigit().toString(),
          style: AppTextTheme.b(24).copyWith(color: Colors.white, height: 1.0),
        ),
        SizedBox(height: 6),
        Text(
          month,
          style: AppTextTheme.b(16).copyWith(color: Colors.white, height: 1.0),
        ),
        SizedBox(height: 6),
        length != null
            ? FittedBox(
                child: Text(
                  'free_times'.trArgs([length.toString()]),
                  style: AppTextTheme.m(8).copyWith(color: Colors.white),
                ),
              )
            : Text(
                dayText,
                style: AppTextTheme.m(8).copyWith(color: Colors.white),
              ),
        SizedBox(height: 6),
      ],
    )
        .size(width: 55)
        .paddingOnly(top: 17, bottom: 0)
        .paddingHorizontal(16)
        .bgColor(color ?? AppColors.primary)
        .radiusCircular(20);
  }
}
