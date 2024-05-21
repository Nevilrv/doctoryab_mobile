import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBasic extends StatelessWidget {
  final Color baseColor;
  final Color highlightColor;
  final Color color;
  const ShimmerBasic({
    Key? key,
    this.baseColor = Colors.grey,
    // this.baseColor = AppColors.shimmerBaseColor,
    // this.baseColor =  Color.,
    this.highlightColor = Colors.white,
    this.color = Colors.white,
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

      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: color,
        padding: EdgeInsets.all(20.0),
      ),
    );
  }
}
