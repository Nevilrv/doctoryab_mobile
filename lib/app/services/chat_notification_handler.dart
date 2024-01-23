import 'dart:convert';

import 'package:doctor_yab/app/data/models/chat_model.dart';
import 'package:doctor_yab/app/data/models/chat_notification_model.dart';
import 'package:doctor_yab/app/modules/chat/controllers/chat_controller.dart';
import 'package:doctor_yab/app/modules/home/controllers/messages_list_controller.dart';
import 'package:doctor_yab/app/services/PushNotificationService.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../data/models/chat_list_api_model.dart';
import '../data/models/notification_payload_model.dart';
import '../routes/app_pages.dart';

class ChatNotificationHandler {
  static void handle(ChatNotificationModel chat,
      NotificationPayloadModel notificationPayloadModel) {
    try {
      Get.find<MessagesListController>().reloadChats(showLoading: false);
    } catch (e) {}
    try {
      var _msgData = ChatNotificationMessageDataModel.fromJson(
          json.decode(chat.messageData));
      // PushNotificationService().showNotification(
      //     _msgData?.sender ?? "New Chat", _msgData?.content ?? "Null");
      PushNotificationService().showNotification(
        chat.title ?? "New Chat",
        chat.body ?? "Null",
        notificationPayloadModel,
      );
    } catch (e, s) {
      Logger().e("", e, s);
    }
  }

  static void handleClick(ChatNotificationModel chat) {
    ChatController _chatController;
    try {
      _chatController = Get.find<ChatController>();
    } catch (e) {}
    try {
      var _chatDecoded = Chat.fromJson(json.decode(chat.chat));

      var _msgData = ChatNotificationMessageDataModel.fromJson(
          json.decode(chat.messageData));
      if (_chatController != null && _chatController?.chatArg()?.id != null) {
        if (_chatController.chatArg().id != _msgData.chat) {
          _chatController.swithChat(ChatListApiModel(
              id: _msgData.chat, chatName: _chatDecoded.chatName));
          // _chatController.chatArg.value = ChatListApiModel(
          //     id: _msgData.chat, chatName: _chatDecoded.chatName);
          _chatController.update();
        }

        // Get.toNamed(Routes.CHAT,
        //     arguments: ChatListApiModel(
        //         id: _msgData.chat, chatName: _chatDecoded.chatName));
      } else {
        Get.toNamed(Routes.CHAT,
            arguments: ChatListApiModel(
                id: _msgData.chat, chatName: _chatDecoded.chatName));
      }
      Get.find<MessagesListController>().reloadChats(showLoading: false);
    } catch (e, s) {
      Logger().e("Failed to open chat", e, s);
    }
  }
}
