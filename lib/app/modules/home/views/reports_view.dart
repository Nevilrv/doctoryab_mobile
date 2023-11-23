import 'package:dio/dio.dart';
import 'package:doctor_yab/app/components/paging_indicators/dotdot_nomore_items.dart';
import 'package:doctor_yab/app/components/paging_indicators/no_item_list.dart';
import 'package:doctor_yab/app/components/paging_indicators/paging_error_view.dart';
import 'package:doctor_yab/app/data/models/reports.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:doctor_yab/app/views/views/report_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:doctor_yab/app/data/repository/ReportsRepository.dart';
import 'package:doctor_yab/app/modules/home/controllers/reports_controller.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class ReportsView extends GetView<ReportsController> {
  /*ReportsView(

  ) {
    controller = Get.put(ReportsController(), tag: reportType.toString());
    controller.reportType = reportType;
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('ReportsView'),
      //   centerTitle: true,
      // ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(
          () async {
            Utils.resetPagingController(controller.pagingController);
            await Future.delayed(Duration.zero, () {
              controller.cancelToken.cancel();
            });
            controller.cancelToken = new CancelToken();

            if (controller.tabIndex.value == 0) {
              controller.fetchReportsDoctor(
                controller.pagingController.firstPageKey,
              );
            } else {
              controller.fetchReportsLab(
                controller.pagingController.firstPageKey,
              );
            }
          },
        ),
        child: PagedListView.separated(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 22),
          pagingController: controller.pagingController,
          separatorBuilder: (c, i) {
            return Divider().paddingAll(10);
          },
          builderDelegate: PagedChildBuilderDelegate<Report>(
            itemBuilder: (context, item, index) {
              // var item = controller.latestVideos[index];
              return _buildItemView(context, item);
            },
            noMoreItemsIndicatorBuilder: (_) => DotDotPagingNoMoreItems(),
            noItemsFoundIndicatorBuilder: (_) => PagingNoItemFountList(),
            firstPageErrorIndicatorBuilder: (context) => PagingErrorView(
              controller: controller.pagingController,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemView(BuildContext context, Report item) {
    var _trailing /* = Text(
      item?.visitDate
              .toPersianDateStr(strMonth: true, useAfghaniMonthName: true) ??
          "",
    )*/
        ;
    // return Text(item.title);
    return ListTile(
      title: Text(item.title ?? ""),
      subtitle: Text("pat_name".tr + ": " + item.name ?? ""),
      trailing: (item.documents != null && item.documents.length > 0)
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(Icons.attachment), SizedBox(width: 8), _trailing],
            )
          : _trailing,
      onTap: () {
        Get.to(() => ReportView(item));
      },
    );
  }
}
