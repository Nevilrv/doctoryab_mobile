import 'package:doctor_yab/app/components/doctor_list_tile_item.dart';
import 'package:doctor_yab/app/components/paging_indicators/dotdot_nomore_items.dart';
import 'package:doctor_yab/app/components/paging_indicators/no_item_list.dart';
import 'package:doctor_yab/app/components/paging_indicators/paging_error_view.dart';
import 'package:doctor_yab/app/components/shimmer/doctor_listtile_shimmer.dart';
import 'package:doctor_yab/app/data/models/doctors_model.dart';
import 'package:doctor_yab/app/modules/doctors/controllers/doctors_controller.dart';
import 'package:doctor_yab/app/modules/doctors/views/doctors_view.dart';
import 'package:doctor_yab/app/modules/home/controllers/tab_search_controller.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TabSearchView extends GetView<TabSearchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Obx(
        () => Container(
          child: controller.firstSearchInit()
              ? PagedListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  physics: BouncingScrollPhysics(),
                  pagingController: controller.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Doctor>(
                    itemBuilder: (context, item, index) {
                      // var item = controller.latestVideos[index];
                      return DoctorListTileItem(
                        item,
                        onTap: () {
                          if (item.type == 1) {
                            Get.to(() => DoctorsView(
                                  action: DOCTORS_LOAD_ACTION.ofhospital,
                                  hospitalId: item.id ?? "",
                                  hospitalName: item.name,
                                ));
                            return;
                          }
                          Get.toNamed(Routes.DOCTOR, arguments: [item]);
                        },
                        imageRadius: 100,
                      );
                    },
                    noMoreItemsIndicatorBuilder: (_) =>
                        DotDotPagingNoMoreItems(),
                    noItemsFoundIndicatorBuilder: (_) =>
                        PagingNoItemFountList(),
                    firstPageErrorIndicatorBuilder: (context) =>
                        PagingErrorView(
                      controller: controller.pagingController,
                    ),
                    firstPageProgressIndicatorBuilder: (_) =>
                        DoctorListTileShimmer(count: Get.height ~/ 110),
                    newPageProgressIndicatorBuilder: (_) =>
                        DoctorListTileShimmer(count: 2),
                  ),
                  separatorBuilder: (c, i) {
                    return Divider()
                        .paddingSymmetric(vertical: 4, horizontal: 20);
                  },
                )
              : Container(),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Directionality(
        textDirection: Directionality.of(context),
        child: TextField(
          // key: Key('SearchBarTextField'),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: "search_hint".tr,
            hintStyle: TextStyle(
              color: AppColors.lgt,
            ),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
          ),
          onChanged: (s) => controller.filterName(s),
          autofocus: true,
          controller: controller.teSearchController,
        ),
      ),
      actions: <Widget>[
        // Show an icon if clear is not active, so there's no ripple on tap
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            if (controller.teSearchController.text.isEmpty)
              Get.focusScope.unfocus();
            controller.teSearchController.clear();
            controller.firstSearchInit(false);
          },
          color: AppColors.lgt2,
        ),
      ],
      backgroundColor: AppColors.scaffoldColor,
    );
  }

  // Widget _buildItem(Doctor doctor) {
  //   return Column(
  //     children: [
  //       ListTile(
  //         onTap: () {
  //           Get.toNamed(Routes.DOCTOR, arguments: [doctor]);
  //         },
  //         leading: AspectRatio(
  //           aspectRatio: 1,
  //           child: Transform.scale(
  //             scale: 1.09,
  //             child: Container(
  //               color: Colors.black,
  //               // height: 65,
  //               // width: 65,
  //               child: Image.network(
  //                 "${ApiConsts.hostUrl}${doctor.photo}",
  //                 fit: BoxFit.cover,
  //               ),
  //             ).radiusAll(100),
  //           ),
  //         ),
  //         title: Text(
  //           doctor.name,
  //           style: AppTextTheme.h(15).copyWith(color: AppColors.black2),
  //         ).paddingOnly(top: 8, bottom: 2),
  //         subtitle: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               doctor.speciality ?? "",
  //               style: AppTextTheme.b(14)
  //                   .copyWith(color: AppColors.lgt2, height: 1.0),
  //             ),
  //             SizedBox(height: 2),
  //             Row(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 RatingBar.builder(
  //                   ignoreGestures: true,
  //                   itemSize: 15,
  //                   initialRating: doctor.stars,
  //                   // minRating: 1,
  //                   direction: Axis.horizontal,
  //                   allowHalfRating: true,
  //                   itemCount: 5,
  //                   itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
  //                   itemBuilder: (context, _) => Icon(
  //                     Icons.star,
  //                     color: Colors.amber,
  //                     // size: 10,
  //                   ),
  //                   onRatingUpdate: (rating) {
  //                     print(rating);
  //                   },
  //                 ),
  //                 SizedBox(width: 4),
  //                 Text(
  //                   '(${doctor.totalStar})',
  //                   style: AppTextTheme.b(10.5).copyWith(color: AppColors.lgt2),
  //                 ),
  //               ],
  //             ),
  //             SizedBox(height: 8),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

}
