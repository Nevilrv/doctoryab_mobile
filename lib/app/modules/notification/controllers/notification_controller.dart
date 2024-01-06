import 'dart:developer';

import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/models/notification_model.dart' as n;
import 'package:doctor_yab/app/data/repository/NotificationRepo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  bool isLoading = false;
  List<n.Notification> notification = [];
  loadNotification() {
    isLoading = true;
    notification.clear();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      update();
    });

    try {
      NotificationRepository().loadNotification().then((data) {
        n.NotificationModel res = n.NotificationModel.fromJson(data);
        res.data.forEach((element) {
          if (element.status == 'read') {
          } else {
            notification.add(element);
          }
        });
        isLoading = false;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          update();
        });

        log("notification--------------> ${notification.length}");

        log("data--------------> $data");
      });
    } catch (e) {
      isLoading = false;
      log("e------------------------$e");
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        update();
      });
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
      NotificationRepository()
          .changeLanguage(SettingsController.appLanguge)
          .then((data) {
        log("422-------------$data");
      });
    } catch (e) {
      log("ERROR===> $e");
    }
    update();
  }
}
