import 'package:dio/dio.dart';
import 'package:doctor_yab/app/components/mettingTimeRow.dart';
import 'package:doctor_yab/app/components/paging_indicators/dotdot_nomore_items.dart';
import 'package:doctor_yab/app/components/paging_indicators/no_item_list.dart';
import 'package:doctor_yab/app/components/paging_indicators/paging_error_view.dart';
import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/data/models/histories.dart';
import 'package:doctor_yab/app/modules/home/controllers/tab_meeting_time_controller.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TabMeetingTimeView extends GetView<TabMeetingTimeController> {
  @override
  Widget build(BuildContext context) {
    // Get.put(TabMeetingTimeController());
    return Scaffold(
      appBar: AppAppBar.specialAppBar(
        'checkup_time'.tr,
        showLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(
          () async {
            Utils.resetPagingController(controller.pagingController);
            await Future.delayed(Duration.zero, () {
              controller.cancelToken.cancel();
            });
            controller.cancelToken = new CancelToken();
            controller.fetchHistory(
              controller.pagingController.firstPageKey,
            );
          },
        ),
        child: PagedListView.separated(
          pagingController: controller.pagingController,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 30),
          separatorBuilder: (c, i) {
            return SizedBox(
              height: 20,
              child: Divider(
                thickness: 1.5,
              ),
            );
          },
          builderDelegate: PagedChildBuilderDelegate<History>(
            itemBuilder: (context, item, index) {
              // var item = controller.latestVideos[index];
              return _buildItemView(context, item, index).onTap(() {
                if (item.doctor!.length > 0)
                  Get.toNamed(Routes.HISTORY_DETAILS, arguments: item);
              });
            },
            noMoreItemsIndicatorBuilder: (_) => DotDotPagingNoMoreItems(),
            noItemsFoundIndicatorBuilder: (_) => PagingNoItemFountList(),
            firstPageErrorIndicatorBuilder: (context) => PagingErrorView(
              controller: controller.pagingController,
            ),
          ),
        ).paddingHorizontal(40),
      ),
    );
  }

  Widget _buildItemView(BuildContext context, History item, int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        () {
          bool isFutre = item.visitDate!.compareTo(DateTime.now()) >= 0;
          if (isFutre && controller.firstFutureItemIndex == null ||
              (controller.firstFutureItemIndex != null &&
                  controller.firstFutureItemIndex == index)) {
            controller.firstFutureItemIndex = index;
            return Text(
              'future_checkup_time'.tr,
              style: AppTextTheme.m(18),
            );
          }
          if (!isFutre && controller.firstPastItemIndex == null ||
              (controller.firstPastItemIndex != null &&
                  controller.firstPastItemIndex == index)) {
            controller.firstPastItemIndex = index;
            return Text(
              'past_checkup_time'.tr,
              style: AppTextTheme.m(18).copyWith(height: 1.0),
            ).paddingOnly(top: 30, bottom: 15);
          }
          return SizedBox();
        }(),
        MeetingTimeRow(
          date: item.visitDate!.toLocal(),
          docName:
              item.doctor!.length > 0 ? item.doctor![0]?.fullname ?? "" : "",
          isActive: !(controller.firstPastItemIndex != null &&
              index >= controller.firstPastItemIndex!),
        ),
      ],
    );
  }
}
