import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:flutter/material.dart';

class PointPainter extends StatelessWidget {
  final TextStyle style;
  const PointPainter({this.style});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          () {
            return List.filled(
                    (MediaQuery.of(context).size.width * 2).toInt(), ".")
                .join();
          }(),
          maxLines: 1,
          overflow: TextOverflow.clip,
          style: style ?? TextStyle(color: AppColors.lgt2),
        ),
      ),
    );
  }
}
