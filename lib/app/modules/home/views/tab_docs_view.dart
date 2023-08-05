import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/data/repository/ReportsRepository.dart';
import 'package:doctor_yab/app/modules/home/views/reports_view.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:get/get.dart';

class TabDocsView extends GetView {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          // appBar: AppBar(
          //   title: Text('TabDocsView'),
          //   centerTitle: true,
          // ),
          appBar: AppAppBar.specialAppBar(
            "reports".tr,
            showLeading: false,
            bottom: TabBar(
              indicatorColor: AppColors.green,
              indicatorSize: TabBarIndicatorSize.tab,
              // indicator: BoxDecoration(border: RoundedRectangleBorder()),
              tabs: [
                Text("doctor_rerports".tr).paddingAll(10),
                Text("lab_reports".tr).paddingAll(10),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ReportsView(REPORT_TYPE.doctor),
              ReportsView(REPORT_TYPE.lab),
            ],
          )),
    );
  }
}
