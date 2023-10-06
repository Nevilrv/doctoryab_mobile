import 'package:doctor_yab/app/modules/home/views/favourites/checkup_packages/controllers/checkup_packages_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckupPackagesView extends GetView<CheckupPackagesController> {
  CheckupPackagesView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: BottomBarView(isHomeScreen: false),
      backgroundColor: AppColors.white,
      body: Column(
        children: [],
      ),
    );
  }
}
