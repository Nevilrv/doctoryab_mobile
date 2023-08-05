import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:flutter/material.dart';

extension radius on Widget {
  Widget radiusAll(int radius) {
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(radius.toDouble())),
        child: this);
  }

  Widget radiusCircular(int radius) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(radius.toDouble()), child: this);
  }
}

extension padding on Widget {
  Widget paddingExceptTop(double d) {
    return Padding(
      padding: EdgeInsets.fromLTRB(d, 0.0, d, d),
      child: this,
    );
  }

  Widget paddingExceptBottom(double d) {
    return Padding(
      padding: EdgeInsets.fromLTRB(d, d, d, 0),
      child: this,
    );
  }

  Widget paddingHorizontal(double d) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: d),
      child: this,
    );
  }

  Widget paddingVertical(double d) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: d),
      child: this,
    );
  }

  Widget paddingStart(BuildContext context, double d) {
    return Padding(
      padding: Directionality.of(context) == TextDirection.rtl
          ? EdgeInsets.only(right: d)
          : EdgeInsets.only(left: d),
      child: this,
    );
  }

  Widget paddingEnd(BuildContext context, double d) {
    return Padding(
      padding: Directionality.of(context) == TextDirection.ltr
          ? EdgeInsets.only(right: d)
          : EdgeInsets.only(left: d),
      child: this,
    );
  }
  //  Widget paddingAll(d) {
  //   return Padding(
  //     padding: EdgeInsets.all(d),
  //     child: this,
  //   );
  // }
}

extension colorExt on Widget {
  Widget bgColor(Color color) {
    return Container(child: this, color: color);
  }
}

extension gestures on Widget {
  Widget onTap(VoidCallback callback) {
    return GestureDetector(onTap: callback, child: this);
  }
}

extension widgetSize on Widget {
  Widget size({double width, double height}) {
    if (width != null) assert(width > 0);
    if (height != null) assert(height > 0);
    return SizedBox(child: this, width: width, height: height);
  }
}

//Shadow
extension widgetShadow on Widget {
  Widget basicShadow(
      {Color color, Offset offset, double blurRadius, EdgeInsets padding}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: color ?? AppColors.lgt2.withOpacity(0.1),
            offset: offset ?? Offset(0, 0),
            blurRadius: blurRadius ?? 10,
          ),
        ],
        borderRadius: BorderRadius.circular(40),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(4.0),
        child: this,
      ),
    );
  }
}
