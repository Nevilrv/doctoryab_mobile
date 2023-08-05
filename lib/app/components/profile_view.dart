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
    return NestedScrollView(
      headerSliverBuilder: ((context, innerBoxIsScrolled) {
        return [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              _header(context),
              Positioned(
                child: CircleAvatar(
                  radius: 60,
                  child: CachedToFullScreenImage(photo).radiusAll(100),
                ).basicShadow(),
              )
            ],
          )
              .paddingSymmetric(
                horizontal: 12,
              )
              .paddingOnly(top: 16)
              .sliverBox,
        ];
      }),
      body: child == null
          ? null
          : showChildInBox
              ? Container(
                  child: child,
                  // constraints: BoxConstraints.loose(Size(100, 100)),
                  // color: Colors.red,
                  // height: c.maxHeight - 16,
                )
                  .bgColor(Colors.white)
                  .radiusAll(15)
                  .basicShadow()
                  .paddingSymmetric(horizontal: 12, vertical: 0)
                  .paddingOnly(top: 16)
              : child,
    );
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
