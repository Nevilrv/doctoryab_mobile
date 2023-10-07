import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/modules/home/views/favourites/disease_treatment/controller/disease_treatment_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiseaseSubDetailsView extends GetView<DiseaseTreatmentController> {
  DiseaseSubDetailsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppAppBar.primaryAppBar(title: "${Get.arguments[0]}"),
      backgroundColor: AppColors.lightGrey,
      bottomNavigationBar: BottomBarView(isHomeScreen: false),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.white,
                ),
                child: Column(
                  children: [
                    Text(
                      "Listen Whole Page (What is Virus?)",
                      style: AppTextStyle.boldPrimary11,
                    ),
                    SizedBox(height: 5),
                    Image.asset(
                      AppImages.dummyAudio,
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.white,
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: h * 0.119,
                          width: w * 0.305,
                          margin: EdgeInsets.only(right: 15),
                          decoration: BoxDecoration(
                            color: Get.arguments[1]["color"],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Image.asset(
                              Get.arguments[1]["image"],
                              height: h * 0.067,
                              width: w * 0.146,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "What is Virus?",
                                style: AppTextStyle.boldPrimary11,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "A virus is an infectious microbe consisting of a segment of nucleic acid (either DNA or RNA) surrounded by a protein coat. A virus cannot replicate alone; instead, it must infect cells and use components of the host cell to make copies of itself.",
                                style: AppTextStyle.mediumPrimary8
                                    .copyWith(height: 1.2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ...List.generate(
                      6,
                      (index) => Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "A virus is an infectious microbe consisting of a segment of nucleic acid (either DNA or RNA) surrounded by a protein coat. A virus cannot replicate alone; instead, it must infect cells and use components of the host cell to make copies of itself.",
                          style:
                              AppTextStyle.mediumPrimary8.copyWith(height: 1.2),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
