import 'dart:developer';

import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/models/notification_model.dart';
import 'package:doctor_yab/app/data/repository/NotificationRepo.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
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

        log("data--------------> $data");
      });
    } catch (e) {
      isLoading = false;
      update();
    }
  }

  changeNotificationStatus(String notificationId) {
    try {
      NotificationRepository().notificationStatus(notificationId).then((data) {
        loadNotification();
      });
    } catch (e) {
      log("ERROR===> $e");
    }
    update();
  }
  changeLanguage() {
    try {
      NotificationRepository().changeLanguage(SettingsController.appLanguge).then((data) {
    log("422-------------${data}");
      });
    } catch (e) {
      log("ERROR===> $e");
    }
    update();
  }
}
