// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../../data/models/chat_model.dart';
// import 'messages_list_controller.dart';

// class TabChatController extends GetxController {
//   int index = Get.arguments as int;
//   TextEditingController messageC;
//   ScrollController scrollC = ScrollController();
//   Rx<ChatModel> chat = ChatModel(sendarName: 'N/A', senderImage: null).obs;
//   RxList<XFile> image = <XFile>[].obs;
//   init() {
//     messageC = TextEditingController();
//     chat.value = Get.find<MessagesListController>().chats[index];
//     Get.find<MessagesListController>().chats.listen((elements) {
//       chat = elements[index].obs;
//       Get.log('called');
//     });
//   }

//   var isLoading = false.obs;

//   void sendMessage() async {
//     if (messageC.text.isNotEmpty || image.isNotEmpty) {
//       isLoading.value = true;

//       if (image != null && image.isNotEmpty) {
//         await Future.delayed(Duration(seconds: 2));
//       }
//       List<String> sendImages = [];
//       for (var img in image) {
//         sendImages.add(base64Encode(await File(img.path).readAsBytes()));
//       }
//       Get.find<MessagesListController>().chats[index].messages = [
//         MessageModel(
//             message: messageC.text,
//             isUsers: true,
//             messageStatus: MessageStatus.sent,
//             image: image != null && image.isNotEmpty ? sendImages : null),
//         ...Get.find<MessagesListController>().chats[index].messages
//       ];
//       messageC.clear();
//       image.value = [];
//       isLoading.value = false;
//       Get.find<MessagesListController>().chats.refresh();
//       generateReply();
//     }
//   }

//   void generateReply() async {
//     await Future.delayed(Duration(seconds: 1));
//     Get.find<MessagesListController>()
//         .chats[index]
//         .messages
//         .first
//         .messageStatus = MessageStatus.seen;
//     Get.find<MessagesListController>().chats.refresh();
//     await Future.delayed(Duration(seconds: 1));
//     var replies = [
//       'Hello, its a test message?',
//       'This is text message',
//       'Hi! You have a appointment!',
//       'Write your suggestion about the subject'
//     ];
//     Get.find<MessagesListController>().chats[index].messages = [
//       MessageModel(
//           message: replies[Random().nextInt(replies.length)],
//           isUsers: false,
//           messageStatus: MessageStatus.delivered,
//           image: null),
//       ...Get.find<MessagesListController>().chats[index].messages
//     ];
//     Get.find<MessagesListController>().chats.refresh();
//     isLoading.value = false;
//   }

//   void scrollToEnd() {
//     scrollC.animateTo(
//       scrollC.position.maxScrollExtent,
//       curve: Curves.easeOut,
//       duration: const Duration(milliseconds: 300),
//     );
//   }

//   void pickImage() async {
//     image.value = await ImagePicker().pickMultiImage();
//   }

//   @override
//   void onInit() {
//     init();

//     super.onInit();
//   }

//   @override
//   void onReady() {
//     super.onReady();
//   }

//   @override
//   void onClose() {
//     super.onClose();
//   }
// }
