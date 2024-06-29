import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:flutter/material.dart';

import '../../theme/AppColors.dart';
import '../../theme/TextTheme.dart';

class CustomRoundedButton extends StatelessWidget {
  TextStyle? textStyle;
  Color? splashColor;
  Color? textColor;
  Color? textDisabledColor;
  Color? color;
  Color? disabledColor;
  double? radius;
  double? elevation;
  EdgeInsetsGeometry? padding;
  double? width;
  double? height;
  String? text;
  Function()? onTap;
  bool showBorder;
  Widget? leading;
  Widget? trailing;
  CustomRoundedButton({
    Key? key,
    this.textStyle,
    this.splashColor,
    this.textColor,
    this.textDisabledColor,
    this.color,
    this.disabledColor,
    this.radius,
    this.elevation,
    this.padding,
    this.width,
    this.height,
    this.leading,
    this.trailing,
    @required this.text,
    this.onTap,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(radius ?? 12),
          ),
          side: showBorder ? BorderSide(color: Colors.white) : BorderSide.none,
        ),
        backgroundColor: color ?? Colors.white,
        disabledBackgroundColor: disabledColor ?? AppColors.disabledButtonColor,
        foregroundColor: splashColor ?? AppColors.lgt2,
      ),

      // splashColor: splashColor ?? AppColors.lgt,
      // disabledColor: disabledColor ?? AppColors.disabledButtonColor,
      onPressed: onTap,

      child: Row(
        children: [
          Expanded(
            child: leading ?? SizedBox(),
          ),
          Padding(
            padding: padding ?? const EdgeInsets.all(10.0),
            child: Text(
              text ?? "",
              style: textStyle ??
                  AppTextTheme.m(17).copyWith(
                    color: onTap == null
                        ? textDisabledColor ?? Colors.white.withOpacity(0.6)
                        : textColor ?? AppColors.primary,
                  ),
            ),
          ),
          Expanded(
            child: trailing ?? SizedBox(),
          ),
        ],
      ),
    ).size(width: width, height: height);

    // return RaisedButton(
    //   // TODO dont use dipricated one
    //   elevation: elevation,
    //   splashColor: splashColor ?? AppColors.lgt,
    //   disabledColor: disabledColor ?? AppColors.disabledButtonColor,
    //   onPressed: onTap,
    //   color: color ?? Colors.white,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.all(
    //       Radius.circular(radius ?? 12),
    //     ),
    //     side: showBorder ? BorderSide(color: Colors.white) : BorderSide.none,
    //   ),
    //   child: Row(
    //     children: [
    //       Expanded(
    //         child: leading ?? SizedBox(),
    //       ),
    //       Padding(
    //         padding: padding ?? const EdgeInsets.all(10.0),
    //         child: Text(
    //           text,
    //           style: textStyle ??
    //               AppTextTheme.m(17).copyWith(
    //                 color: onTap == null
    //                     ? textDisabledColor ?? Colors.white.withOpacity(0.6)
    //                     : textColor ?? AppColors.black2,
    //               ),
    //         ),
    //       ),
    //       Expanded(
    //         child: trailing ?? SizedBox(),
    //       ),
    //     ],
    //   ),
    // ).size(width: width, height: height);
  }
}
