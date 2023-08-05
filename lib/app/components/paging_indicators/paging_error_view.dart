import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:get/get.dart';

class PagingErrorView extends StatelessWidget {
  final PagingController controller;
  const PagingErrorView({
    Key key,
    @required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "unxpected_error_occured".tr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "check_internet_connection_and_retry".tr,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
        TextButton.icon(
          icon: Icon(SimpleLineIcons.refresh),
          label: Text("retry".tr),
          onPressed: () => controller.refresh(),
        )
      ],
    );
  }
}
