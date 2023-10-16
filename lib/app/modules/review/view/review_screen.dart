import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ReviewScreen extends StatelessWidget {
  final String appBarTitle;
  const ReviewScreen({Key key, this.appBarTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Background(
      isSecond: false,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppAppBar.specialAppBar(appBarTitle.tr,
              backgroundColor: Colors.transparent,
              action: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SvgPicture.asset(AppImages.blackBell),
              )),
          body: Container(
            height: h,
            // color: AppColors.red,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Container(
                    // height: 220,

                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 7,
                          blurRadius: 7,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                // color: Colors.black,
                                // height: 65,
                                // width: 65,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.lightGrey),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CachedNetworkImage(
                                    imageUrl: "",
                                    height: 100,
                                    width: 100,
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
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "Dr. Manu Django Conradine",
                                            style: AppTextTheme.h(12).copyWith(
                                                color: AppColors.primary),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "Internal Medicine",
                                      style: AppTextTheme.b(11).copyWith(
                                          color: AppColors.primary
                                              .withOpacity(0.5)),
                                    ),
                                    SizedBox(height: 2),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        RatingBar.builder(
                                          ignoreGestures: true,
                                          itemSize: 17,
                                          initialRating: 4,
                                          // minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 1.0),
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
                                        // Text(
                                        //   '(${double.tryParse(controller.doctor.totalStar?.toStringAsFixed(1)) ?? ""})',
                                        //   style: AppTextTheme.b(10.5)
                                        //       .copyWith(color: AppColors.lgt2),
                                        // ),
                                        Text(
                                          '(10) Reviews',
                                          style: AppTextTheme.b(11).copyWith(
                                              color: AppColors.primary
                                                  .withOpacity(0.5)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: h * 0.015,
                        ),
                        Divider(thickness: 1, color: AppColors.primary),
                        Padding(
                          padding: EdgeInsets.only(top: h * 0.015),
                          child: Column(
                            children: List.generate(
                                3,
                                (index) => GestureDetector(
                                      onTap: () {
                                        Get.dialog(
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30),
                                            child: Center(
                                              child: Container(
                                                width: w,
                                                // height: Get.height * 0.3,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: AppColors.white,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: h * 0.01,
                                                      vertical: 10),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                              flex: 1,
                                                              child: Column(
                                                                children: [
                                                                  CircleAvatar(
                                                                    radius: 30,
                                                                    backgroundImage:
                                                                        AssetImage(
                                                                      "assets/png/person-placeholder.jpg",
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "08.12.2023",
                                                                    style: AppTextTheme.h(
                                                                            12)
                                                                        .copyWith(
                                                                            color:
                                                                                AppColors.primary),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 4,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        5),
                                                                child: Column(
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
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              w * 0.3,
                                                                          child:
                                                                              Text(
                                                                            "Fatih Resul Göker ",
                                                                            style:
                                                                                AppTextTheme.h(12).copyWith(color: AppColors.primary),
                                                                          ),
                                                                        ),
                                                                        Spacer(),
                                                                        RatingBar
                                                                            .builder(
                                                                          ignoreGestures:
                                                                              true,
                                                                          itemSize:
                                                                              17,
                                                                          initialRating:
                                                                              4,
                                                                          // minRating: 1,
                                                                          direction:
                                                                              Axis.horizontal,
                                                                          allowHalfRating:
                                                                              true,
                                                                          itemCount:
                                                                              5,
                                                                          itemPadding:
                                                                              EdgeInsets.symmetric(horizontal: 1.0),
                                                                          itemBuilder: (context, _) =>
                                                                              Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                Colors.amber,
                                                                            // size: 10,
                                                                          ),
                                                                          onRatingUpdate:
                                                                              (rating) {
                                                                            print(rating);
                                                                          },
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Get.back();
                                                                          },
                                                                          child:
                                                                              Icon(
                                                                            Icons.cancel_outlined,
                                                                            color:
                                                                                AppColors.primary,
                                                                            size:
                                                                                20,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            2),
                                                                    Text(
                                                                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,...Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,...",
                                                                      style: AppTextStyle.boldPrimary11.copyWith(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color: AppColors
                                                                              .primary
                                                                              .withOpacity(0.5)),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          // confirm: Text("cooo"),
                                          // actions: <Widget>[Text("aooo"), Text("aooo")],
                                          // cancel: Text("bla bla"),
                                          // content: Text("bla bldddda"),
                                        );
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 35,
                                                          backgroundImage:
                                                              AssetImage(
                                                            "assets/png/person-placeholder.jpg",
                                                          ),
                                                        ),
                                                        Text(
                                                          "08.12.2023",
                                                          style: AppTextTheme.h(
                                                                  12)
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .primary),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5),
                                                      child: Column(
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
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(
                                                                "Fatih Resul Göker",
                                                                style: AppTextTheme
                                                                        .h(12)
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .primary),
                                                              ),
                                                              Spacer(),
                                                              RatingBar.builder(
                                                                ignoreGestures:
                                                                    true,
                                                                itemSize: 17,
                                                                initialRating:
                                                                    4,
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
                                                                  print(rating);
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 2),
                                                          ExpandableText(
                                                            "“Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,...”",
                                                            expandText:
                                                                'Read more',
                                                            collapseText:
                                                                'Read less',
                                                            maxLines: 3,
                                                            linkColor: AppColors
                                                                .primary,
                                                            style: AppTextStyle
                                                                .boldPrimary11
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: AppColors
                                                                        .primary
                                                                        .withOpacity(
                                                                            0.5)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            index == 2
                                                ? SizedBox()
                                                : Divider(
                                                    thickness: 1,
                                                    color: AppColors.primary),
                                          ],
                                        ),
                                      ),
                                    )),
                          ),
                        )
                      ]),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 20,
                    right: 20,
                    left: 20,
                    child: BottomBarView(isHomeScreen: false))
              ],
            ),
          )),
    );
  }
}
