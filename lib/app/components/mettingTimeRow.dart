import 'package:doctor_yab/app/components/dateSquare.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:persian_number_utility/persian_number_utility.dart'; //import

class MeetingTimeRow extends StatelessWidget {
  final DateTime date;
  final String docName;
  final bool isActive;
  const MeetingTimeRow({
    Key key,
    this.date,
    this.docName,
    this.isActive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List<String> parsedDate = date
    //     .toPersianDateStr(showDayStr: true, useAfghaniMonthName: true)
    //     .split(' ');

    return Row(
      // mainAxisSize: MainAxisSize.min,
      children: [
        DateSquare(
          date: date,
          color: isActive ? null : AppColors.lgt,
        ),
        SizedBox(
          width: 17,
        ),
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Text(
                  docName,
                  style: AppTextTheme.h(16).copyWith(
                    color: isActive ? null : AppColors.lgt,
                  ),
                ),
              ),
              Text(
                DateFormat.jm()
                    .format(date)
                    .replaceAll(RegExp(r'(AM)'), "AM".tr)
                    .replaceAll(RegExp(r'(PM)'), "PM".tr),
                style: AppTextTheme.m(14).copyWith(
                  color: isActive ? null : AppColors.lgt,
                ),
              )
            ],
          ),
        ),
      ],
    ).paddingOnly(top: 20);
  }
}
