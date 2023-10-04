import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DrugsDatabaseView extends GetView {
  const DrugsDatabaseView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Utils.appBar("Drugs Database"),
            SizedBox(height: 30),
            searchTextField(),
          ],
        ),
      ),
    );
  }

  Widget searchTextField() {
    return TextField(
      cursorColor: AppColors.primary,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: "Search a subject (Doctor)",
        hintStyle: AppTextStyle.mediumPrimary11,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(15),
          child: SvgPicture.asset(
            AppImages.search,
            color: AppColors.primary,
          ),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(15),
          child: SvgPicture.asset(AppImages.mic),
        ),
        filled: true,
        fillColor: AppColors.lightPurple2,
        constraints: BoxConstraints(maxHeight: 46),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: AppColors.lightWhite,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: AppColors.primary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: AppColors.lightWhite,
          ),
        ),
      ),
    );
  }
}
