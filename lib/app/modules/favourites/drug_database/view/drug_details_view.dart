import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/modules/favourites/drug_database/controller/drugs_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DrugDetailsView extends GetView<DrugsController> {
  DrugDetailsView({Key key}) : super(key: key);

  final List _data = [
    {"image": AppImages.medicine, "title": "drug_type", "text": "capsule"},
    {"image": AppImages.pillbox, "title": "box_cont", "text": "pack_cont"},
    {"image": AppImages.coin, "title": "price", "text": "drug_price"}
  ];

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppAppBar.primaryAppBar(title: Get.arguments),
      backgroundColor: AppColors.lightGrey,
      // bottomNavigationBar: BottomBarView(isHomeScreen: false),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.white,
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: h * 0.149,
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 14),
                      decoration: BoxDecoration(
                        color: AppColors.lightYellow,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Center(child: Image.asset(AppImages.vitamins)),
                            Positioned(
                              bottom: -8,
                              child: IntrinsicWidth(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 3),
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: AppColors.white,
                                  ),
                                  child: Row(
                                    children: List.generate(
                                      5,
                                      (subIndex) {
                                        return SvgPicture.asset(
                                          subIndex == 4
                                              ? AppImages.favGrey
                                              : AppImages.favGolden,
                                          height: 9,
                                          width: 9,
                                        ).paddingOnly(
                                            right: subIndex == 4 ? 0 : 3);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          3,
                          (index) => Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: h * 0.04,
                                width: h * 0.04,
                                padding: EdgeInsets.all(3),
                                margin: EdgeInsets.only(right: 5),
                                decoration: BoxDecoration(
                                  color: AppColors.lightPurple,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Image.asset(
                                  _data[index]["image"],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _data[index]["title"].toString().tr,
                                    style: AppTextStyle.boldPrimary9
                                        .copyWith(height: 1.2),
                                  ),
                                  Text(
                                    index == 1
                                        ? _data[1]["text"]
                                            .toString()
                                            .trArgs(["30"])
                                        : index == 2
                                            ? _data[2]["text"]
                                                .toString()
                                                .trArgs(["1000"])
                                            : _data[index]["text"]
                                                .toString()
                                                .tr,
                                    style: AppTextStyle.regularPrimary9
                                        .copyWith(height: 1),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    commonTitleBox(text: "gen_name".tr),
                    commonTextBox("VITAMIN D3 1000 IU FOOD SUPPLEMENT"),
                    commonTitleBox(
                      text: "warnings".tr,
                      color: AppColors.boxRed,
                      textColor: Colors.red,
                    ),
                    commonTextBox("Lorem Ipsum is simply dummy text."),
                    commonTitleBox(
                      text: "usage".tr,
                      color: AppColors.boxGreen3,
                      textColor: Colors.green,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "“Vitamin D contributes to the normal absorption/use of calcium and phosphorus.” “Vitamin D contributes to the maintenance of normal bones, normal muscle function and normal teeth.” “Vitamin D contributes to the normal absorption/use of calcium and phosphorus.” “Vitamin D contributes to the maintenance of normal bones, normal muscle function and normal teeth.”",
                        style: AppTextStyle.mediumPrimary10.copyWith(height: 1),
                      ),
                    ),
                    commonTitleBox(
                      text: "side_effects".tr,
                      color: AppColors.lightYellow,
                      textColor: Colors.yellow.shade700,
                    ),
                    commonTextBox("Lorem Ipsum is simply dummy text."),
                    commonTitleBox(text: "drug_type".tr),
                    commonTextBox("Lorem Ipsum is simply dummy text."),
                    commonTitleBox(text: "packaging".tr),
                    commonTextBox("Lorem Ipsum is simply dummy text."),
                    commonTitleBox(text: "dosages".tr),
                    commonTextBox("Lorem Ipsum is simply dummy text."),
                    commonTitleBox(text: "origin".tr),
                    commonTextBox("Lorem Ipsum is simply dummy text."),
                    commonTitleBox(text: "comp".tr),
                    commonTextBox("Lorem Ipsum is simply dummy text."),
                    commonTitleBox(
                      text: "price".tr,
                      color: AppColors.lightYellow,
                      textColor: Colors.yellow.shade700,
                    ),
                    commonTextBox("drug_price".trArgs(["1000"])),
                    commonTitleBox(text: "comm_ratings".tr),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 6),
                      child: addCommentsTextField(),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "sel_rating".tr,
                          style: AppTextStyle.regularPrimary9,
                        ),
                        IntrinsicWidth(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(left: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: AppColors.lightPurple,
                            ),
                            child: Row(
                              children: List.generate(
                                5,
                                (subIndex) {
                                  return SvgPicture.asset(
                                    subIndex == 0
                                        ? AppImages.favGolden
                                        : AppImages.favWhite,
                                    height: 9,
                                    width: 9,
                                  ).paddingOnly(right: subIndex == 4 ? 0 : 3);
                                },
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 23, vertical: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: AppColors.primary,
                          ),
                          child: Center(
                            child: Text(
                              "send".tr,
                              style: AppTextStyle.boldWhite8,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 8, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.lightPurple),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: h * 0.045,
                            width: h * 0.045,
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                  AppImages.dummy,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Fatih Resul Göker",
                                      style: AppTextStyle.regularPrimary9,
                                    ),
                                    Spacer(),
                                    ...List.generate(
                                      5,
                                      (subIndex) {
                                        return SvgPicture.asset(
                                          subIndex == 4
                                              ? AppImages.favGrey
                                              : AppImages.favGolden,
                                          height: 9,
                                          width: 9,
                                        ).paddingOnly(
                                            right: subIndex == 4 ? 0 : 3);
                                      },
                                    ),
                                  ],
                                ),
                                Text(
                                  "ilacı uzun süre kullandım ve gerçekten çok büyük faydaları etkilerini gördüm. Fiyatı da gayet ucuz ve uygundu. İhtiyacı olan herkesin almasını tavsiye ederim.",
                                  style: AppTextStyle.regularPrimary7.copyWith(
                                    color: AppColors.primary.withOpacity(0.6),
                                    height: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: BottomBarView(
                isHomeScreen: false,
              ))
        ],
      ),
    );
  }

  Widget commonTitleBox({
    String text,
    Color color = AppColors.lightPurple,
    Color textColor = AppColors.primary,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyle.regularPrimary10.copyWith(color: textColor),
      ),
    );
  }

  Widget commonTextBox(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 8),
            child: CircleAvatar(
              radius: 1.2,
              backgroundColor: AppColors.primary,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: AppTextStyle.boldPrimary10.copyWith(height: 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget addCommentsTextField() {
    return TextField(
      style: AppTextStyle.mediumPrimary8,
      cursorColor: AppColors.primary,
      maxLines: 3,
      decoration: InputDecoration(
        hintText: "add_comm".tr,
        hintStyle: AppTextStyle.mediumLightPurple3_8,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: AppColors.lightPurple,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: AppColors.lightPurple,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: AppColors.lightPurple,
          ),
        ),
      ),
    );
  }
}
