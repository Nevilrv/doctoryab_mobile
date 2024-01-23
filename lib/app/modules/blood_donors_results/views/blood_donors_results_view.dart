import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:doctor_yab/app/modules/favourites/blood_donation/controller/find_blood_donor_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
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
import '../../../theme/AppImages.dart';
import '../../../theme/TextTheme.dart';
import '../../../utils/utils.dart';
import '../controllers/blood_donors_results_controller.dart';

class BloodDonorsResultsView extends GetView<BloodDonorsResultsController> {
  const BloodDonorsResultsView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Background(
      isPrimary: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppAppBar.blueAppBar(title: "donor_list".tr, bloodIcon: true),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: RefreshIndicator(
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
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: AppColors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.primary),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Center(
                              child: Text(
                                "Totally ${0} blood donor find it",
                                style: AppTextStyle.boldWhite14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: h * 0.7,
                      child: PagedListView.separated(
                        // padding:
                        //     EdgeInsets.symmetric(vertical: 30, horizontal: 22),
                        pagingController: controller.pagingController,
                        // physics: BouncingScrollPhysics(),
                        separatorBuilder: (c, i) {
                          return SizedBox(height: 15);
                        },
                        builderDelegate: PagedChildBuilderDelegate<BloodDonor>(
                          itemBuilder: (context, item, index) {
                            // var item = controller.latestVideos[index];
                            return _buildItemView(context, item, index);
                          },
                          noMoreItemsIndicatorBuilder: (_) =>
                              DotDotPagingNoMoreItems(),
                          noItemsFoundIndicatorBuilder: (_) =>
                              PagingNoItemFountList(),
                          firstPageErrorIndicatorBuilder: (context) =>
                              PagingErrorView(
                            controller: controller.pagingController,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: BottomBarView(
                isHomeScreen: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemView(BuildContext context, BloodDonor item, int index) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl:
                      "https://t4.ftcdn.net/jpg/02/60/04/09/360_F_260040900_oO6YW1sHTnKxby4GcjCvtypUCWjnQRg5.jpg",
                  fit: BoxFit.cover,
                  height: h * 0.11,
                  width: h * 0.11,
                  placeholder: (_, __) {
                    return Image.asset(
                      "assets/png/placeholder_hospital.png",
                      fit: BoxFit.cover,
                    );
                  },
                  errorWidget: (_, __, ___) {
                    return Image.asset(
                      "assets/png/placeholder_hospital.png",
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.donorName ?? "Null",
                  style: AppTextStyle.boldPrimary12,
                ),
                Row(
                  children: [
                    Text(
                      "${"blood_group".tr}:",
                      style: AppTextStyle.boldPrimary12.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColors.primary.withOpacity(0.5)),
                    ),
                    Text(
                      "${item.bloodGroup ?? "Null"}",
                      style: AppTextStyle.boldPrimary12
                          .copyWith(color: AppColors.primary.withOpacity(0.5)),
                    )
                  ],
                ),
                // SizedBox(height: 5),
                GetBuilder<FindBloodDonorController>(
                  builder: (controller) {
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (controller.selectedCheckBox.isEmpty) {
                              controller.selectedCheckBox.add(index.toString());
                            } else {
                              if (controller.selectedCheckBox
                                  .contains(index.toString())) {
                                controller.selectedCheckBox
                                    .remove(index.toString());
                              } else {
                                controller.selectedCheckBox
                                    .add(index.toString());
                              }
                            }
                            controller.update();
                          },
                          child: controller.selectedCheckBox
                                  .contains("${index.toString()}")
                              ? SvgPicture.asset(AppImages.Checkbox)
                              : SvgPicture.asset(AppImages.Checkbox1),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "select_blood_group".tr,
                          style: AppTextStyle.boldPrimary12.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.primary.withOpacity(0.5)),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () =>
                          Utils.openPhoneDialer(context, "${item?.phone}"),
                      child: Container(
                        width: w * 0.22,
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                        decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Center(
                            child: Text(
                              "call".tr,
                              style: AppTextTheme.m(12)
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   width: 10,
                    // ),
                    // GestureDetector(
                    //   onTap: () {},
                    //   child: Container(
                    //     width: w * 0.27,
                    //     padding:
                    //         EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                    //     decoration: BoxDecoration(
                    //         color: AppColors.lightBlack2,
                    //         borderRadius: BorderRadius.circular(20)),
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 15),
                    //       child: Center(
                    //         child: Text(
                    //           "appointment".tr,
                    //           style: AppTextTheme.m(12)
                    //               .copyWith(color: Colors.white),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Widget _buildItemView(BuildContext context, BloodDonor item) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 10),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(15),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(0.1),
  //           spreadRadius: 7,
  //           blurRadius: 7,
  //           offset: Offset(0, 0),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             Expanded(
  //               flex: 3,
  //               child: AspectRatio(
  //                 aspectRatio: 1,
  //                 child: Container(
  //                   child: CachedNetworkImage(
  //                     imageUrl: "${ApiConsts.hostUrl}",
  //                     fit: BoxFit.cover,
  //                     placeholder: (, _) {
  //                   return Image.asset(
  //                   "assets/png/person-placeholder.jpg",
  //                   fit: BoxFit.cover,
  //                   );
  //                   },
  //                     errorWidget: (, _, ___) {
  //                   return Image.asset(
  //                   "assets/png/person-placeholder.jpg",
  //                   fit: BoxFit.cover,
  //                   );
  //                   },
  //                   ),
  //                 ).radiusAll(20),
  //               ),
  //             ),
  //             Spacer(flex: 1),
  //             Expanded(
  //               flex: 9,
  //               child: Padding(
  //                 padding: const EdgeInsets.only(left: 8.0),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       item?.donorName ?? "Null",
  //                       style: AppTextTheme.h(15)
  //                           .copyWith(color: AppColors.black2),
  //                     ).paddingOnly(top: 8, bottom: 2),
  //                     Text(
  //                       "${'blood_group'.tr} : ${item?.bloodGroup}",
  //                       style:
  //                       AppTextTheme.b(14).copyWith(color: AppColors.lgt2),
  //                     ),
  //                     if (item?.phone != null)
  //                       _buildButton(
  //                         item,
  //                         icon: SvgPicture.asset("assets/svg/call-24px.svg"),
  //                         child: FittedBox(
  //                           child: Text(
  //                             "call".tr,
  //                             style: AppTextTheme.m(14)
  //                                 .copyWith(color: Colors.white),
  //                           ),
  //                         ),
  //                         bgColor: AppColors.green,
  //                         onTap: () =>
  //                             Utils.openPhoneDialer(context, "${item?.phone}"),
  //                       ).paddingVertical(16),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ).paddingHorizontal(10),
  //   );
  // }
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
