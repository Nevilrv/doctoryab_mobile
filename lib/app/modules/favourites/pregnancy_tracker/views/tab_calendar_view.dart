import 'package:doctor_yab/app/modules/banner/banner_view.dart';
import 'package:doctor_yab/app/modules/favourites/pregnancy_tracker/controllers/pregnancy_tracker_controller.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TabCalendarView extends GetView<PregnancyTrackerController> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(
                top: 48,
                bottom: 8,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 100, top: 17, bottom: 32),
                          child: Text(
                            "baby_growing".tr,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.boldWhite25.copyWith(height: 1),
                          ),
                        ),
                      ),
                      Container(
                        height: h * 0.0605,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Spacer(),
                              Text(
                                "Your Baby is Now",
                                style: AppTextStyle.boldPrimary14.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primary.withOpacity(0.8)),
                              ),
                              Text(
                                " 1 Month",
                                style: AppTextStyle.boldPrimary14.copyWith(
                                  fontSize: 15,
                                ),
                              ),
                              Spacer(),
                              SvgPicture.asset(
                                AppImages.circleInfo,
                                color: AppColors.primary,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: -50,
                    child: Image.asset(
                      AppImages.baby1,
                      height: h * 0.15,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.grey3)),
              child: Container(
                // width: w,
                decoration: BoxDecoration(
                    color: AppColors.teal,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Center(
                  child: Text(
                    "Stages Of Pregnancy",
                    style: AppTextStyle.boldWhite15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: h * 0.16,
              child: Row(
                children: [
                  commonMonthBox(h * 0.07, AppImages.baby1, "1_month", () {
                    commonDialog(w, h, AppImages.baby1, "1_month");
                  }),
                  Spacer(),
                  VerticalDivider(
                    thickness: 1,
                    color: AppColors.primary,
                  ),
                  Spacer(),
                  commonMonthBox(h * 0.08, AppImages.baby2, "2_month", () {
                    commonDialog(w, h, AppImages.baby2, "2_month");
                  }),
                  Spacer(),
                  VerticalDivider(
                    thickness: 1,
                    color: AppColors.primary,
                  ),
                  Spacer(),
                  commonMonthBox(h * 0.09, AppImages.baby2, "3_month", () {
                    commonDialog(w, h, AppImages.baby3, "3_month");
                  }),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            commonButton(
              w,
              "1_trimaster",
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1,
              color: AppColors.grey3,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: h * 0.18,
              child: Row(
                children: [
                  commonMonthBox(h * 0.1, AppImages.baby4, "4_month", () {
                    commonDialog(w, h, AppImages.baby4, "4_month");
                  }),
                  Spacer(),
                  VerticalDivider(
                    thickness: 1,
                    color: AppColors.primary,
                  ),
                  Spacer(),
                  commonMonthBox(h * 0.11, AppImages.baby5, "5_month", () {
                    commonDialog(w, h, AppImages.baby5, "5_month");
                  }),
                  Spacer(),
                  VerticalDivider(
                    thickness: 1,
                    color: AppColors.primary,
                  ),
                  Spacer(),
                  commonMonthBox(h * 0.12, AppImages.baby6, "6_month", () {
                    commonDialog(w, h, AppImages.baby6, "6_month");
                  }),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            commonButton(w, "2_trimaster"),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1,
              color: AppColors.grey3,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: h * 0.19,
              child: Row(
                children: [
                  commonMonthBox(h * 0.12, AppImages.baby7, "7_month", () {
                    commonDialog(w, h, AppImages.baby7, "7_month");
                  }),
                  Spacer(),
                  VerticalDivider(
                    thickness: 1,
                    color: AppColors.primary,
                  ),
                  Spacer(),
                  commonMonthBox(h * 0.13, AppImages.baby8, "8_month", () {
                    commonDialog(w, h, AppImages.baby8, "8_month");
                  }),
                  Spacer(),
                  VerticalDivider(
                    thickness: 1,
                    color: AppColors.primary,
                  ),
                  Spacer(),
                  commonMonthBox(h * 0.135, AppImages.baby9, "9_month", () {
                    commonDialog(w, h, AppImages.baby9, "9_month");
                  }),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            commonButton(w, "3_trimaster"),
            SizedBox(
              height: 10,
            ),
            Container(
              width: w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.yellow3),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Center(
                    child: Text(
                        "${"1_trimaster".tr} - (18/03/2023 - 16/06/2023)",
                        style: AppTextStyle.boldWhite15)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.pink),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Center(
                    child: Text(
                        "${"2_trimaster".tr} - (17/06/2023 - 15/09/2023)",
                        style: AppTextStyle.boldWhite15)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.orange),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Center(
                    child: Text(
                        "${"3_trimaster".tr} - (16/10/2023 - 23/12/2023)",
                        style: AppTextStyle.boldWhite15)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            BannerView(),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  void commonDialog(double w, double h, String image, String title) {
    Get.dialog(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Container(
            width: w,
            // height: Get.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.white,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: h * 0.03, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: h * 0.01,
                  ),
                  Image.asset(
                    image,
                    height: h * 0.15,
                  ),
                  SizedBox(
                    height: h * 0.01,
                  ),
                  Text(
                    "${"your_baby_is".tr} ${"$title".tr}!",
                    style: AppTextStyle.boldPrimary24,
                  ),
                  SizedBox(
                    height: h * 0.01,
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean at ligula nisi. Aenean in urna aliquet, maximus turpis eget, blandit urna. Vestibulum nec lacus nec mi scelerisque faucibus. In dictum eget mi in rhoncus. Cras imperdiet lacus eu egestas feugiat. Cras purus nunc, convallis quis risus vitae, sagittis sollicitudin risus. Integer fermentum placerat enim quis molestie. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed iaculis aliquet metus eu imperdiet.",
                    style: AppTextStyle.mediumBlack16
                        .copyWith(color: AppColors.black3, fontSize: 15),
                  ),
                  SizedBox(
                    height: h * 0.03,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.primary),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Center(
                            child: Text("back_to_calendar".tr,
                                style: AppTextStyle.boldWhite15)),
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
  }

  Container commonButton(double w, String title) {
    return Container(
      width: w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: AppColors.primary),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child:
            Center(child: Text("$title".tr, style: AppTextStyle.boldWhite15)),
      ),
    );
  }

  Column commonMonthBox(
      double h, String image, String title, Function() onTap) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: h,
          child: Center(child: Image.asset(image)),
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.primary),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
              child: Text("$title".tr, style: AppTextStyle.boldWhite15),
            ),
          ),
        )
      ],
    );
  }
}
