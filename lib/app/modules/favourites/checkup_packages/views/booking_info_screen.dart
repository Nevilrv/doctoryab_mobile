import 'package:doctor_yab/app/modules/favourites/checkup_packages/controllers/checkup_packages_controller.dart';
import 'package:doctor_yab/app/modules/favourites/checkup_packages/views/basket_detail_screen.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BookingInfoScreen extends GetView<CheckupPackagesController> {
  const BookingInfoScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: h,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 45, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    AppImages.back2,
                                    height: 14,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "other_information".tr,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyle.boldWhite20,
                                ),
                              ),
                            ),
                            Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(BasketDetailScreen());
                                  },
                                  child: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        AppImages.bag,
                                        height: 24,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  // top: -5,
                                  child: CircleAvatar(
                                    radius: 8,
                                    backgroundColor: AppColors.red2,
                                    child: Center(
                                      child: Text(
                                        "3",
                                        style: AppTextStyle.boldWhite10,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "select_hospital".tr,
                            style: AppTextStyle.boldGrey12.copyWith(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: AppColors.primary),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: w,
                        // height: 10,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: AppColors.primary.withOpacity(0.4),
                                width: 2),
                            color: AppColors.white),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 10, top: 7, bottom: 7, left: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: DropdownButton<String>(
                                  underline: SizedBox(),
                                  value: controller.selectedHospitalLab.value ??
                                      "",
                                  icon: Icon(Icons.expand_more,
                                      color:
                                          AppColors.primary.withOpacity(0.4)),
                                  isDense: true,
                                  isExpanded: true,
                                  items: controller.selectHospitalLabList
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          style: AppTextStyle.mediumPrimary12
                                              .copyWith(
                                                  color: AppColors.primary
                                                      .withOpacity(0.5))),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    controller.selectedHospitalLab.value =
                                        value;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "select_date".tr,
                            style: AppTextStyle.boldGrey12.copyWith(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: AppColors.primary),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: w,
                        // height: 10,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: AppColors.primary.withOpacity(0.4),
                                width: 2),
                            color: AppColors.white),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 10, top: 7, bottom: 7, left: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: DropdownButton<String>(
                                  underline: SizedBox(),
                                  value: controller.selectedDate.value ?? "",
                                  icon: Icon(Icons.expand_more,
                                      color:
                                          AppColors.primary.withOpacity(0.4)),
                                  isDense: true,
                                  isExpanded: true,
                                  items:
                                      controller.dateList.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          style: AppTextStyle.mediumPrimary12
                                              .copyWith(
                                                  color: AppColors.primary
                                                      .withOpacity(0.5))),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    controller.selectedDate.value = value;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "select_time".tr,
                            style: AppTextStyle.boldGrey12.copyWith(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: AppColors.primary),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: w,
                        // height: 10,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: AppColors.primary.withOpacity(0.4),
                                width: 2),
                            color: AppColors.white),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 10, top: 7, bottom: 7, left: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: DropdownButton<String>(
                                  underline: SizedBox(),
                                  value: controller.selectedTime.value ?? "",
                                  icon: Icon(Icons.expand_more,
                                      color:
                                          AppColors.primary.withOpacity(0.4)),
                                  isDense: true,
                                  isExpanded: true,
                                  items:
                                      controller.timeList.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          style: AppTextStyle.mediumPrimary12
                                              .copyWith(
                                                  color: AppColors.primary
                                                      .withOpacity(0.5))),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    controller.selectedTime.value = value;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.dialog(
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Center(
                                child: Container(
                                  width: w,
                                  // height: Get.height * 0.3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: AppColors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: h * 0.03, vertical: 10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: h * 0.01,
                                        ),
                                        SvgPicture.asset(
                                          AppImages.success,
                                          height: 230,
                                          width: 230,
                                        ),
                                        SizedBox(
                                          height: h * 0.01,
                                        ),
                                        Text(
                                          "book_success".tr,
                                          style: AppTextStyle.boldPrimary24
                                              .copyWith(
                                                  color: AppColors.green3),
                                        ),
                                        SizedBox(
                                          height: h * 0.01,
                                        ),
                                        Text(
                                          "Your booking request succesfully, check your e-mail other details!",
                                          textAlign: TextAlign.center,
                                          style: AppTextStyle.mediumBlack16
                                              .copyWith(
                                                  color: AppColors.black3,
                                                  fontSize: 15),
                                        ),
                                        SizedBox(
                                          height: h * 0.03,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.back();
                                            Get.back();
                                          },
                                          child: Container(
                                            width: w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: AppColors.primary),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 15),
                                              child: Center(
                                                  child: Text(
                                                      "back_to_checkup_list".tr,
                                                      style: AppTextStyle
                                                          .boldWhite15)),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // confirm: Text("cooo"),
                            // actions: <Widget>[Text("aooo"), Text("aooo")],
                            // cancel: Text("bla bla"),
                            // content: Text("bla bldddda"),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.teal,
                              border: Border.all(color: AppColors.teal)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 7, horizontal: 10),
                            child: Center(
                              child: Text(
                                "Confirm".tr,
                                style: AppTextTheme.b(15).copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
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
      ),
    );
  }
}
