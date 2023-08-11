import 'package:dio/dio.dart';
import 'package:doctor_yab/app/components/NewItems.dart';
import 'package:doctor_yab/app/data/models/drug_stores_model.dart';
import 'package:doctor_yab/app/data/models/labs_model.dart';
import 'package:doctor_yab/app/modules/drug_store_lab/views/drug_store_lab_view.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/controllers/tab_home_drugstore_controller.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/views/tab_home_others_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/extentions/widget_exts.dart';

class TabHomeDrugstoreView
    extends TabHomeOthersView<DrugStoreController, DrugStore> {
  @override
  bool get pageHas24Hours => true;
  @override
  Widget buildItem(c, it, i) {
    int _calculateWekday(DateTime d) {
      return d.weekday == 7 ? 0 : d.weekday;
    }

   debugPrint((DateTime(2021, 7, 30).weekday).toString() + " weakday-now");

    return NewItems(
      // is24Hour: i % 2 == 0,
      is24Hour:
          it.the24Hours?.contains(_calculateWekday(DateTime.now())) ?? false,
      title: it.name,
      address: it.address,
      phoneNumber: (it.phone?.length ?? 0) > 0 ? it.phone[0] : null,
      imagePath: it.photo,
      latLng: it.geometry.coordinates,
    ).onTap(() {
      Get.to(() => DrugStoreLabView(
          Labs.fromJson(it.toJson()), DRUG_STORE_LAB_PAGE_TYPE.drugstore));
      // Get.to(() => DoctorsView(
      //       action: DOCTORS_LOAD_ACTION.ofhospital,
      //       hospitalId: it.id ?? "",
      //       hospitalName: it.name,
      //     ));
    });
  }
}
