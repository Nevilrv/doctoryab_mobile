import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';

class CityShimmer extends StatelessWidget {
  final Color baseColor;
  final Color highlightColor;
  final Color color;
  final int linesCount;
  const CityShimmer({
    Key key,
    this.baseColor,
    // this.baseColor = AppColors.shimmerBaseColor,
    // this.baseColor =  Color.,
    this.highlightColor,
    this.color,
    this.linesCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: Duration(seconds: 1),
      direction: ShimmerDirection.ltr,
      // baseColor: Colors.amber,
      // highlightColor: Colors.amber[100],
      // baseColor: Colors.grey[300],
      // highlightColor: Colors.white,

      baseColor: baseColor ?? Colors.grey[300],
      highlightColor: highlightColor ?? Colors.grey[100],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: () {
          var _tmpList = <Widget>[];
          for (int i = 0; i < linesCount ?? 4; i++) {
            _tmpList.add(_buildDevider());
          }
          return _tmpList;
        }(),
      ),
    );
  }

  Widget _buildDevider() {
    return Divider(
      thickness: 8,
      color: color ?? Colors.white,
    ).paddingSymmetric(horizontal: 30).paddingOnly(bottom: 30);
  }
}
