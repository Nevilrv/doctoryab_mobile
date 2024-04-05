import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/components/profile_view.dart';
import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/labs_model.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/controllers/tab_home_drugstore_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class LabDetailScreen extends GetView<DrugStoreLabController> {
  Labs item;
  LabDetailScreen({
    Key key,
    this.item,
  }) : super(key: key);
  List tab = ["services_list".tr, "reviews".tr];
// class HospitalNewView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Background(
      isSecond: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppAppBar.specialAppBar(
          "labratories".tr,
          backgroundColor: Colors.transparent,
          // action: Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: GestureDetector(
          //       onTap: () {
          //         Get.toNamed(Routes.NOTIFICATION);
          //       },
          //       child: SvgPicture.asset(AppImages.blackBell)),
          // ),
        ),

        body: Obx(() {
          return Stack(
            children: [
              ProfileViewNew(
                address: item.address,
                reviewTitle: "laboratories_reviews",
                photo: "${ApiConsts.hostUrl}${item.photo}",
                star: double.parse(item.averageRatings == null
                    ? "0"
                    : item.averageRatings.toString()),
                geometry: item.geometry,
                name: item.name ?? "",
                phoneNumbers: item.phone[0],
                numberOfusersRated:
                    item.totalFeedbacks == 0 ? 0 : item.totalFeedbacks,
                reviewFunction: () {
                  controller.tabIndex.value = 1;
                },
                child: Column(
                  children: [
                    Row(
                      children: List.generate(
                          tab.length,
                          (index) => Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.tabIndex.value = index;
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color:
                                              controller.tabIndex.value != index
                                                  ? AppColors.white
                                                  : AppColors.primary,
                                          border: Border.all(
                                              color: AppColors.primary)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 8),
                                        child: Center(
                                          child: Container(
                                              width: w * 0.3,
                                              child: Center(
                                                  child: Text(
                                                tab[index],
                                                style: controller
                                                            .tabIndex.value !=
                                                        index
                                                    ? AppTextStyle.boldPrimary10
                                                    : AppTextStyle.boldWhite10,
                                              ))),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                    ),
                    controller.tabIndex.value == 0
                        ? Container(
                            height: h * 0.495,
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.only(top: 10),
                              child: item.checkUp.isEmpty
                                  ? Center(
                                      child: Padding(
                                      padding: EdgeInsets.only(
                                          top: Get.height * 0.2),
                                      child: Text("no_result_found".tr),
                                    ))
                                  : Column(
                                      children: [
                                        ...List.generate(
                                            item.checkUp.length,
                                            (index) => GestureDetector(
                                                  onTap: () {
                                                    Get.dialog(
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 30),
                                                        child: Center(
                                                          child: Container(
                                                            // height: Get.height * 0.3,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: AppColors
                                                                  .white,
                                                            ),
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20,
                                                                  vertical: 10),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                            20,
                                                                        width:
                                                                            20,
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          Get.back();
                                                                        },
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .cancel_outlined,
                                                                          color:
                                                                              AppColors.primary,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Text(
                                                                    "${item.checkUp[index].title ?? ""}",
                                                                    style: AppTextStyle
                                                                        .boldBlack13,
                                                                  ),
                                                                  Text(
                                                                    "${item.checkUp[index].content ?? ""}" ??
                                                                        "",
                                                                    style: AppTextStyle
                                                                        .boldBlack13
                                                                        .copyWith(
                                                                            fontWeight:
                                                                                FontWeight.w400),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "${item.checkUp[index].title ?? ""}",
                                                              style: AppTextStyle
                                                                  .boldPrimary12,
                                                            ),
                                                            Container(
                                                              width: Get.width *
                                                                  0.6,
                                                              child: Text(
                                                                "${item.checkUp[index].content ?? ""}",
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: AppTextStyle
                                                                    .boldPrimary11
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .primary
                                                                            .withOpacity(0.5)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Spacer(),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: AppColors
                                                                  .primary,
                                                              border: Border.all(
                                                                  color: AppColors
                                                                      .primary)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical: 5,
                                                                    horizontal:
                                                                        10),
                                                            child: Center(
                                                              child: Text(
                                                                "${item.checkUp[index].price} ${"afn".tr}",
                                                                style: AppTextStyle
                                                                    .boldWhite12,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ))
                                      ],
                                    ),
                            ),
                          )
                        : Container(
                            height: h * 0.495,
                            child: Padding(
                              padding: EdgeInsets.only(top: h * 0.015),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.dialog(
                                        StatefulBuilder(
                                          builder:
                                              (context, StateSetter setStates) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30),
                                              child: Center(
                                                child: Container(
                                                  // height: Get.height * 0.3,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: AppColors.white,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20,
                                                        vertical: 10),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          "add_review".tr,
                                                          style: AppTextStyle
                                                              .boldPrimary16,
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextField(
                                                          cursorColor:
                                                              AppColors.primary,
                                                          controller: controller
                                                              .comment,
                                                          style: AppTextTheme.b(
                                                                  12)
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .primary
                                                                      .withOpacity(
                                                                          0.5)),
                                                          decoration: InputDecoration(
                                                              labelText:
                                                                  "comment".tr,
                                                              floatingLabelBehavior:
                                                                  FloatingLabelBehavior
                                                                      .always,
                                                              labelStyle: AppTextTheme.b(12).copyWith(
                                                                  color: AppColors
                                                                      .primary
                                                                      .withOpacity(
                                                                          0.5)),
                                                              enabledBorder: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          4),
                                                                  borderSide: BorderSide(
                                                                      color: AppColors
                                                                          .primary
                                                                          .withOpacity(0.4),
                                                                      width: 2)),
                                                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: AppColors.primary.withOpacity(0.4), width: 2))),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              "Quality of Service"
                                                                  .tr,
                                                              style: AppTextStyle
                                                                  .boldPrimary12,
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            RatingBar.builder(
                                                              itemSize:
                                                                  Get.width *
                                                                      0.06,
                                                              initialRating:
                                                                  controller
                                                                      .sRating
                                                                      .value,
                                                              // minRating: 1,
                                                              direction: Axis
                                                                  .horizontal,
                                                              allowHalfRating:
                                                                  true,
                                                              itemCount: 5,
                                                              itemPadding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          1.0),
                                                              itemBuilder:
                                                                  (context,
                                                                          _) =>
                                                                      Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber,
                                                                // size: 10,
                                                              ),
                                                              onRatingUpdate:
                                                                  (rating) {
                                                                controller
                                                                        .sRating
                                                                        .value =
                                                                    rating;
                                                                controller
                                                                    .update();
                                                                setStates(
                                                                    () {});
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              "Price of Lab Tests"
                                                                  .tr,
                                                              style: AppTextStyle
                                                                  .boldPrimary12,
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            RatingBar.builder(
                                                              itemSize:
                                                                  Get.width *
                                                                      0.06,
                                                              initialRating:
                                                                  controller
                                                                      .eRating
                                                                      .value,
                                                              // minRating: 1,
                                                              direction: Axis
                                                                  .horizontal,
                                                              allowHalfRating:
                                                                  true,
                                                              itemCount: 5,
                                                              itemPadding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          1.0),
                                                              itemBuilder:
                                                                  (context,
                                                                          _) =>
                                                                      Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber,
                                                                // size: 10,
                                                              ),
                                                              onRatingUpdate:
                                                                  (rating) {
                                                                controller
                                                                        .eRating
                                                                        .value =
                                                                    rating;
                                                                setStates(
                                                                    () {});
                                                                print(rating);
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              "Behaviour and cleanliness"
                                                                  .tr,
                                                              style: AppTextStyle
                                                                  .boldPrimary12,
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            RatingBar.builder(
                                                              itemSize:
                                                                  Get.width *
                                                                      0.06,
                                                              initialRating:
                                                                  controller
                                                                      .cRating
                                                                      .value,
                                                              // minRating: 1,
                                                              direction: Axis
                                                                  .horizontal,
                                                              allowHalfRating:
                                                                  true,
                                                              itemCount: 5,
                                                              itemPadding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          1.0),
                                                              itemBuilder:
                                                                  (context,
                                                                          _) =>
                                                                      Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber,
                                                                // size: 10,
                                                              ),
                                                              onRatingUpdate:
                                                                  (rating) {
                                                                controller
                                                                        .cRating
                                                                        .value =
                                                                    rating;
                                                                setStates(
                                                                    () {});
                                                                print(rating);
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            controller
                                                                .addDocFeedback(
                                                                    labId: item
                                                                        .datumId
                                                                        .toString(),
                                                                    context:
                                                                        context);
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            3),
                                                                color: AppColors
                                                                    .primary),
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 5),
                                                              child: Center(
                                                                  child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                      "add_review"
                                                                          .tr,
                                                                      style: AppTextStyle
                                                                          .boldWhite14),
                                                                ],
                                                              )),
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
                                        ),
                                        // confirm: Text("cooo"),
                                        // actions: <Widget>[Text("aooo"), Text("aooo")],
                                        // cancel: Text("bla bla"),
                                        // content: Text("bla bldddda"),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: AppColors.primary),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: Center(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.add,
                                              color: AppColors.white,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text("add_review".tr,
                                                style:
                                                    AppTextStyle.boldWhite14),
                                          ],
                                        )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.01,
                                  ),
                                  Expanded(
                                    child: controller.loading.value == true
                                        ? Center(
                                            child: CircularProgressIndicator(
                                            color: AppColors.primary,
                                          ))
                                        : controller.feedbackData.isEmpty
                                            ? Center(
                                                child:
                                                    Text("no_result_found".tr))
                                            : SingleChildScrollView(
                                                physics:
                                                    BouncingScrollPhysics(),
                                                child: Column(
                                                  children: List.generate(
                                                      controller.feedbackData
                                                          .length, (index) {
                                                    var d = DateTime.parse(
                                                            controller
                                                                .feedbackData[
                                                                    index]
                                                                .createAt)
                                                        .toPersianDateStr(
                                                          strDay: false,
                                                          strMonth: true,
                                                          useAfghaniMonthName:
                                                              true,
                                                        )
                                                        .trim()
                                                        .split(' ');
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10.0),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Expanded(
                                                                  flex: 2,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      CircleAvatar(
                                                                        radius:
                                                                            35,
                                                                        backgroundImage:
                                                                            NetworkImage(
                                                                          "${ApiConsts.hostUrl}${controller.feedbackData[index].photo}",
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            "${d[0]}",
                                                                            style:
                                                                                AppTextTheme.h(12).copyWith(color: AppColors.primary),
                                                                          ),
                                                                          Text(
                                                                            " ${d[1]}",
                                                                            style:
                                                                                AppTextTheme.h(12).copyWith(color: AppColors.primary),
                                                                          ),
                                                                          Text(
                                                                            " ${d[3]}",
                                                                            style:
                                                                                AppTextTheme.h(12).copyWith(color: AppColors.primary),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 6,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            5),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        // SizedBox(height: 10),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          children: [
                                                                            Container(
                                                                              width: Get.width * 0.38,
                                                                              child: Text(
                                                                                controller.feedbackData[index].postedBy.name ?? "",
                                                                                style: AppTextTheme.h(12).copyWith(color: AppColors.primary),
                                                                              ),
                                                                            ),
                                                                            Spacer(),
                                                                            RatingBar.builder(
                                                                              ignoreGestures: true,
                                                                              itemSize: 17,
                                                                              initialRating: double.parse("${(double.parse(controller.feedbackData[index].rating == null ? "0.0" : controller.feedbackData[index].rating.toString()))}"),
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
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                2),
                                                                        ExpandableText(
                                                                          controller.feedbackData[index].comment ??
                                                                              "",
                                                                          expandText:
                                                                              'Read more',
                                                                          collapseText:
                                                                              'Read less',
                                                                          maxLines:
                                                                              3,
                                                                          linkColor:
                                                                              AppColors.primary,
                                                                          style: AppTextStyle.boldPrimary11.copyWith(
                                                                              fontWeight: FontWeight.w500,
                                                                              color: AppColors.primary.withOpacity(0.5)),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Divider(
                                                              thickness: 1,
                                                              color: AppColors
                                                                  .primary),
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
                                  )
                                ],
                              ),
                            ),
                          )

                    // TabBar(
                    //   controller: controller.tabController,
                    //   labelColor: AppColors.black2,
                    //   unselectedLabelColor: AppColors.lgt,
                    //   isScrollable: true,
                    //   tabs: [
                    //     Text("doctors".tr).paddingVertical(8),
                    //     Text("services_list".tr),
                    //     // Text("reviews".tr),
                    //     Text("about".tr),
                    //   ],
                    // )
                  ],
                ),
              ),
              Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: BottomBarView(
                    isHomeScreen: false,
                  ))
            ],
          );
        }),

        // body: ProfileViewNew(
        //   address: controller.hospital.address,
        //   photo: controller.hospital.photo,
        //   star: controller.hospital.stars,
        //   geometry: controller.hospital.geometry,
        //   name: controller.hospital.name,
        //   phoneNumbers: [controller.hospital.phone],
        //   numberOfusersRated: controller.hospital.usersStaredCount,
        //   child: TabMainView(),
        // ),
      ),
    );
  }
}
