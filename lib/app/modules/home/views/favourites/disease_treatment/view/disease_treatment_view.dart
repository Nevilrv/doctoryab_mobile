import 'package:doctor_yab/app/modules/home/views/favourites/disease_treatment/controller/disease_treatment_controller.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiseaseTreatmentView extends GetView<DiseaseTreatmentController> {
  DiseaseTreatmentView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Utils.appBar("all_diseases".tr),
          ],
        ),
      ),
    );
  }
}
