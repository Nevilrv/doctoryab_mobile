import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/modules/hospital_new/tab_main/views/tab_main_view.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/get_utils.dart';

import 'package:doctor_yab/app/data/models/labs_model.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';

import '../modules/drug_store_lab/views/drug_store_lab_view.dart';
import '../theme/AppColors.dart';
import '../theme/TextTheme.dart';
import '../utils/utils.dart';

class ProfileViewNew extends StatelessWidget {
  const ProfileViewNew({
    Key key,
    this.photo,
    this.name,
    this.star,
    this.address,
    this.geometry,
    this.phoneNumbers,
    this.child,
    this.showChildInBox = true,
    this.numberOfusersRated,
  }) : super(key: key);
  final String photo;
  final String name;
  final num star;
  final String address;
  final Geometry geometry;
  final List<String> phoneNumbers;
  final Widget child;
  final bool showChildInBox;
  final num numberOfusersRated;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        // height: 220,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.1),
          //     spreadRadius: 7,
          //     blurRadius: 7,
          //     offset: Offset(0, 0),
          //   ),
          // ],
        ),
        child: Column(
          children: [
            Container(
              // height: h * 0.2,
              width: w,
              child: Row(
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
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Text(
                                  "Afghan Hospital",
                                  style: AppTextTheme.h(15)
                                      .copyWith(color: AppColors.black2),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2),
                          Text(
                            "شفاخانه افغان",
                            style: AppTextTheme.b(14)
                                .copyWith(color: AppColors.lgt2),
                          ),
                          SizedBox(height: 2),
                          Row(
                            // mainAxisSize: MainAxisSize.min,
                            // mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              RatingBar.builder(
                                ignoreGestures: true,
                                itemSize: 15,
                                initialRating: 4,
                                // minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 1.0),
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
                              Center(
                                child: Text(
                                  '5.0 - 10 Reviews',
                                  style: AppTextTheme.b(12).copyWith(
                                      color:
                                          AppColors.primary.withOpacity(0.5)),
                                ).paddingOnly(top: 3),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Utils.openPhoneDialer(context, "369988888");
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    decoration: BoxDecoration(
                                        color: AppColors.secondary,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        Center(
                                          child: Text(
                                            "call".tr,
                                            style: AppTextTheme.m(14)
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                        Spacer(),
                                        SvgPicture.asset(AppImages.phone)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.lightGrey),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      "assets/svg/location_pin.svg",
                      color: AppColors.primary,
                    ).paddingOnly(top: 3),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        "H4FC+6VJ, Kabul, Afganistan, H4FC+6VJ، کابل",
                        maxLines: 1,
                        style:
                            AppTextTheme.b(13).copyWith(color: AppColors.lgt2),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ).paddingVertical(8).onTap(() {
                  // if (item.geometry?.coordinates !=
                  //     null) if (item.geometry.coordinates.length > 1) {
                  //   Utils.openGoogleMaps(item.geometry.coordinates[1],
                  //       item.geometry.coordinates[0]);
                  // }
                }),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: h * 0.18,
                width: w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    image: DecorationImage(
                        image: AssetImage(AppImages.fullMap),
                        fit: BoxFit.fill)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: child,
            ),
          ],
        ),
      ),
    );
    // return NestedScrollView(
    //   headerSliverBuilder: ((context, innerBoxIsScrolled) {
    //     return [
    //       Stack(
    //         alignment: Alignment.topCenter,
    //         children: [
    //           _header(context),
    //           Positioned(
    //             child: CircleAvatar(
    //               radius: 60,
    //               child: CachedToFullScreenImage(photo).radiusAll(100),
    //             ).basicShadow(),
    //           )
    //         ],
    //       )
    //           .paddingSymmetric(
    //             horizontal: 12,
    //           )
    //           .paddingOnly(top: 16)
    //           .sliverBox,
    //     ];
    //   }),
    //   body: child == null
    //       ? null
    //       : showChildInBox
    //           ? Container(
    //               child: child,
    //               // constraints: BoxConstraints.loose(Size(100, 100)),
    //               // color: Colors.red,
    //               // height: c.maxHeight - 16,
    //             )
    //               .bgColor(Colors.white)
    //               .radiusAll(15)
    //               .basicShadow()
    //               .paddingSymmetric(horizontal: 12, vertical: 0)
    //               .paddingOnly(top: 16)
    //           : child,
    // );
  }

  Widget _header(BuildContext context) {
    return Container(
      // height: 300,
      padding: EdgeInsets.only(top: 70),
      width: double.infinity,
      child: Column(
        children: [
          FittedBox(
            child: Text(
              name ?? "",
              style: AppTextTheme.b(14),
              maxLines: 1,
            ),
          ),
          if (star != null) ...[
            SizedBox(height: 8),
            RatingBar.builder(
              ignoreGestures: true,
              itemSize: 15,
              initialRating: double.tryParse(star?.toStringAsFixed(1)) ?? 0.0,
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
          if (numberOfusersRated != null) ...[
            SizedBox(height: 8),
            FittedBox(
              child: Text(
                "overal_rating_from_visitors"
                    .trArgs(['${numberOfusersRated.toStringAsFixed(0) ?? 0}']),
                style: AppTextTheme.l(13),
                maxLines: 1,
              ),
            ),
          ],
          if (address != null) ...[
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset("assets/svg/location_pin.svg")
                    .paddingOnly(top: 4),
                SizedBox(width: 8),
                Flexible(
                  child: Text(
                    address ?? "",
                    maxLines: 3,
                    style: AppTextTheme.b(14).copyWith(color: AppColors.lgt2),
                    overflow: TextOverflow.ellipsis,
                    // textAlign: TextAlign.center,
                  ),
                ),
              ],
            ).paddingVertical(8),
            SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () {
                if (geometry.coordinates != null) {
                  var g = geometry.coordinates;
                  Utils.openGoogleMaps(g[1], g[0]);
                } else {
                  Utils.showSnackBar(context, "No Location Found");
                }
              },
              icon: SvgPicture.asset("assets/svg/google_maps-icon.svg")
                  .paddingVertical(8)
                  .paddingEnd(context, 4),
              label: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: FittedBox(
                      child: Text(
                        "show_on_map".tr ?? "",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style:
                            AppTextTheme.b(14).copyWith(color: AppColors.lgt2),
                      ).paddingAll(4),
                    ),
                  ),
                  Icon(Icons.arrow_forward).paddingAll(4),
                ],
              ),
            ),
          ],
          if (phoneNumbers != null) ...[
            SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: phoneNumbers
                  .map((e) => Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset("assets/svg/call-24px.svg"),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              e,
                              style: AppTextTheme.m(14)
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      )
                          .paddingSymmetric(horizontal: 20, vertical: 8)
                          .bgColor(AppColors.green)
                          .radiusAll(12)
                          .onTap(() {
                        Utils.openPhoneDialer(context, e);
                      }))
                  .toList(),
            )
          ]
        ],
      ).paddingExceptTop(16),
    )
        .bgColor(Colors.white)
        .radiusAll(15)
        .basicShadow()
        .paddingAll(4)
        .paddingOnly(top: 60);
  }
}
