import 'package:doctor_yab/app/modules/favourites/pregnancy_tracker_new/controller/pregnancy_controller.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VaccinateBaby extends GetView<PregnancyTrackerNewController> {
  VaccinateBaby({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: GetBuilder<PregnancyTrackerNewController>(
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: h * 0.12,
                width: w,
                color: AppColors.primary,
                padding: EdgeInsets.only(
                    left: w * 0.04, right: w * 0.04, top: h * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RotatedBox(
                      quarterTurns: 2,
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Image.asset(
                          AppImages.arrowImage,
                          color: AppColors.white,
                          height: h * 0.03,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Vaccinate your baby',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.home,
                      color: AppColors.white,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: h * 0.02),
                          child: Center(
                            child: Text(
                              'Vaccinate your baby',
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        Image.asset(
                          AppImages.vaccinate,
                          height: h * 0.27,
                        ),
                        Container(
                          height: h * 0.058,
                          width: w,
                          color: Color(0xffACB02B),
                          margin: EdgeInsets.symmetric(vertical: h * 0.025),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: w * 0.05, vertical: h * 0.013),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      AppImages.calender,
                                      color: AppColors.white,
                                    ),
                                    SizedBox(
                                      width: w * 0.03,
                                    ),
                                    Text(
                                      'AGE',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Recommended Vaccines',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 3, left: 3),
                                      child: GestureDetector(
                                        onTap: () {
                                          controller.openInfo = true;
                                          controller.update();
                                        },
                                        child: Icon(
                                          Icons.info_outline,
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w * 0.035),
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: 14,
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.zero,
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: h * 0.02),
                                itemBuilder: (context, index) => Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        '12 months',
                                        style: TextStyle(
                                            color: AppColors.primary,
                                            fontSize: 16),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: CircleAvatar(
                                        radius: 16,
                                        backgroundColor: Color(0xffED8226),
                                        child: RotatedBox(
                                            quarterTurns: 2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 3),
                                              child: Image.asset(
                                                  AppImages.injection),
                                            )),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(left: w * 0.05),
                                        child: Text(
                                          'Hepatits B',
                                          style: TextStyle(
                                              color: AppColors.primary,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        )
                      ],
                    ),
                    controller.openInfo == true
                        ? Padding(
                            padding: EdgeInsets.only(top: h * 0.022),
                            child: Stack(
                              children: [
                                Container(
                                  height: h * 0.7,
                                  width: w,
                                  margin: EdgeInsets.only(
                                      top: h * 0.08,
                                      left: w * 0.04,
                                      right: w * 0.04),
                                  padding: EdgeInsets.only(
                                      top: h * 0.04,
                                      left: w * 0.05,
                                      right: w * 0.05),
                                  decoration: BoxDecoration(
                                    color: Color(0xffE8E8E8),
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      color: Color(0xff595959),
                                      width: 2,
                                    ),
                                  ),
                                  child: Text(
                                      'معرفی مختصر واکسین ه معرفی مختصر واکسین ها! معرفی مختصر واکسین ها!معرفی مختصر واکسین ها!معرفی مختصر واکسین ها!'),
                                ),
                                Container(
                                  height: h * 0.047,
                                  width: w * 0.47,
                                  margin: EdgeInsets.only(
                                      top: h * 0.058, left: w * 0.16),
                                  decoration: BoxDecoration(
                                    color: Color(0xff0097b2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'About Vaccination',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.openInfo = false;
                                      controller.update();
                                    },
                                    child: Container(
                                      height: h * 0.04,
                                      width: w * 0.1,
                                      margin: EdgeInsets.only(
                                        top: h * 0.081,
                                        right: w * 0.028,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xffED6B4D),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Color(0xff595959), width: 3),
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        color: Color(0xff595959),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
