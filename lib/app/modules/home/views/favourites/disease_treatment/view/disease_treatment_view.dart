import 'package:doctor_yab/app/modules/home/views/favourites/disease_treatment/controller/disease_treatment_controller.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiseaseTreatmentView extends GetView<DiseaseTreatmentController> {
  DiseaseTreatmentView({Key key}) : super(key: key);

  final List diseaseData = [
    {"image": AppImages.commonDiseases, "title": "com_diseases".tr},
    {"image": AppImages.healthCare, "title": "health_care".tr},
    {"image": AppImages.viruses, "title": "viruses".tr},
    {"image": AppImages.mentalHealth, "title": "mental_health".tr},
    {"image": AppImages.humanHead, "title": "ear".tr},
    {"image": AppImages.cancer, "title": "cancer".tr},
    {"image": AppImages.poison, "title": "infection".tr},
    {"image": AppImages.injuries, "title": "injuries".tr},
    {"image": AppImages.pregnancy, "title": "pregnancy".tr},
    {"image": AppImages.eyes, "title": "eyes".tr},
    {"image": AppImages.muscles, "title": "muscles".tr},
    {"image": AppImages.nails, "title": "skins".tr},
    {"image": AppImages.stomach, "title": "stomach".tr},
    {"image": AppImages.immuneSystem, "title": "immune".tr},
    {"image": AppImages.glands, "title": "glands".tr},
    {"image": AppImages.kidney, "title": "kidney".tr},
  ];

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
