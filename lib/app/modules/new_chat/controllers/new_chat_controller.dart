import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/chat_list_api_model.dart';
import 'package:doctor_yab/app/modules/home/controllers/messages_list_controller.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../data/repository/ChatRepository.dart';

class NewChatController extends GetxController {
  final count = 0.obs;
  var inputValidated = false.obs;

  var teTitle = TextEditingController();
  var teMessage = TextEditingController();
  var sending = false.obs;

  var cancelToken = CancelToken();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    cancelToken.cancel();
    super.onClose();
  }

  void increment() => count.value++;
  void validateInput(String str) {
    if (teTitle.text.isNotEmpty && teMessage.text.isNotEmpty) {
      inputValidated(true);
    } else
      inputValidated(false);
  }

  void sendMessage() {
    sending(true);
    createChat();
  }

  Future<void> createChat() async {
    print('------CALL>>>>SEND');
    ChatRepository.createNewChat(teTitle.text, teMessage.text,
        cancelToken: cancelToken, onError: (e) {
      if (!(e is DioError && CancelToken.isCancel(e))) {
        // isLoading.value = false;
        Future.delayed(Duration(seconds: 2), () {
          cancelToken.cancel();
          cancelToken = CancelToken();
          if (this != null)
            createChat();
          else
            return;
        });
      }
    }).then((value) {
      if (value != null) {
        sending(false);
        Get.offNamed(Routes.CHAT,
                arguments: ChatListApiModel(
                    id: value.chat.id, chatName: value.chat.chatName))
            .then((value) {
          try {
            Get.find<MessagesListController>().reloadChats();
          } catch (e) {}
        });
      }
    }).catchError((e, s) {
      Logger().e("message", e, s);
    });
  }
}
