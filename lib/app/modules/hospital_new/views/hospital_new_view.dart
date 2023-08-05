import 'package:doctor_yab/app/components/profile_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../components/spacialAppBar.dart';
import '../controllers/hospital_new_controller.dart';
import '../tab_main/views/tab_main_view.dart';

class HospitalNewView extends GetView<HospitalNewController> {
// class HospitalNewView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar.specialAppBar("${controller.hospital.name ?? ""}"),
      body: ProfileViewNew(
        address: controller.hospital.address,
        photo: controller.hospital.photo,
        star: controller.hospital.stars,
        geometry: controller.hospital.geometry,
        name: controller.hospital.name,
        phoneNumbers: [controller.hospital.phone],
        numberOfusersRated: controller.hospital.usersStaredCount,
        child: TabMainView(),
      ),
    );
  }
}
