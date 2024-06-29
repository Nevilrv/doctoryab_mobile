import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PagingNoItemFountList extends StatelessWidget {
  final String? title, subTitle;
  const PagingNoItemFountList({
    Key? key,
    this.subTitle,
    this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title ?? "list_empty_for_now".tr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(subTitle ?? "no_item_to_show".tr),
      ],
    );
  }
}
