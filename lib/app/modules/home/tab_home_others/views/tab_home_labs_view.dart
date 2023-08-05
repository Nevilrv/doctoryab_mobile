import 'package:doctor_yab/app/components/NewItems.dart';
import 'package:doctor_yab/app/data/models/labs_model.dart';
import 'package:doctor_yab/app/modules/drug_store_lab/views/drug_store_lab_view.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/controllers/tab_home_labs_controller.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/views/tab_home_others_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/extentions/widget_exts.dart';

class TabHomeLabsView extends TabHomeOthersView<LabsController, Labs> {
  @override
  Widget buildItem(c, it, i) {
    return NewItems(
      // is24Hour: i % 2 == 0,
      is24Hour: false,
      title: it.name,
      address: it.address,
      phoneNumber: (it.phone?.length ?? 0) > 0 ? it.phone[0] : null,
      imagePath: it.photo,
      latLng: it.geometry.coordinates,
    ).onTap(() {
      Get.to(() => DrugStoreLabView(it, DRUG_STORE_LAB_PAGE_TYPE.lab));
      // Get.to(() => DoctorsView(
      //       action: DOCTORS_LOAD_ACTION.ofhospital,
      //       hospitalId: it.id ?? "",
      //       hospitalName: it.name,
      //     ));
      // return;
      // Get.toNamed(Routes.DOCTORS,
      //     arguments: [Doctor(id: it.id, fullname: it.name, name: it.name)]);
    });
  }
}
