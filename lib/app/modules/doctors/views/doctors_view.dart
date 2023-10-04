import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:doctor_yab/app/components/paging_indicators/dotdot_nomore_items.dart';
import 'package:doctor_yab/app/components/paging_indicators/no_item_list.dart';
import 'package:doctor_yab/app/components/paging_indicators/paging_error_view.dart';
import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/controllers/booking_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/doctors_model.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/AppGetDialog.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../controllers/doctors_controller.dart';

class DoctorsView extends StatelessWidget {
  DoctorsController controller;
  String hospitalId;
  String hospitalName;
  final bool hideAppbar;
  final Color bgColor;
  // final bool loadMyDoctorsMode;
  DOCTORS_LOAD_ACTION action;
  DoctorsView({
    this.action = DOCTORS_LOAD_ACTION.fromCategory,
    this.hospitalId,
    this.hospitalName,
    this.hideAppbar = false,
    this.bgColor,
  }) {
    controller =
        Get.put(DoctorsController(), tag: "doctors_controller_$action");
    controller.action = action;
    controller.filterList = [
      'most_rated'.tr,
      'suggested'.tr,
      'nearest'.tr,
      'A-Z'
    ];
    if (action != null && action == DOCTORS_LOAD_ACTION.ofhospital) {
      controller.filterList = ['most_rated'.tr, 'A-Z'];
    }
    try {
      controller.selectedSort =
          controller.filterList[controller.filterList.indexOf('suggested'.tr)];
    } catch (e) {
      controller.selectedSort =
          controller.filterList[controller.filterList.indexOf('most_rated'.tr)];
    }
    controller.hospitalId = hospitalId;
  }
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    // assert(Get.arguments is CategoryBridge && controller.arguments.sId != null);
    return Scaffold(
        appBar: hideAppbar
            ? null
            : AppAppBar.specialAppBar(() {
                switch (action) {
                  case DOCTORS_LOAD_ACTION.fromCategory:
                    {
                      return "doctors_of"
                          .trArgs([controller?.category()?.title]);
                    }
                  case DOCTORS_LOAD_ACTION.myDoctors:
                    {
                      return "my_doctors".tr;
                    }
                  case DOCTORS_LOAD_ACTION.ofhospital:
                    {
                      return hospitalName ?? "";
                    }
                }
              }(),
                showLeading: Navigator.of(context).canPop(),
                action: controller.action != DOCTORS_LOAD_ACTION.myDoctors
                    ? IconButton(
                        onPressed: () {
                          AppGetDialog.showFilterDialog(
                            controller.filterList,
                            controller.selectedSort,
                            filterCallBack: (i) => controller.changeSort(i),
                          );
                        },
                        icon: Icon(AntDesign.filter),
                      )
                    : null),
        // body: _buildItemView(DoctorBridge()),
        body: RefreshIndicator(
          onRefresh: () => Future.sync(
            () async {
              Utils.resetPagingController(controller.pagingController);
              await Future.delayed(Duration.zero, () {
                controller.cancelToken.cancel();
              });
              controller.cancelToken = new CancelToken();
              controller.fetchDoctors(
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
            builderDelegate: PagedChildBuilderDelegate<Doctor>(
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
        ).bgColor(bgColor),
        bottomNavigationBar: BottomBarView(
          isHomeScreen: false,
        ));
  }

  Widget _buildItemView(BuildContext context, Doctor item) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      // height: 220,
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
        children: [
          // Container(
          //   height: h * 0.2,
          //   width: w,
          //   child: Row(
          //     children: [
          //       Expanded(
          //         flex: 2,
          //         child: Container(
          //           // color: Colors.black,
          //           // height: 65,
          //           // width: 65,
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(10),
          //               color: AppColors.lightGrey),
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: CachedNetworkImage(
          //               imageUrl: "${ApiConsts.hostUrl}${item.photo}",
          //               fit: BoxFit.cover,
          //               placeholder: (_, __) {
          //                 return Image.asset(
          //                   "assets/png/person-placeholder.jpg",
          //                   fit: BoxFit.cover,
          //                 );
          //               },
          //               errorWidget: (_, __, ___) {
          //                 return Image.asset(
          //                   "assets/png/person-placeholder.jpg",
          //                   fit: BoxFit.cover,
          //                 );
          //               },
          //             ),
          //           ),
          //         ),
          //       ),
          //       Expanded(
          //         flex: 3,
          //         child: Column(
          //           children: [
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               mainAxisSize: MainAxisSize.min,
          //               children: [
          //                 Flexible(
          //                   child: Text(
          //                     item.fullname ??
          //                         " ${item.name ?? ""} ${item.lname ?? ""}",
          //                     style: AppTextTheme.h(15)
          //                         .copyWith(color: AppColors.black2),
          //                   ),
          //                 ),
          //                 if (item.verfied ?? false)
          //                   Icon(
          //                     Icons.verified,
          //                     color: AppColors.verified,
          //                   ).paddingHorizontal(6),
          //               ],
          //             )
          //           ],
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          ListTile(
              leading: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  // color: Colors.black,
                  // height: 65,
                  // width: 65,
                  child: CachedNetworkImage(
                    imageUrl: "${ApiConsts.hostUrl}${item.photo}",
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
                //   Image.network(
                //     "${ApiConsts.hostUrl}${item.photo}",
                //     fit: BoxFit.cover,
                //   ),
                // ).radiusAll(20),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      item.fullname ??
                          " ${item.name ?? ""} ${item.lname ?? ""}",
                      style:
                          AppTextTheme.h(15).copyWith(color: AppColors.black2),
                    ),
                  ),
                  if (item.verfied ?? false)
                    Icon(
                      Icons.verified,
                      color: AppColors.verified,
                    ).paddingHorizontal(6),
                ],
              ).paddingOnly(top: 8, bottom: 2),

              // Text(
              //   "${item.name ?? ""} ${item.lname ?? ""}",
              //   style: AppTextTheme.h(15).copyWith(color: AppColors.black2),
              // ).paddingOnly(top: 8),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.category.title ?? "",
                    style: AppTextTheme.b(14).copyWith(color: AppColors.lgt2),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RatingBar.builder(
                        ignoreGestures: true,
                        itemSize: 15,
                        initialRating: item.stars.toDouble(),
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
                      SizedBox(width: 4),
                      Text(
                        '(${double.tryParse(item.totalStar?.toStringAsFixed(1)) ?? ""})',
                        style: AppTextTheme.b(10.5)
                            .copyWith(color: AppColors.lgt2),
                      ),
                    ],
                  ),
                  if (item.address != null)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset("assets/svg/location_pin.svg")
                            .paddingOnly(top: 4),
                        SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            item.address ?? "",
                            maxLines: 3,
                            style: AppTextTheme.b(14)
                                .copyWith(color: AppColors.lgt2),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ).paddingVertical(8).onTap(() {
                      if (item.geometry?.coordinates !=
                          null) if (item.geometry.coordinates.length > 1) {
                        Utils.openGoogleMaps(item.geometry.coordinates[1],
                            item.geometry.coordinates[0]);
                      }
                    }),
                ],
              ),
              onTap: () => Get.toNamed(Routes.DOCTOR, arguments: [item])),
          SizedBox(height: 30),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildButton(
                item,
                icon: SvgPicture.asset("assets/svg/call-24px.svg"),
                child: FittedBox(
                  child: Text(
                    "call".tr,
                    style: AppTextTheme.m(14).copyWith(color: Colors.white),
                  ),
                ),
                bgColor: AppColors.green,
                onTap: () => Utils.openPhoneDialer(context, item.phone),

                //  () {
                //   final Uri _emailLaunchUri = Uri(
                //     scheme: 'tel',
                //     path: item.phone,
                //   );
                //   launch(_emailLaunchUri.toString())
                //       .onError((error, stackTrace) {
                //     //TODO Not tested
                //     ScaffoldMessenger.of(Get.context).showSnackBar(
                //       SnackBar(
                //         content: Text(
                //           error.toString(),
                //         ),
                //       ),
                //     );

                //     return;
                //   });
                // },
              ),
              _buildButton(
                item,
                icon: SvgPicture.asset("assets/svg/date_range-24px.svg"),
                child: FittedBox(
                  child: Text(
                    "book_now".tr,
                    style: AppTextTheme.m(14).copyWith(color: Colors.white),
                  ),
                ),
                bgColor: AppColors.easternBlue,
                onTap:
                    // loadMyDoctorsMode
                    //     ? () {
                    //         if (item.id == null || item.category == null) {
                    //           // AppGetDialog.show(
                    //           //     middleText: "doctor_id_or_category_is_null".tr);

                    //           AppGetDialog.showSeleceDoctorCategoryDialog(item,
                    //               onChange: (cat) {
                    //             BookingController.to.selectedDoctor(item);
                    //             BookingController.to.selectedCategory(cat);
                    //             Get.toNamed(
                    //               Routes.BOOK,
                    //               // arguments: [item, controller.arguments.cCategory],
                    //             );
                    //           });
                    //           return;
                    //         }
                    //         BookingController.to.selectedDoctor(item);
                    //         BookingController.to
                    //             .selectedCategory(Category(id: item.category));
                    //         Get.toNamed(
                    //           Routes.BOOK,
                    //           // arguments: [item.doctor, controller.arguments.cCategory],
                    //         );
                    //         //
                    //         // AppGetDialog.showSeleceDoctorCategoryDialog(item,
                    //         //     onChange: (cat) {
                    //         //   BookingController.to.selectedDoctor(item);
                    //         //   BookingController.to.selectedCategory(cat);
                    //         //   Get.toNamed(
                    //         //     Routes.BOOK,
                    //         //     // arguments: [item, controller.arguments.cCategory],
                    //         //   );
                    //         // });
                    //       }
                    // :
                    () {
                  BookingController.to.selectedDoctor(item);
                  Get.toNamed(
                    Routes.BOOK,
                    // arguments: [item, controller.arguments.cCategory],
                  );
                },
              ),
            ],
          ).paddingHorizontal(10),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildButton(Doctor item,
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
