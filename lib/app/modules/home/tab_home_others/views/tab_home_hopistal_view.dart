import 'package:doctor_yab/app/components/NewItems.dart';
import 'package:doctor_yab/app/data/models/HospitalsModel.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/controllers/hospitals_controller.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/views/tab_home_others_view.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/labs_model.dart';
import '../../../drug_store_lab/views/drug_store_lab_view.dart';
import '/app/extentions/widget_exts.dart';

class TabHomeHospitalsView
    extends TabHomeOthersView<HospitalsController, Hospital> {
  @override
  Widget buildItem(c, it, i) {
    return NewItems(
      // is24Hour: i % 2 == 0,
      is24Hour: false,
      title: it.name,
      address: it.address,
      phoneNumber: it.phone,
      imagePath: it.photo,
      latLng: it.geometry.coordinates,
    ).onTap(() {
      Get.toNamed(Routes.HOSPITAL_NEW, arguments: it);
      // Get.to(
      //   () => DrugStoreLabView(
      //     Labs(),
      //     DRUG_STORE_LAB_PAGE_TYPE.hospital,
      //     hospital: it,
      //   ),
      // );

      // Get.to(() => DoctorsView(
      //       action: DOCTORS_LOAD_ACTION.ofhospital,
      //       hospitalId: it.id ?? "",
      //       hospitalName: it.name,
      //     ));
      // return;
      // // Get.toNamed(Routes.DOCTORS,
      // //     arguments: [Doctor(id: it.id, fullname: it.name, name: it.name)]);
    });
  }
}
