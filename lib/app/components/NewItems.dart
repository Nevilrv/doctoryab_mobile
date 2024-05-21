import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class NewItems extends StatelessWidget {
  final bool is24Hour;
  final String title, address, imagePath, phoneNumber;
  final List<double> latLng;
  const NewItems({
    Key? key,
    this.is24Hour = false,
    required this.title,
    required this.address,
    required this.imagePath,
    required this.phoneNumber,
    required this.latLng,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListTile(
          contentPadding: EdgeInsets.all(16),
          leading: AspectRatio(
            aspectRatio: 1,
            child: Transform.scale(
              scale: 1.2,
              child: Container(
                // height: 100,
                // width: 100,
                // color: Colors.red,
                child: SizedBox(
                  child: CachedNetworkImage(
                    imageUrl: "${ApiConsts.hostUrl}$imagePath",
                    fit: BoxFit.cover,
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
                ).radiusAll(16),
              ),
            ),
          ),
          title: Text(
            "$title",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextTheme.h(15).copyWith(color: AppColors.black2),
          ),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.translate(
                offset: Offset(0, 2),
                child: SvgPicture.asset("assets/svg/location_pin.svg")
                    .paddingOnly(top: 4),
              ),
              SizedBox(width: 8),
              Flexible(
                child: Text(
                  "$address",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextTheme.b(14).copyWith(
                    color: AppColors.lgt2,
                  ),
                  // textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 4).onTap(() {
            if (latLng != null && latLng.length > 1) {
              Utils.openGoogleMaps(latLng[1], latLng[0]);
            }
          }),
          trailing: phoneNumber == null
              ? null
              : SizedBox(
                  child: Icon(
                    Icons.phone,
                    color: Colors.white,
                    size: 18,
                  ).paddingAll(2),
                )
                  .paddingAll(8)
                  .bgColor(AppColors.green)
                  .radiusAll(100)
                  .onTap(() {
                  Utils.openPhoneDialer(context, phoneNumber);
                }),
        ),
        if (is24Hour)
          Positioned.directional(
            textDirection: Directionality.of(context),
            end: -25,
            top: -8,
            child: Transform.rotate(
              angle: (math.pi / 4) *
                  (Directionality.of(context) == TextDirection.ltr ? 1 : -1),
              child: Container(
                padding: EdgeInsets.fromLTRB(18, 20, 18, 2),
                color: Get.theme.primaryColor,
                child: Text(
                  "24_hours".tr,
                  style: AppTextTheme.l(7).copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
      ],
    ).bgColor(Colors.white).radiusAll(15).basicShadow().paddingAll(4);
  }
}
