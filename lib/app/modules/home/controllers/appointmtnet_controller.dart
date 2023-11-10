import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/appointment_history_res_model.dart';
import 'package:doctor_yab/app/data/repository/AppointmentRepository.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AppointmentHistoryController extends GetxController {
  CancelToken cancelToken = CancelToken();

  @override
  void onInit() {
    fetchAppointmentHistory();

    super.onInit();
  }

  List<AppointmentHistory> appointmentList = [];

  bool isLoading = false;
  void fetchAppointmentHistory() {
    isLoading = true;
    update();
    AppointmentRepository.fetchAppointmentHistory(cancelToken: cancelToken)
        .then((v) {
      // AdsModel v = AdsModel();
      appointmentList.clear();
      log("v.data--------------> ${v.data}");
      if (v.data.isNotEmpty) {
        appointmentList.addAll(v.data);
        update();
      }
      isLoading = false;
      update();
    }).catchError((e, s) {
      log("e--------------> ${e}");
      isLoading = false;
      update();
      Logger().e("message", e, s);
      Future.delayed(Duration(seconds: 3), () {
        if (this != null) fetchAppointmentHistory();
      });
    });
  }
}
