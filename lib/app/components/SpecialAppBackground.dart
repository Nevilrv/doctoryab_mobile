import 'package:flutter/material.dart';

import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:get/get.dart';

class SpecialAppBackground extends StatelessWidget {
  /// child is in stack so you can use positioned
  final Widget child;

  const SpecialAppBackground({Key key, @required this.child})
      : assert(child != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SizedBox(
      // height: ,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            color: AppColors.primary,
            constraints: BoxConstraints.expand(),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Hero(
              tag: "cloud",
              child: SvgPicture.asset(
                "assets/svg/bloob.svg",
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Hero(
              tag: "circle",
              child: SvgPicture.asset(
                "assets/svg/circle.svg",
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ),
          child,
        ],
      ).onTap(() {
        Get.focusScope.unfocus();
      }),
    ));
  }
}
