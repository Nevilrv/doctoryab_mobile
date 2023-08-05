import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:get/get.dart';

class CategoriesGridShimmer extends StatelessWidget {
  final Color baseColor;
  final Color highlightColor;
  final Color color;
  final int xCount;
  final int yCount;
  const CategoriesGridShimmer({
    Key key,
    this.baseColor,
    // this.baseColor = AppColors.shimmerBaseColor,
    // this.baseColor =  Color.,
    this.highlightColor,
    this.color,
    this.xCount,
    this.yCount,
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
          for (int i = 0; i < (yCount ?? 3); i++) {
            // _tmpList.add(_buildDevider());
            var _rowChilds = <Widget>[];
            for (int j = 0; j < (xCount ?? 2); j++) {
              _rowChilds.add(
                Container(
                  height: 169,
                  width: 132,
                  color: color ?? Colors.white,
                ).radiusAll(15).paddingAll(10),
              );
              // _tmpList.add(_buildDevider());
            }
            _tmpList.add(
              Row(
                mainAxisSize: MainAxisSize.min,
                children: _rowChilds,
              ),
            );
          }
          return _tmpList;
        }(),
      ),
    );
  }
}