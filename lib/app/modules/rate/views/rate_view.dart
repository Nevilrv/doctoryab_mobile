import 'package:doctor_yab/app/components/doctor_list_tile_item.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rate_controller.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';

class RateView extends GetView<RateController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('rate'.tr),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          DoctorListTileItem(controller.doctor!)
              .paddingHorizontal(10)
              .paddingVertical(20),
          // SizedBox(height: 20),
          SizedBox(
            height: 220,
            child: PageView(
              controller: controller.pageController,
              children: controller.pages,
              physics: NeverScrollableScrollPhysics(),
            ).paddingAll(16),
          ),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() => OutlinedButton(
                  child: Text("prev".tr),
                  onPressed: controller.isButtonDeactive.value
                      ? null
                      : () {
                          print((controller.pageController.page?.toInt()));
                          // if (controller.pageController.page.toInt() < 3) {
                          controller.pageController.animateToPage(
                              (((controller.pageController.page?.toInt() ?? 0) -
                                  1)),
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                          if ((controller.pageController.page?.toInt() ?? 0) -
                                  1 ==
                              0) {
                            controller.isButtonDeactive.value =
                                (controller.pageController.page?.toInt() ?? 0) -
                                            1 ==
                                        0
                                    ? true
                                    : false;
                          }
                          controller.done.value = false;
                          // }
                        })),
              SizedBox(width: 40),
              Obx(() => OutlinedButton(
                  child: Text(
                    controller.done.value ? "submit".tr : "next".tr,
                    style: TextStyle(
                        color:
                            controller.done.value ? Colors.white : Colors.blue),
                  ),
                  style: ButtonStyle(backgroundColor:
                      MaterialStateProperty.resolveWith<Color>((state) {
                    return controller.done.value
                        ? AppColors.green
                        : AppColors.scaffoldColor;
                  })),
                  onPressed: () {
                    if (controller.pageController.page!.toInt() == 2) {
                      controller.rate(context);
                    }
                    controller.pageController.animateToPage(
                        ((controller.pageController.page!.toInt() + 1)),
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                    controller.isButtonDeactive.value = false;
                    if (controller.pageController.page!.toInt() + 1 == 2) {
                      controller.done.value = true;
                    }
                  })),
            ],
          ).paddingSymmetric(horizontal: 15, vertical: 0)
        ],
      ),
    );
  }
}
