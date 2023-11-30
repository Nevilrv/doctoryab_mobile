import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/checkupPackages_res_model.dart';
import 'package:doctor_yab/app/modules/banner/banner_view.dart';
import 'package:doctor_yab/app/modules/favourites/checkup_packages/controllers/checkup_packages_controller.dart';
import 'package:doctor_yab/app/modules/favourites/checkup_packages/views/basket_detail_screen.dart';
import 'package:doctor_yab/app/modules/favourites/checkup_packages/views/booking_info_screen.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CheckUpDetailScreen extends GetView<CheckupPackagesController> {
  Package item;
  CheckUpDetailScreen(this.item, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: h,
        child: Stack(
          children: [
            GetBuilder<CheckupPackagesController>(
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 45, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    controller.selectedTest = 0;
                                  },
                                  child: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                        child: RotatedBox(
                                      quarterTurns:
                                          SettingsController.appLanguge ==
                                                  "English"
                                              ? 0
                                              : 2,
                                      child: SvgPicture.asset(
                                        AppImages.back2,
                                        height: 14,
                                      ),
                                    )),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Text(
                                      "checkup_details".tr,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyle.boldWhite16,
                                    ),
                                  ),
                                ),
                                Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(BasketDetailScreen());
                                      },
                                      child: Container(
                                        height: 45,
                                        width: 45,
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            AppImages.history,
                                            height: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Positioned(
                                    //   right: 0,
                                    //   // top: -5,
                                    //   child: CircleAvatar(
                                    //     radius: 8,
                                    //     backgroundColor: AppColors.red2,
                                    //     child: Center(
                                    //       child: Text(
                                    //         "3",
                                    //         style: AppTextStyle.boldWhite10,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: h * 0.75,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30)),
                                child: Container(
                                  height: h * 0.2,
                                  width: w,
                                  child: CachedNetworkImage(
                                    imageUrl: "${ApiConsts.hostUrl}${item.img}",
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
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Center(
                                child: Text(
                                  item.title ?? "",
                                  style: AppTextStyle.boldBlack18.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              RichText(
                                text: new TextSpan(
                                  text: item.description ?? "",
                                  style: AppTextStyle.boldBlack12.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                                  children: <TextSpan>[
                                    // new TextSpan(
                                    //     text: item.packageInclude.length
                                    //             .toString() +
                                    //         " " +
                                    //         "Tests",
                                    //     style: AppTextStyle.boldBlack12
                                    //         .copyWith(
                                    //             fontWeight: FontWeight.bold,
                                    //             color: AppColors.teal,
                                    //             decoration:
                                    //                 TextDecoration.underline)),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: AppColors.grey3,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    AppImages.coin,
                                    height: 30,
                                    width: 30,
                                  ),
                                  Text(
                                    item.price ?? "0.0",
                                    style: AppTextTheme.b(25)
                                        .copyWith(color: AppColors.grey),
                                  ),
                                  Spacer(),
                                  item.discount == "0" || item.discount == null
                                      ? SizedBox()
                                      : Container(
                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: AppColors.red2
                                                  .withOpacity(0.1),
                                              border: Border.all(
                                                  color: AppColors.red2
                                                      .withOpacity(0.1))),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            child: Center(
                                              child: Text(
                                                "${item.discount ?? 0} ${"OFF".tr}",
                                                style:
                                                    AppTextTheme.b(15).copyWith(
                                                  color: AppColors.red2,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                  Spacer(),
                                  item.discount == "0" || item.discount == null
                                      ? SizedBox()
                                      : Row(
                                          children: [
                                            Image.asset(
                                              AppImages.coin,
                                              height: 30,
                                              width: 30,
                                            ),
                                            Text(
                                              item.rrp ?? "0.0",
                                              style: AppTextTheme.b(25)
                                                  .copyWith(
                                                      color: AppColors.grey
                                                          .withOpacity(0.5),
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      decorationColor:
                                                          Colors.red,
                                                      decorationThickness: 1),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                              Divider(
                                thickness: 1,
                                color: AppColors.grey3,
                              ),
                              // Row(
                              //   children: [
                              //     SvgPicture.asset(AppImages.calender1,
                              //         width: 24, height: 24),
                              //     SizedBox(
                              //       width: 10,
                              //     ),
                              //     Text(
                              //       "slot_available".tr,
                              //       style: AppTextStyle.mediumBlack12,
                              //     ),
                              //     Text(
                              //       " 06:00 AM, Today",
                              //       style: AppTextStyle.boldBlack12,
                              //     )
                              //   ],
                              // ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(AppImages.clock1,
                                      width: 24, height: 24),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${item.duration}",
                                    style: AppTextStyle.mediumBlack12,
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 1,
                                color: AppColors.grey3,
                              ),

                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(AppImages.arrow,
                                      width: 24, height: 24),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "sample_type".tr,
                                    style: AppTextStyle.mediumBlack12,
                                  ),
                                  Spacer(),
                                  Container(
                                    width: 5,
                                    decoration: BoxDecoration(
                                      color: AppColors.red2,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Center(
                                        child: Text(
                                          "",
                                          style: AppTextTheme.b(10).copyWith(
                                            color: AppColors.red2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: AppColors.red2.withOpacity(0.1),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Center(
                                        child: Text(
                                          "${item.sampleType ?? ""}",
                                          style: AppTextTheme.b(10).copyWith(
                                            color: AppColors.red2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(AppImages.cap,
                                      width: 24, height: 24),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "fasting_required".tr,
                                    style: AppTextStyle.mediumBlack12,
                                  ),
                                  Spacer(),
                                  Container(
                                    width: 5,
                                    decoration: BoxDecoration(
                                      color: AppColors.red2,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Center(
                                        child: Text(
                                          "",
                                          style: AppTextTheme.b(10).copyWith(
                                            color: AppColors.red2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: AppColors.red2.withOpacity(0.1),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Center(
                                        child: Text(
                                          "${item.fastingRequired ?? ""}",
                                          style: AppTextTheme.b(10).copyWith(
                                            color: AppColors.red2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              item.packageInclude.isEmpty
                                  ? SizedBox()
                                  : Row(
                                      children: [
                                        SvgPicture.asset(AppImages.box,
                                            width: 24,
                                            height: 24,
                                            color: AppColors.black6),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "pack_includes".tr,
                                          style: AppTextStyle.mediumBlack12,
                                        ),
                                        Spacer(),
                                        Container(
                                          width: 5,
                                          decoration: BoxDecoration(
                                            color: AppColors.red2,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            child: Center(
                                              child: Text(
                                                "",
                                                style:
                                                    AppTextTheme.b(10).copyWith(
                                                  color: AppColors.red2,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            buildShowModalBottomSheet(context,
                                                h, item.packageInclude);
                                          },
                                          child: Container(
                                            width: 120,
                                            decoration: BoxDecoration(
                                              color: AppColors.red2
                                                  .withOpacity(0.1),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                              child: Center(
                                                child: Text(
                                                  "show_all".tr,
                                                  style: AppTextTheme.b(10)
                                                      .copyWith(
                                                    color: AppColors.red2,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              item.packageInclude.isEmpty
                                  ? SizedBox()
                                  : SizedBox(
                                      height: 5,
                                    ),
                              item.packageInclude.isEmpty
                                  ? SizedBox()
                                  : SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: List.generate(
                                          item.packageInclude.length,
                                          (index) => Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: GestureDetector(
                                              onTap: () {
                                                controller.selectedTest = index;
                                                controller.update();
                                              },
                                              child: Container(
                                                // width: Get.width * 0.2,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: AppColors.blue,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                                  child: Center(
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.circle,
                                                          color:
                                                              AppColors.white,
                                                          size: 7,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          item
                                                              .packageInclude[
                                                                  index]
                                                              .testTitle,
                                                          style:
                                                              AppTextTheme.b(10)
                                                                  .copyWith(
                                                            color:
                                                                AppColors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                              item.packageInclude.isEmpty
                                  ? SizedBox()
                                  : Divider(
                                      thickness: 1,
                                      color: AppColors.grey3,
                                    ),
                              item.packageInclude.isEmpty
                                  ? SizedBox()
                                  : item.packageInclude[controller.selectedTest]
                                              .testDesc ==
                                          ""
                                      ? SizedBox()
                                      : Row(
                                          children: [
                                            SvgPicture.asset(
                                                AppImages.circleInfo,
                                                width: 24,
                                                height: 24,
                                                color: AppColors.black6),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "decription".tr,
                                              style: AppTextStyle.mediumBlack12,
                                            ),
                                          ],
                                        ),
                              item.packageInclude.isEmpty
                                  ? SizedBox()
                                  : item.packageInclude[controller.selectedTest]
                                              .testDesc ==
                                          ""
                                      ? SizedBox()
                                      : SizedBox(
                                          height: 5,
                                        ),
                              item.packageInclude.isEmpty
                                  ? SizedBox()
                                  : item.packageInclude[controller.selectedTest]
                                              .testDesc ==
                                          ""
                                      ? SizedBox()
                                      : Container(
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: AppColors.black6,
                                                  width: 2)),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Html(
                                                data: item
                                                        .packageInclude[
                                                            controller
                                                                .selectedTest]
                                                        .testDesc ??
                                                    "",
                                                defaultTextStyle: AppTextStyle
                                                    .boldPrimary12
                                                    .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.black6,
                                                ),
                                              ) /* ExpandableText(
                               "${item.packageInclude[controller.selectedTest].testDesc}",
                               expandText: 'Read more',
                               collapseText: 'Read less',
                               maxLines: 3,
                               linkColor: AppColors.primary,
                               style:
                               AppTextStyle.boldPrimary12.copyWith(
                                 fontWeight: FontWeight.w500,
                                 color: AppColors.black6,
                               ),
                             ),*/
                                              ),
                                        ),
                              Divider(
                                thickness: 1,
                                color: AppColors.grey3,
                              ),
                              Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        "${ApiConsts.hostUrl}${item.observerImg}",
                                    height: 10,
                                    width: 13,
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
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${item.byObservation}",
                                    style: AppTextStyle.mediumBlack12,
                                  ),
                                  // Text(
                                  //   " (Cardiology)",
                                  //   style: AppTextStyle.mediumBlack12
                                  //       .copyWith(color: AppColors.teal),
                                  // ),
                                ],
                              ),
                              Divider(
                                thickness: 1,
                                color: AppColors.grey3,
                              ),
                              // commonTitleBox(text: "comm_ratings".tr),
                              // Padding(
                              //   padding: EdgeInsets.only(top: 10, bottom: 6),
                              //   child: addCommentsTextField(),
                              // ),
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   children: [
                              //     Text(
                              //       "sel_rating".tr,
                              //       style: AppTextStyle.regularPrimary9,
                              //     ),
                              //     IntrinsicWidth(
                              //       child: Container(
                              //         padding: EdgeInsets.all(5),
                              //         margin: EdgeInsets.only(left: 4),
                              //         decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(3),
                              //           color: AppColors.lightPurple,
                              //         ),
                              //         child: RatingBar.builder(
                              //           itemSize: 15,
                              //           initialRating: controller.ratings,
                              //           // minRating: 1,
                              //           direction: Axis.horizontal,
                              //           allowHalfRating: true,
                              //           itemCount: 5,
                              //           itemPadding: EdgeInsets.symmetric(
                              //               horizontal: 1.0),
                              //           itemBuilder: (context, _) => Icon(
                              //             Icons.star,
                              //             color: Colors.amber,
                              //             // size: 10,
                              //           ),
                              //           onRatingUpdate: (rating) {
                              //             print(rating);
                              //             controller.ratings = rating;
                              //             controller.update();
                              //           },
                              //         ),
                              //       ),
                              //     ),
                              //     Spacer(),
                              //     controller.isLoadingFeedback == true
                              //         ? Padding(
                              //             padding: EdgeInsets.symmetric(
                              //                 horizontal: 23, vertical: 3),
                              //             child: Center(
                              //               child: Container(
                              //                 height: 15,
                              //                 width: 15,
                              //                 child: Center(
                              //                     child:
                              //                         CircularProgressIndicator(
                              //                             color:
                              //                                 AppColors.primary,
                              //                             strokeWidth: 2)),
                              //               ),
                              //             ),
                              //           )
                              //         : GestureDetector(
                              //             onTap: () {
                              //               if (controller
                              //                   .comment.text.isEmpty) {
                              //                 Utils.commonSnackbar(
                              //                     context: context,
                              //                     text: "please_add_review".tr);
                              //               } else {
                              //                 controller.addPackageFeedback(
                              //                     rating: controller.ratings
                              //                         .toString(),
                              //                     packageId: item.id);
                              //               }
                              //             },
                              //             child: Container(
                              //               padding: EdgeInsets.symmetric(
                              //                   horizontal: 23, vertical: 3),
                              //               decoration: BoxDecoration(
                              //                 borderRadius:
                              //                     BorderRadius.circular(3),
                              //                 color: AppColors.primary,
                              //               ),
                              //               child: Center(
                              //                 child: Text(
                              //                   "send".tr,
                              //                   style: AppTextStyle.boldWhite8,
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: 5,
                              // ),
                              // controller.isLoading == true
                              //     ? Center(
                              //         child: Container(
                              //             height: 25,
                              //             width: 25,
                              //             child: Center(
                              //                 child: CircularProgressIndicator(
                              //               color: AppColors.primary,
                              //             ))),
                              //       )
                              //     : Column(
                              //         children: List.generate(
                              //             controller.packageFeedback.length,
                              //             (index) {
                              //           return Padding(
                              //             padding:
                              //                 const EdgeInsets.only(bottom: 5),
                              //             child: Container(
                              //               padding: EdgeInsets.only(
                              //                   top: 10,
                              //                   bottom: 10,
                              //                   left: 8,
                              //                   right: 14),
                              //               decoration: BoxDecoration(
                              //                 borderRadius:
                              //                     BorderRadius.circular(6),
                              //                 border: Border.all(
                              //                     color: AppColors.lightPurple),
                              //               ),
                              //               child: Row(
                              //                 crossAxisAlignment:
                              //                     CrossAxisAlignment.start,
                              //                 children: [
                              //                   // CachedNetworkImage(
                              //                   //   imageUrl: "${ApiConsts.hostUrl}${  controller
                              //                   //       .drugFeedback[index].photo}",
                              //                   //   height: h * 0.045,
                              //                   //   width: h * 0.045,
                              //                   //   fit: BoxFit.cover,
                              //                   //   placeholder: (_, __) {
                              //                   //     return Image.asset(
                              //                   //       "assets/png/person-placeholder.jpg",
                              //                   //       fit: BoxFit.cover,
                              //                   //     );
                              //                   //   },
                              //                   //   errorWidget: (_, __, ___) {
                              //                   //     return Image.asset(
                              //                   //       "assets/png/person-placeholder.jpg",
                              //                   //       fit: BoxFit.cover,
                              //                   //     );
                              //                   //   },
                              //                   // )
                              //
                              //                   Container(
                              //                     height: h * 0.045,
                              //                     width: h * 0.045,
                              //                     margin:
                              //                         EdgeInsets.only(right: 8),
                              //                     decoration: BoxDecoration(
                              //                       shape: BoxShape.circle,
                              //                       image: DecorationImage(
                              //                         image: NetworkImage(
                              //                             "${ApiConsts.hostUrl}${controller.packageFeedback[index].photo}"),
                              //                         fit: BoxFit.cover,
                              //                       ),
                              //                     ),
                              //                   ),
                              //                   Expanded(
                              //                     child: Column(
                              //                       crossAxisAlignment:
                              //                           CrossAxisAlignment
                              //                               .start,
                              //                       children: [
                              //                         Row(
                              //                           crossAxisAlignment:
                              //                               CrossAxisAlignment
                              //                                   .start,
                              //                           children: [
                              //                             Text(
                              //                               controller
                              //                                       .packageFeedback[
                              //                                           index]
                              //                                       .whoPosted ??
                              //                                   "",
                              //                               style: AppTextStyle
                              //                                   .regularPrimary9,
                              //                             ),
                              //                             Spacer(),
                              //                             RatingBar.builder(
                              //                               ignoreGestures:
                              //                                   true,
                              //                               itemSize: 15,
                              //                               initialRating: double.parse(controller
                              //                                           .packageFeedback[
                              //                                               index]
                              //                                           .rating ==
                              //                                       null
                              //                                   ? "0"
                              //                                   : controller
                              //                                           .packageFeedback[
                              //                                               index]
                              //                                           .rating ??
                              //                                       "0.0"),
                              //                               // minRating: 1,
                              //                               direction:
                              //                                   Axis.horizontal,
                              //                               allowHalfRating:
                              //                                   true,
                              //                               itemCount: 5,
                              //                               itemPadding: EdgeInsets
                              //                                   .symmetric(
                              //                                       horizontal:
                              //                                           1.0),
                              //                               itemBuilder:
                              //                                   (context, _) =>
                              //                                       Icon(
                              //                                 Icons.star,
                              //                                 color:
                              //                                     Colors.amber,
                              //                                 // size: 10,
                              //                               ),
                              //                               onRatingUpdate:
                              //                                   (rating) {
                              //                                 print(rating);
                              //                               },
                              //                             ),
                              //                           ],
                              //                         ),
                              //                         Text(
                              //                           controller
                              //                                   .packageFeedback[
                              //                                       index]
                              //                                   .comment ??
                              //                               '',
                              //                           style: AppTextStyle
                              //                               .regularPrimary7
                              //                               .copyWith(
                              //                             color: AppColors
                              //                                 .primary
                              //                                 .withOpacity(0.6),
                              //                             height: 1.2,
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //           );
                              //         }),
                              //       ),
                              // SizedBox(height: 10),
                              // Divider(
                              //   thickness: 1,
                              //   color: AppColors.grey3,
                              // ),
                              SizedBox(
                                height: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(BookingInfoScreen(
                                    item: item,
                                  ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColors.teal,
                                      border:
                                          Border.all(color: AppColors.teal)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 7, horizontal: 10),
                                    child: Center(
                                      child: Text(
                                        "book1".tr,
                                        style: AppTextTheme.b(15).copyWith(
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 35,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: BottomBarView(
                  isHomeScreen: false,
                ))
          ],
        ),
      ),
    );
  }

  Widget commonTitleBox({
    String text,
    Color color = AppColors.lightPurple,
    Color textColor = AppColors.primary,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyle.regularPrimary10.copyWith(color: textColor),
      ),
    );
  }

  Future<void> buildShowModalBottomSheet(
      BuildContext context, double h, List<PackageInclude> item) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.72,
          child: Container(
            height: h * 0.72,
            decoration: BoxDecoration(
                color: AppColors.grey5,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 5,
                      width: 188,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.black3),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                AppImages.box,
                                height: 24,
                                width: 24,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Package Includes ${item.length} Tests",
                          style: AppTextStyle.boldPrimary15,
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(Icons.cancel_outlined,
                                  color: AppColors.primary, size: 25),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          children: List.generate(item.length, (index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Icon(
                                    Icons.circle,
                                    size: 10,
                                    color: AppColors.blue,
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      item[index].testTitle,
                                      style: AppTextStyle.boldGrey12.copyWith(
                                          color: AppColors.grey6,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: Get.width * 0.72,
                                      child: Html(
                                          data: item[index].testDesc,
                                          defaultTextStyle:
                                              AppTextStyle.boldGrey10.copyWith(
                                                  color: AppColors.grey6,
                                                  fontWeight: FontWeight.w400)),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                )
                              ],
                            );
                          }),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget addCommentsTextField() {
    return TextField(
      style: AppTextStyle.mediumPrimary8,
      cursorColor: AppColors.primary,
      maxLines: 3,
      controller: controller.comment,
      decoration: InputDecoration(
        hintText: "add_comm".tr,
        hintStyle: AppTextStyle.mediumLightPurple3_8,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: AppColors.lightPurple,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: AppColors.lightPurple,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: AppColors.lightPurple,
          ),
        ),
      ),
    );
  }
}
