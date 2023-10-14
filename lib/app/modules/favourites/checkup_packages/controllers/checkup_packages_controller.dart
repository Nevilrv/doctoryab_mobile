import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckupPackagesController extends GetxController {
  TextEditingController searchController = TextEditingController();
  final List<String> selectHospitalLabList = [
    'Ankara Hastanesi Laboratuvarı Kan Testi Bölümü',
    'Ankara Hastanesi Laboratuvarı Kan Testi Bölümü1',
    'Ankara Hastanesi Laboratuvarı Kan Testi Bölümü2',
    'Ankara Hastanesi Laboratuvarı Kan Testi Bölümü3',
    'Ankara Hastanesi Laboratuvarı Kan Testi Bölümü4',
    'Ankara Hastanesi Laboratuvarı Kan Testi Bölümü5',
    'Ankara Hastanesi Laboratuvarı Kan Testi Bölümü6-',
    'Ankara Hastanesi Laboratuvarı Kan Testi Bölümü7'
  ];
  var selectedHospitalLab =
      "Ankara Hastanesi Laboratuvarı Kan Testi Bölümü".obs;

  final List<String> dateList = [
    "27.08.2023",
    "28.08.2023",
    "29.08.2023",
    "30.08.2023",
    "31.08.2023",
  ];
  var selectedDate = "27.08.2023".obs;
  final List<String> timeList = [
    "21:09 AM",
    "22:09 AM",
    "23:09 AM",
    "24:09 AM",
  ];
  var selectedTime = "21:09 AM".obs;
}
