import 'package:doctor_yab/app/components/buttons/custom_rounded_button.dart';
import 'package:doctor_yab/app/components/dateSquare.dart';
import 'package:doctor_yab/app/components/paging_indicators/no_item_list.dart';
import 'package:doctor_yab/app/components/paging_indicators/paging_error_view.dart';
import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/controllers/booking_controller.dart';
import 'package:doctor_yab/app/data/models/schedule_model.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../controllers/book_controller.dart';

class BookView extends GetView<BookController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar.specialAppBar("book".tr),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                // height: 160,
                // TODO make it better using some utils func
                height: controller.hasError.value
                    ? MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom
                    : 160,
                width: Get.width,
                child: Center(
                  child: PagedListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 22),
                    pagingController: controller.pagingController,
                    separatorBuilder: (c, i) {
                      return SizedBox(width: 30);
                    },
                    builderDelegate: PagedChildBuilderDelegate<ScheduleData>(
                        itemBuilder: (context, item, index) {
                          // var item = controller.latestVideos[index];

                          return Obx(
                            () => DateSquare(
                              length: item.times.length,
                              date: item.date,
                              color: controller.selectedDate() ==
                                      item.date.toIso8601String()
                                  ? Get.theme.primaryColor
                                  : Get.theme.primaryColor.withOpacity(0.15),
                            ).onTap(
                              () {
                                controller.changeSlectedDate(item.date, index);
                              },
                            ),
                          );
                        },
                        //TODO URGENT Change bellow with shimmer and so on
                        // noMoreItemsIndicatorBuilder: (_) => PagingNoMoreItemList(),
                        noItemsFoundIndicatorBuilder: (_) => PagingNoItemFountList(
                            title: "doctor_has_not_empty_slots"
                                .trArgs([controller.doctor()?.fullname ?? ""]),
                            subTitle:
                                "all_doctor_appointments_free_slots_are_full"
                                    .tr),
                        firstPageErrorIndicatorBuilder: (context) =>
                            PagingErrorView(
                              controller: controller.pagingController,
                            ),
                        firstPageProgressIndicatorBuilder: (_) {
                          return Center(child: CircularProgressIndicator());
                        }),
                  ),
                ),
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: controller.dateChilds() ?? <Widget>[Container()],
              ).paddingHorizontal(30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        child: Hero(
          tag: "bot_but",
          child: Center(
            child: Obx(() => CustomRoundedButton(
                  color: AppColors.easternBlue,
                  textColor: Colors.white,
                  splashColor: Colors.white.withOpacity(0.2),
                  disabledColor: AppColors.easternBlue.withOpacity(0.2),
                  // height: 50,
                  width: 250,
                  text: "next".tr,
                  onTap: controller.isTimePicked()
                      ? () {
                          BookingController.to.selectedDate(
                              DateTime.tryParse(controller.selectedTime()));
                          Get.toNamed(Routes.PATIENT_INFO);
                        }
                      : null,
                )),
          ),
        ),
      ).paddingOnly(bottom: 20, top: 8),
    );
  }
}
