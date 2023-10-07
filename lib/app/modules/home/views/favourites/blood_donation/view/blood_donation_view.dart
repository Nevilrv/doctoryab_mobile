import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/modules/home/views/favourites/blood_donation/controller/blood_donation_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BloodDonationView extends GetView<BloodDonationController> {
  BloodDonationView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      bottomNavigationBar: BottomBarView(isHomeScreen: false),
      appBar: AppAppBar.primaryAppBar(title: "blood_donation".tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            2,
            (index) => GestureDetector(
              onTap: () {
                index == 0
                    ? Get.toNamed(Routes.BLOOD_DONOR)
                    : Get.toNamed(Routes.FIND_BLOOD_DONOR);
              },
              child: Container(
                height: h * 0.194,
                width: w * 0.421,
                padding: EdgeInsets.symmetric(horizontal: 13, vertical: 10)
                    .copyWith(bottom: 0),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: h * 0.120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: index == 0
                            ? AppColors.lightRed
                            : AppColors.lightBlue3,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Image.asset(
                          AppImages.blood,
                          height: h * 0.084,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35),
                        child: Center(
                          child: Text(
                            index == 0 ? "donor".tr : "find_donor".tr,
                            style:
                                AppTextStyle.boldBlack13.copyWith(height: 1.2),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
