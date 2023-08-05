import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../components/paging_indicators/dotdot_nomore_items.dart';
import '../../../components/paging_indicators/no_item_list.dart';
import '../../../components/paging_indicators/paging_error_view.dart';
import '../../../components/spacialAppBar.dart';
import '../../../data/ApiConsts.dart';
import '../../../data/models/blood_donors.dart';
import '../../../theme/AppColors.dart';
import '../../../theme/TextTheme.dart';
import '../../../utils/utils.dart';
import '../controllers/blood_donors_results_controller.dart';

class BloodDonorsResultsView extends GetView<BloodDonorsResultsController> {
  const BloodDonorsResultsView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar.specialAppBar(
        "find_blood_donor".tr,
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
            controller.fetchDonors(
              controller.pagingController.firstPageKey,
            );
          },
        ),
        child: PagedListView.separated(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 22),
          pagingController: controller.pagingController,
          // physics: BouncingScrollPhysics(),
          separatorBuilder: (c, i) {
            return SizedBox(height: 15);
          },
          builderDelegate: PagedChildBuilderDelegate<BloodDonor>(
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

  Widget _buildItemView(BuildContext context, BloodDonor item) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 7,
            blurRadius: 7,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    child: CachedNetworkImage(
                      imageUrl: "${ApiConsts.hostUrl}",
                      fit: BoxFit.cover,
                      placeholder: (_, __) {
                        return Image.asset(
                          "assets/png/person-placeholder.jpg",
                          fit: BoxFit.cover,
                        );
                      },
                      errorWidget: (_, __, ___) {
                        return Image.asset(
                          "assets/png/person-placeholder.jpg",
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ).radiusAll(20),
                ),
              ),
              Spacer(flex: 1),
              Expanded(
                flex: 9,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        item?.donorName ?? "Null",
                        style: AppTextTheme.h(15)
                            .copyWith(color: AppColors.black2),
                      ).paddingOnly(top: 8, bottom: 2),
                      Text(
                        "${'blood_group'.tr} : ${item?.bloodGroup}",
                        style:
                            AppTextTheme.b(14).copyWith(color: AppColors.lgt2),
                      ),
                      if (item?.phone != null)
                        _buildButton(
                          item,
                          icon: SvgPicture.asset("assets/svg/call-24px.svg"),
                          child: FittedBox(
                            child: Text(
                              "call".tr,
                              style: AppTextTheme.m(14)
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          bgColor: AppColors.green,
                          onTap: () =>
                              Utils.openPhoneDialer(context, "${item?.phone}"),
                        ).paddingVertical(16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ).paddingHorizontal(10),
    );
  }

  Widget _buildButton(BloodDonor item,
      {@required Widget icon,
      @required Widget child,
      void Function() onTap,
      Color bgColor}) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          SizedBox(
            width: 8,
          ),
          child,
        ],
      ),
    )
        .paddingSymmetric(horizontal: 20, vertical: 8)
        .bgColor(bgColor ?? AppColors.green)
        .radiusAll(12)
        .onTap(onTap);
  }
}
