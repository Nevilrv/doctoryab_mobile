import 'package:doctor_yab/app/modules/home/views/favourites/disease_treatment/controller/disease_treatment_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiseaseTreatmentView extends GetView<DiseaseTreatmentController> {
  DiseaseTreatmentView({Key key}) : super(key: key);

  final List diseaseData = [
    {
      "image": AppImages.commonDiseases,
      "title": "com_diseases".tr,
      "color": AppColors.boxPurple
    },
    {
      "image": AppImages.healthCare,
      "title": "health_care".tr,
      "color": AppColors.boxRed
    },
    {
      "image": AppImages.viruses,
      "title": "viruses".tr,
      "color": AppColors.boxGreen
    },
    {
      "image": AppImages.mentalHealth,
      "title": "mental_health".tr,
      "color": AppColors.lightYellow
    },
    {
      "image": AppImages.humanHead,
      "title": "ear".tr,
      "color": AppColors.boxBlue
    },
    {
      "image": AppImages.cancer,
      "title": "cancer".tr,
      "color": AppColors.boxPink
    },
    {
      "image": AppImages.poison,
      "title": "infection".tr,
      "color": AppColors.boxGreen2
    },
    {
      "image": AppImages.injuries,
      "title": "injuries".tr,
      "color": AppColors.boxGreen3
    },
    {
      "image": AppImages.pregnancy,
      "title": "pregnancy".tr,
      "color": AppColors.boxYellow
    },
    {
      "image": AppImages.eyes,
      "title": "eyes".tr,
      "color": AppColors.boxPurple2
    },
    {
      "image": AppImages.muscles,
      "title": "muscles".tr,
      "color": AppColors.boxPink2
    },
    {
      "image": AppImages.nails,
      "title": "skins".tr,
      "color": AppColors.boxYellow2
    },
    {
      "image": AppImages.stomach,
      "title": "stomach".tr,
      "color": AppColors.boxYellow3
    },
    {
      "image": AppImages.immuneSystem,
      "title": "immune".tr,
      "color": AppColors.boxPink3
    },
    {
      "image": AppImages.glands,
      "title": "glands".tr,
      "color": AppColors.boxBlue2
    },
    {
      "image": AppImages.kidney,
      "title": "kidney".tr,
      "color": AppColors.boxPurple3
    },
  ];

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: Utils.appBar(title: "all_diseases".tr),
      backgroundColor: AppColors.lightGrey,
      bottomNavigationBar: BottomBarView(isHomeScreen: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
          itemCount: diseaseData.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(top: 18),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(Routes.DISEASE_DETAILS,
                    arguments: diseaseData[index]);
              },
              child: Container(
                padding: EdgeInsets.all(11).copyWith(bottom: 0),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: h * 0.108,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: diseaseData[index]["color"],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Image.asset(
                          diseaseData[index]["image"],
                          height: 52,
                          width: 52,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          diseaseData[index]["title"].toString().tr,
                          style:
                              AppTextStyle.boldPrimary12.copyWith(height: 1.2),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
