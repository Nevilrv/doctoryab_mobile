import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PagingNoMoreItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4),
      child: Center(child: Text("no_more_item_to_show".tr)),
    );
  }
}
