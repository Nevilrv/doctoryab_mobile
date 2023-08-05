import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math';
import 'package:doctor_yab/app/extentions/widget_exts.dart';

class CustomSwitchController {
  VoidCallback _toggle;
  bool _isInitComplete = false;
  void dispose() {
    _toggle = null;
    _isInitComplete = null;
  }

  VoidCallback get toggle => _toggle;
  set toggle(VoidCallback tog) {
    if (!_isInitComplete) {
      _toggle = tog;
      _isInitComplete = true;
    } else {
      // String error;
      throw CustomSwitchControllerException(
          "You can not change toggle of CustomSwitchController after first init done");
    }
  }
}

class CustomSwitchControllerException implements Exception {
  // @override
  String _message;
  CustomSwitchControllerException([this._message]);
  @override
  String toString() {
    return _message;
  }
}

class CustomAnimatedSwitch extends StatefulWidget {
  @required
  final bool value;
  @required
  final Function(bool) onChanged;
  // final String textOff;
  // final String textOn;
  final Color colorOn;
  final Color colorOff;
  // final double textSize;
  final Duration animationDuration;
  final Function onTap;
  // final Function onDoubleTap;
  // final Function onSwipe;
  final width = 57.0;
  final height = 30.0;
  final CustomSwitchController controller;

  CustomAnimatedSwitch({
    this.controller,
    this.value = false,
    // this.textOff = "Off",
    // this.textOn = "On",
    // this.textSize = 14.0,
    this.colorOn = AppColors.green,
    this.colorOff = AppColors.lgt2,
    this.animationDuration = const Duration(milliseconds: 250),
    this.onTap,
    // this.onDoubleTap,
    // this.onSwipe,
    this.onChanged,
  });

  @override
  _CustomAnimatedSwitchState createState() => _CustomAnimatedSwitchState();
}

class _CustomAnimatedSwitchState extends State<CustomAnimatedSwitch>
    with SingleTickerProviderStateMixin {
  CustomSwitchController controller;
  AnimationController animationController;
  Animation<double> animation;
  double value = 0.0;

  bool turnState;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller = widget.controller;
    if (controller != null) {
      controller.toggle = _action;
    }
    super.initState();
    animationController = AnimationController(
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: widget.animationDuration);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    animationController.addListener(() {
      setState(() {
        value = animation.value;
      });
    });
    turnState = widget.value;
    _determine();
  }

  @override
  Widget build(BuildContext context) {
    Color transitionColor = Color.lerp(widget.colorOff, widget.colorOn, value);

    return GestureDetector(
      // onDoubleTap: () {
      //   _action();
      //   if (widget.onDoubleTap != null) widget.onDoubleTap();
      // },
      onTap: () {
        _action();
        if (widget.onTap != null) widget.onTap();
      },
      // onPanEnd: (details) {
      //   _action();
      //   if (widget.onSwipe != null) widget.onSwipe();
      //   //widget.onSwipe();
      // },
      child: Container(
        // padding: EdgeInsets.all(5),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          // color: transitionColor,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: transitionColor),
          color: transitionColor,
        ),
        child: Stack(
          children: <Widget>[
            Transform.translate(
              offset: Offset(27 * value, 0), //TODO change static value here
              child: Transform.rotate(
                angle: lerpDouble(0, 2 * pi, value),
                child: Container(
                  height: widget.height,
                  width: widget.height - 2, //! TODO Bug here: not true left
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: transitionColor,
                  ),
                  child: Stack(
                    children: <Widget>[
                      SizedBox(
                        height: 25,
                        width: 25,
                      )
                          .bgColor(Colors.white)
                          .radiusAll(100)
                          .basicShadow(padding: EdgeInsets.all(2))
                      // Center(
                      //   child: Opacity(
                      //     opacity: (1 - value).clamp(0.0, 1.0),
                      //     child: Icon(
                      //       widget.iconOff,
                      //       size: 18,
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      // ),
                      // Center(
                      //   child: Opacity(
                      //     opacity: value.clamp(0.0, 1.0),
                      //     child: Icon(
                      //       widget.iconOn,
                      //       size: 18,
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _action() {
    _determine(changeState: true);
  }

  _determine({bool changeState = false}) {
    Future.delayed(Duration.zero, () {
      setState(() {
        if (changeState) turnState = !turnState;
        (turnState)
            ? animationController.forward()
            : animationController.reverse();

        if (widget.onChanged != null) widget.onChanged(turnState);
      });
    });
  }
}
