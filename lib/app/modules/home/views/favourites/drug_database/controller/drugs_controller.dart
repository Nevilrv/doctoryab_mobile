import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrugsController extends GetxController {
  String filterSearch = "";
  TextEditingController searchController = TextEditingController();

  search(String s) {
    filterSearch = s;
    update();
  }

  final List medicinesNames = [
    "VITAMIN D3 (1000IU)",
    "VITAMIN C3 (1100IU)",
    "VITAMIN A2 (1000IU)",
    "VITAMIN W3 (1100IU)",
    "VITAMIN C4 (1000IU)",
    "VITAMIN D6 (1200IU)",
    "VITAMIN A4 (1100IU)",
  ];

  final List data = [
    {"image": AppImages.medicine, "title": "drug_type", "text": "capsule"},
    {"image": AppImages.pillbox, "title": "box_cont", "text": "pack_cont"},
    {"image": AppImages.coin, "title": "price", "text": "drug_price"}
  ];
}
