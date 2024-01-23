import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:doctor_yab/app/modules/doctors/views/doctors_view.dart';
import 'package:doctor_yab/app/modules/hospital_new/controllers/hospital_new_controller.dart';
import 'package:doctor_yab/app/modules/hospital_new/views/services_list.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../doctors/controllers/doctors_controller.dart';

class TabMainView extends GetView<HospitalNewController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: () {
        var _int = 1;
        if (controller.showTab(1)) _int++;
        if (controller.showTab(3)) _int++;

        return _int;
      }(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
            labelColor: AppColors.black2,
            unselectedLabelColor: AppColors.lgt,
            isScrollable: true,
            tabs: [
              Text("doctors".tr).paddingVertical(8),
              if (controller.showTab(1)) Text("services_list".tr),
              // Text("reviews".tr),
              if (controller.showTab(3)) Text("about".tr),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DoctorsView(
              action: DOCTORS_LOAD_ACTION.ofhospital,
              hospitalId: "3",
              hideAppbar: true,
              bgColor: Colors.white,
            ),
            if (controller.showTab(1)) HospitalServicesList(),
            // HospitalReviewsView(),
            if (controller.showTab(3))
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller.hospital.description != null &&
                        controller.hospital.description != "")
                      Text(
                        "about".tr,
                        style: AppTextTheme.b(16)
                            .copyWith(color: AppColors.primary),
                      ),
                    SizedBox(height: 10),
                    Text(
                      controller.hospital.description,
                      style: AppTextTheme.l(14).copyWith(),
                    ),
                  ],
                ).paddingAll(16),
              ),
          ],
        ).bgColor(Colors.white),
      ),
    );
  }
}
