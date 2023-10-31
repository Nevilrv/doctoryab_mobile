import 'dart:async';
import 'dart:developer';

import 'package:doctor_yab/app/data/repository/DieaseTreatmentRepository.dart';
import 'package:get/get.dart';
import 'package:doctor_yab/app/data/models/diaease_data_list_res_model.dart'
    as d;
import '../../../../data/models/diaese_category_res_model.dart';
import 'package:audioplayers/audioplayers.dart' as ap;

class DiseaseTreatmentController extends GetxController {
  List<Datum> category = [];
  Datum selectedCategory;
  List<d.Datum> diaseaList = [];
  d.Datum selectedDieases;

  bool isLoading = false;
  bool isLoadingList = false;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    dieaseCategory();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> dieaseCategory() async {
    log("call");
    isLoading = true;
    DieaseTreatementRepository.getDieaseCategory().then((v) {
      isLoading = false;
      if (v.success == true) {
        category.addAll(v.data);
        update();
      } else {
        isLoading = false;
        category = [];
      }
      // v.data.likes.forEach((element) {
      //   if(element.)
      // });
      log("v--------------> ${v.data}");
    }).catchError((e, s) {
      log("e--------------> ${e}");
      category = [];
      isLoading = false;
      Future.delayed(Duration(seconds: 3), () {});
    });
    update();
  }

  Future<void> dieaseDataList(String title) async {
    log("call");
    isLoadingList = true;
    update();
    DieaseTreatementRepository.getDieaseData(title).then((v) {
      isLoadingList = false;
      update();
      diaseaList.clear();
      if (v.data.isNotEmpty) {
        diaseaList.addAll(v.data);
      }

      log("v--------------> ${v.data}");
    }).catchError((e, s) {
      log("e--------------> ${e}");
      category = [];
      isLoadingList = false;
      update();
      Future.delayed(Duration(seconds: 3), () {});
    });
    update();
  }
}
