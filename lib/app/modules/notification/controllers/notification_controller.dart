import 'dart:developer';

import 'package:doctor_yab/app/data/models/notification_model.dart';
import 'package:doctor_yab/app/data/repository/NotificationRepo.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  bool isLoading = false;
  List<Notification> notification = [];
  loadNotification() {
    isLoading = true;
    notification.clear();
    update();
    try {
      NotificationRepository().loadNotification().then((data) {
        NotificationModel res = NotificationModel.fromJson(data);
        res.data.forEach((element) {
          notification.add(element);
        });
        isLoading = false;
        update();
        log("notification--------------> ${notification.length}");

        log("data--------------> ${data}");
      });
    } catch (e) {
      isLoading = false;
      update();
    }
  }
}
