import 'dart:convert';

import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/data/static.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/history_details_controller.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class HistoryDetailsView extends GetView<HistoryDetailsController> {
  @override
  Widget build(BuildContext context) {
    debugPrint(controller.item.createAt);
    return Scaffold(
        appBar: AppAppBar.specialAppBar("visit_info".tr),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (controller.item.visited)
                Column(
                  children: [
                    Obx(() => RatingBar.builder(
                          ignoreGestures: true,
                          itemSize: 16,
                          initialRating: controller.currentRate(),
                          // minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                            // size: 10,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        )),
                    SizedBox(height: 10),
                    OutlinedButton(
                      onPressed: () async {
                        var args = jsonEncode({
                          "doctor":
                              jsonEncode(controller.item.doctor[0]?.toJson()),
                          "pid": controller.item.id,
                        });
                        var rate =
                            await Get.toNamed(Routes.RATE, arguments: args);
                        if (rate != null && rate is double)
                          controller.currentRate(rate);
                      },
                      child: Text("rate".tr),
                    ),
                    SizedBox(height: 10),
                    Divider(),
                    SizedBox(height: 20),
                    Row(),
                  ],
                ),
              _buildSection(
                "time_info".tr,
                [
                  {
                    "visit_date".tr: () {
                      var _d = controller.item.visitDate?.toLocal();
                      if (_d != null) {
                        if (AppStatics.envVars.isUzbekApp && _d != null)
                          return DateFormat.yMEd().format(_d);
                        else
                          return _d.toPersianDateStr(
                            strDay: false,
                            strMonth: true,
                            useAfghaniMonthName: true,
                          );
                      }
                      return "INVALID DATE";
                    }()
                  },
                  {
                    "visited_by_doctor".tr: controller.item.visited != null
                        ? controller.item.visited
                            ? "yes".tr
                            : "no".tr
                        : "null"
                  },
                  {
                    "date_reserved".tr: () {
                      var _d = DateTime.fromMillisecondsSinceEpoch(
                              int.tryParse(controller.item.createAt))
                          ?.toLocal();
                      if (_d != null) {
                        if (AppStatics.envVars.isUzbekApp && _d != null)
                          return DateFormat.yMEd().format(_d);
                        else
                          return _d.toPersianDateStr(
                            strDay: false,
                            strMonth: true,
                            useAfghaniMonthName: true,
                          );
                      }
                      return "INVALID DATE";
                    }()
                  },
                ],
              ),
              _buildSection(
                "patient_info".tr,
                [
                  {"pat_id".tr: '${controller.item.patientId}'},
                  {"pat_name".tr: '${controller.item.name}'},
                  {"pat_phone".tr: '${controller.item.phone}'},
                  {"pat_age".tr: '${controller.item.age}'},
                ],
              ),
              _buildSection(
                "doctor_info".trArgs(
                    [Utils.getTextOfBlaBla(controller.item.doctor[0]?.type)]),
                [
                  {
                    "doctor_name".trArgs([
                      Utils.getTextOfBlaBla(controller.item.doctor[0]?.type)
                    ]): '${controller.item.doctor[0]?.name}'
                  },
                  if (controller.item.doctor[0]?.type == 1) //is user
                    {
                      "doctor_speciality".trArgs([
                        Utils.getTextOfBlaBla(controller.item.doctor[0]?.type)
                      ]): '${controller.item.doctor[0]?.speciality}'
                    },
                  {
                    "doctor_phone".trArgs([
                      Utils.getTextOfBlaBla(controller.item.doctor[0]?.type)
                    ]): '${controller.item.doctor[0]?.phone}'
                  },
                  {
                    "doctor_address".trArgs([
                      Utils.getTextOfBlaBla(controller.item.doctor[0]?.type)
                    ]): '${controller.item.doctor[0]?.address}'
                  },
                ],
              ),
            ],
          ).paddingAll(20),
        ));
  }

  Widget _buildSection(String title, List<Map<String, String>> values) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
        () {
          final List<Widget> _result = <Widget>[];
          values.forEach((element) {
            _result.add(
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    element.keys.first,
                    style: AppTextTheme.r(15).copyWith(),
                  ),
                  SizedBox(height: 0),
                  // Spacer(),
                  Text(
                    element.values.first,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: AppTextTheme.l(14).copyWith(),
                  ),
                  Row(),
                ],
              ).paddingExceptBottom(20),
            );
          });
          if (_result.length > 0)
            return Column(
              children: _result,
            );

          return SizedBox();
        }(),
        SizedBox(height: 10),
        Divider(),
      ],
    ).paddingOnly(bottom: 30);
  }
}
