import 'package:doctor_yab/app/modules/favourites/pregnancy_tracker/controllers/pregnancy_tracker_controller.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabCalendarView extends GetView<PregnancyTrackerController> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
    );
  }
}
