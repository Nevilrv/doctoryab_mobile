import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:get/get.dart';

class DoctorListTileShimmer extends StatelessWidget {
  final Color baseColor;
  final Color highlightColor;
  final Color color;
  final int count;
  const DoctorListTileShimmer({
    Key key,
    this.baseColor,
    // this.baseColor = AppColors.shimmerBaseColor,
    // this.baseColor =  Color.,
    this.highlightColor,
    this.color,
    this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Shimmer.fromColors(
        period: Duration(seconds: 1),
        direction: ShimmerDirection.rtl,
        // baseColor: Colors.amber,
        // highlightColor: Colors.amber[100],
        // baseColor: Colors.grey[300],
        // highlightColor: Colors.white,

        baseColor: baseColor ?? Colors.grey[300],
        highlightColor: highlightColor ?? Colors.grey[100],
        child: Directionality(
          textDirection: Directionality.of(context),
          //  == TextDirection.ltr
          // ? TextDirection.rtl
          // : TextDirection.ltr,
          child: Column(
            children: () {
              List<Widget> tmp = <Widget>[];
              for (int i = 0; i < (count ?? 3); i++) {
                tmp.add(
                  Row(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: color ?? Colors.white,
                      ),
                      SizedBox(width: 16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 5,
                            width: Get.width / 2,
                            color: color ?? Colors.white,
                          ),
                          SizedBox(height: 8),
                          Container(
                            height: 5,
                            width: Get.width / 3,
                            color: color ?? Colors.white,
                          ),
                          SizedBox(height: 8),
                          Container(
                            height: 5,
                            width: Get.width / 2.5,
                            color: color ?? Colors.white,
                          ),
                        ],
                      )
                    ],
                  ).paddingHorizontal(16).paddingVertical(8),
                );
              }
              return tmp;
            }(),
          ),
        ),
      ),
    );
  }
}
