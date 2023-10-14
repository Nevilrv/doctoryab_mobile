import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/modules/favourites/blood_donation/controller/find_blood_donor_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DonorListScreen extends GetView<FindBloodDonorController> {
  const DonorListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Background(
      isPrimary: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppAppBar.blueAppBar(title: "donor_list".tr, bloodIcon: true),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: AppColors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.primary),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Center(
                            child: Text(
                              "Totally 25 blood donor find it",
                              style: AppTextStyle.boldWhite14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: h * 0.7,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ...List.generate(
                              5,
                              (index) => Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      "https://t4.ftcdn.net/jpg/02/60/04/09/360_F_260040900_oO6YW1sHTnKxby4GcjCvtypUCWjnQRg5.jpg",
                                                  fit: BoxFit.cover,
                                                  width: 100,
                                                  height: 100,
                                                  placeholder: (_, __) {
                                                    return Image.asset(
                                                      "assets/png/placeholder_hospital.png",
                                                      fit: BoxFit.cover,
                                                    );
                                                  },
                                                  errorWidget: (_, __, ___) {
                                                    return Image.asset(
                                                      "assets/png/placeholder_hospital.png",
                                                      fit: BoxFit.cover,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Ahmet Muhammed",
                                                  style: AppTextStyle
                                                      .boldPrimary12,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${"blood_group".tr}:",
                                                      style: AppTextStyle
                                                          .boldPrimary12
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: AppColors
                                                                  .primary
                                                                  .withOpacity(
                                                                      0.5)),
                                                    ),
                                                    Text(
                                                      "A+",
                                                      style: AppTextStyle
                                                          .boldPrimary12
                                                          .copyWith(
                                                              color: AppColors
                                                                  .primary
                                                                  .withOpacity(
                                                                      0.5)),
                                                    )
                                                  ],
                                                ),
                                                // SizedBox(height: 5),
                                                GetBuilder<
                                                    FindBloodDonorController>(
                                                  builder: (controller) {
                                                    return Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            if (controller
                                                                .selectedCheckBox
                                                                .isEmpty) {
                                                              controller
                                                                  .selectedCheckBox
                                                                  .add(index
                                                                      .toString());
                                                            } else {
                                                              if (controller
                                                                  .selectedCheckBox
                                                                  .contains(index
                                                                      .toString())) {
                                                                controller
                                                                    .selectedCheckBox
                                                                    .remove(index
                                                                        .toString());
                                                              } else {
                                                                controller
                                                                    .selectedCheckBox
                                                                    .add(index
                                                                        .toString());
                                                              }
                                                            }
                                                            controller.update();
                                                          },
                                                          child: controller
                                                                  .selectedCheckBox
                                                                  .contains(
                                                                      "${index.toString()}")
                                                              ? SvgPicture.asset(
                                                                  AppImages
                                                                      .Checkbox)
                                                              : SvgPicture.asset(
                                                                  AppImages
                                                                      .Checkbox1),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          "select_blood_group"
                                                              .tr,
                                                          style: AppTextStyle
                                                              .boldPrimary12
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: AppColors
                                                                      .primary
                                                                      .withOpacity(
                                                                          0.5)),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                                SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {},
                                                      child: Container(
                                                        width: w * 0.22,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 5,
                                                                horizontal: 2),
                                                        decoration: BoxDecoration(
                                                            color: AppColors
                                                                .secondary,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      15),
                                                          child: Center(
                                                            child: Text(
                                                              "call".tr,
                                                              style: AppTextTheme
                                                                      .m(12)
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {},
                                                      child: Container(
                                                        width: w * 0.27,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 5,
                                                                horizontal: 2),
                                                        decoration: BoxDecoration(
                                                            color: AppColors
                                                                .lightBlack2,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      15),
                                                          child: Center(
                                                            child: Text(
                                                              "appointment".tr,
                                                              style: AppTextTheme
                                                                      .m(12)
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: BottomBarView(
                isHomeScreen: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
