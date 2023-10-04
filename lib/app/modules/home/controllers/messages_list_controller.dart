import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/chat_list_api_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

import '../../../data/repository/ChatRepository.dart';
import '../../../routes/app_pages.dart';

class MessagesListController extends GetxController {
  final isLoading = true.obs;
  var filterSearch = RxString(null);
  TextEditingController teSearchController = TextEditingController();

  RxList<ChatListApiModel> chats = <ChatListApiModel>[].obs;
  CancelToken chatCancelToken = CancelToken();
  var pagingController =
      PagingController<int, ChatListApiModel>(firstPageKey: 1);

  List<ChatListApiModel> userChats = [
    // ChatModel(
    //   sendarName: 'Viktor Savage',
    //   status: Status.online,
    //   senderImage:
    //       'https://images.unsplash.com/photo-1595211877493-41a4e5f236b3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=715&q=80',
    //   messages: [
    //     MessageModel(
    //         message: 'What\'s up?',
    //         isUsers: true,
    //         messageStatus: MessageStatus.seen),
    //     MessageModel(
    //       message: 'Hello',
    //       isUsers: true,
    //     ),
    //     MessageModel(
    //       message: 'Hey!',
    //       isUsers: false,
    //     ),
    //   ],
    // ),
    // ChatModel(
    //   sendarName: 'Roger Fritz',
    //   status: Status.offline,
    //   senderImage:
    //       'https://images.unsplash.com/photo-1586297135537-94bc9ba060aa?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80',
    //   messages: [
    //     MessageModel(
    //         message: 'Nothing much, wby?',
    //         isUsers: false,
    //         messageStatus: MessageStatus.delivered),
    //     MessageModel(
    //         message: 'What\'s up?',
    //         isUsers: true,
    //         messageStatus: MessageStatus.seen),
    //     MessageModel(
    //       message: 'Hello',
    //       isUsers: true,
    //     ),
    //     MessageModel(
    //       message: 'Hey!',
    //       isUsers: false,
    //     ),
    //   ],
    // ),
  ];

  // ChatModel _systemChat = ChatModel(
  //     sendarName: 'System Messages',
  //     senderImage: null,
  //     status: Status.online,
  //     // 'https://static.vecteezy.com/system/resources/previews/003/101/266/original/icon-of-blank-message-dialogue-box-free-vector.jpg',
  //     messages: [
  //       MessageModel(
  //         message: 'What\'s up?',
  //         isUsers: true,
  //       ),
  //       MessageModel(
  //           message: 'System message',
  //           isUsers: false,
  //           messageStatus: MessageStatus.sent),
  //       MessageModel(
  //         message: 'Hello',
  //         isUsers: true,
  //       ),
  //       MessageModel(
  //         message: 'Hey!',
  //         isUsers: false,
  //       ),
  //     ]);

  void onTapMessageTile(ChatListApiModel item) async {
    await Get.toNamed(Routes.CHAT, arguments: item);
    reloadChats();
  }

  @override
  void onInit() {
    // chats.value = [_systemChat, ...userChats];
    chats.value = [...userChats];
    debounce(filterSearch, (_) {
      // // if (teSearchController.text.trim() != "") {
      // pagingController.error = null;
      // pagingController.itemList = null;
      // pagingController.nextPageKey = pagingController.firstPageKey;
      // _search(pagingController.firstPageKey);
      // print("refresh");
      // pagingController.refresh();
      // // } else {
      // //   firstSearchInit(false);
      // // }

      reloadChats();
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    loadChatList();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> loadChatList({bool cleanTheArray = false}) async {
    await ChatRepository.fetchChatList(filterSearch.value,
        cancelToken: chatCancelToken, onError: (e) {
      if (!(e is DioError && CancelToken.isCancel(e))) {
        // isLoading.value = false;
        Future.delayed(Duration(seconds: 3), () {
          loadChatList();
        });
      }
    }).then((value) {
      // var _tmp = value.map((item) {
      //   return ChatModel(
      //     sendarName: item.chatName,
      //     status: Status.online,
      //     messages: <MessageModel>[
      //       MessageModel(
      //         message: item?.latestMessage?.content ?? "",
      //         isUsers: true,
      //       ),
      //     ],
      //     senderImage: Utils.getFullPathOfAssets(item.users[0].photo),
      //   );
      // }).toList();
      // if (cleanTheArray) {
      chats.clear();
      // }
      chats.addAll(value);
      print(value.toString());
      chats.refresh();

      isLoading.value = false;

      //
    }).catchError((e, s) {
      Logger().e("message", e, s);
    });
  }

  Future<void> reloadChats({showLoading = true}) async {
    await Future.delayed(Duration.zero, () {
      chatCancelToken.cancel();
    });
    chatCancelToken = new CancelToken();

    isLoading(showLoading);

    loadChatList(
        // controller.pagingController.firstPageKey,
        cleanTheArray: showLoading);
  }
}
