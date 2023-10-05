import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrugsController extends GetxController {
  String filterSearch = "";
  TextEditingController searchController = TextEditingController();

  search(String s) {
    filterSearch = s;
    update();
  }
}
