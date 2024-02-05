import 'package:doctor_yab/app/modules/favourites/pregnancy_tracker_new/controller/pregnancy_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PregnancyTrimster extends GetView<PregnancyTrackerNewController> {
  PregnancyTrimster({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: Scaffold(),
    );
  }
}
