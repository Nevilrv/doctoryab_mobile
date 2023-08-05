import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/reviews_model.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:doctor_yab/app/modules/hospital_new/controllers/hospital_new_controller.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jiffy/jiffy.dart';

import '../../../components/paging_indicators/dotdot_nomore_items.dart';
import '../../../components/paging_indicators/no_item_list.dart';
import '../../../components/paging_indicators/paging_error_view.dart';
import '../../../theme/AppColors.dart';
import '../../../theme/TextTheme.dart';

class HospitalReviewsView extends GetView<HospitalNewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () => Future.sync(
          () async {
            controller.reviewsCount(0);
            Utils.resetPagingController(controller.reviewsPagingController);
            await Future.delayed(Duration.zero, () {
              controller.reviewsCancelToken.cancel();
            });
            controller.reviewsCancelToken = new CancelToken();
            controller.fetchReviews(
              controller.reviewsPagingController.firstPageKey,
            );
          },
        ),
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.fromLTRB(30, 22, 30, 0),
              sliver: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "patients_reviews".tr,
                    style:
                        AppTextTheme.b(16).copyWith(color: AppColors.primary),
                  ),
                  SizedBox(width: 20),
                  Obx(() => Text(
                        "reviews_count"
                            .trArgs([controller.reviewsCount().toString()]),
                        style: AppTextTheme.l(14).copyWith(),
                      )),
                ],
              ).sliverBox,
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(30, 22, 30, 0),
              sliver: PagedSliverList.separated(
                pagingController: controller.reviewsPagingController,
                // physics: BouncingScrollPhysics(),
                separatorBuilder: (c, i) {
                  return SizedBox(
                    height: 15,
                    child: Divider(),
                  );
                },
                builderDelegate: PagedChildBuilderDelegate<Review>(
                  itemBuilder: (context, item, index) {
                    // var item = controller.latestVideos[index];
                    return _buildItemView(context, item);
                  },
                  noMoreItemsIndicatorBuilder: (_) => DotDotPagingNoMoreItems(),
                  noItemsFoundIndicatorBuilder: (_) => PagingNoItemFountList(),
                  firstPageErrorIndicatorBuilder: (context) => PagingErrorView(
                    controller: controller.reviewsPagingController,
                  ),
                ),
              ),
            ),
          ],
        ),
      ).bgColor(Colors.white),
    );
  }

  Widget _buildItemView(BuildContext context, Review item) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "User name",
              style: AppTextTheme.b(16).copyWith(color: AppColors.black2),
            ),
            SizedBox(width: 20),
            Text(
              Jiffy().format("d/MM/yyyy"),
              style: AppTextTheme.l(14).copyWith(),
            ),
          ],
        ),
        Text(
          "visited_by".trArgs([item.name ?? ""]),
          style: AppTextTheme.l(14).copyWith(),
        ),
        RatingBar.builder(
          ignoreGestures: true,
          itemSize: 15,
          initialRating:
              double.tryParse(item.docTotalRating?.toStringAsFixed(1)) ?? 0.0,
          // minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
            // size: 10,
          ),
          onRatingUpdate: (rating) {
            print(rating);
          },
        ),
        Text(
          "Hello there is no Comment in Api so i am adding this till Mr Asad Ali fixes this.",
          style: AppTextTheme.l(14).copyWith(),
        ),
      ],
    );
  }
}
