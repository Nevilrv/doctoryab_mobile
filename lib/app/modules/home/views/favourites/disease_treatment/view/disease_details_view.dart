import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/modules/home/views/favourites/disease_treatment/controller/disease_treatment_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DiseaseDetailsView extends GetView<DiseaseTreatmentController> {
  DiseaseDetailsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppAppBar.primaryAppBar(title: "${Get.arguments["title"]}".tr),
      backgroundColor: AppColors.lightGrey,
      bottomNavigationBar: BottomBarView(isHomeScreen: false),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                height: h * 0.154,
                margin: EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(AppImages.adBanner),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 23, bottom: 15),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.white,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: h * 0.119,
                      width: w * 0.305,
                      margin: EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        color: Get.arguments["color"],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Image.asset(
                          Get.arguments["image"],
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
              ),
              ...List.generate(
                5,
                (index) => GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.DISEASE_SUB_DETAILS,
                        arguments: ["Category ${index + 1}", Get.arguments]);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    margin: EdgeInsets.only(bottom: 7),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 34,
                          width: 34,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.grey.withOpacity(0.1),
                          ),
                        ),
                        Text(
                          "Category ${index + 1}",
                          style: AppTextStyle.boldPrimary11,
                        ),
                        Spacer(),
                        RotatedBox(
                          quarterTurns: 2,
                          child: SvgPicture.asset(
                            AppImages.back,
                            height: 13,
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
