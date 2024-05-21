import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import "dart:math" as math;
import 'package:get/get.dart';
import '/app/extentions/widget_exts.dart';

class AddressShowOnMap extends StatelessWidget {
  const AddressShowOnMap({
    Key? key,
    required this.address,
    this.lat,
    this.lon,
  }) : super(key: key);

  final String address;
  final double? lat, lon;

  @override
  Widget build(BuildContext context) {
    var _flag = lat != null && lon != null;
    return Column(
      children: [
        if (address != "")
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 8),
              SvgPicture.asset(
                "assets/svg/location_pin.svg",
                height: 20,
              ).paddingOnly(top: 4),
              SizedBox(width: 8),
              Flexible(
                child: Text(
                  address ?? "",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextTheme.b(14).copyWith(color: AppColors.lgt2),
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
        SizedBox(height: 12),
        if (_flag)
          OutlinedButton(
            onPressed: (_flag)
                ? () {
                    Utils.openGoogleMaps(lat!, lon!);
                  }
                : null,
            child: Row(
              children: [
                Text(
                  "show_on_map".tr,
                  style: AppTextTheme.b(14).copyWith(color: AppColors.primary),
                ),
                Spacer(),
                // Transform.rotate(
                //   angle: math.pi,
                //   child: Icon(Icons.arrow_back, color: AppColors.primary),
                // ),
                SvgPicture.asset("assets/svg/google_maps-icon.svg"),
              ],
            ).paddingVertical(10),
          )
      ],
    );
  }
}
