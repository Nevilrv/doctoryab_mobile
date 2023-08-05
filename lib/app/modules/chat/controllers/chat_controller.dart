import 'dart:convert';
import 'dart:developer';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/chat_list_api_model.dart';
import 'package:doctor_yab/app/data/models/chat_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../data/repository/ChatRepository.dart';

class ChatController extends GetxController {
  Rx<ChatListApiModel> chatArg = (Get.arguments as ChatListApiModel).obs;
  TextEditingController messageC = TextEditingController();
  //paging
  var page = 1;
  var nextPageLoading = false.obs;
  var endOfPage = false.obs;
  var chatsPerPageLimit = 20;
  // nextPageTrigger will have a value equivalent to 80% of the list size.
  var nextPageTrigger = 0.0;

  var messageToSend = "";

  ///
  //socket.io

  ///
  CancelToken chatCancelToken = CancelToken();
  CancelToken sendMessageCancelToken = CancelToken();
  var sendingMessage = false.obs;
  var sendingMessageFailed = false.obs;
  ChatApiModel lastFailedMessage;
  //

  ScrollController scrollC = ScrollController();
  RxList<ChatApiModel> chat = <ChatApiModel>[].obs;
  RxList<XFile> image = <XFile>[].obs;
  init() {
    // nextPageTrigger will have a value equivalent to 80% of the list size.

    Future.delayed(Duration.zero, () {
      scrollC.addListener(() {
        var nextPageTrigger = 0.8 * scrollC.position.maxScrollExtent;
        if (scrollC.hasClients &&
            scrollC.position.pixels > nextPageTrigger &&
            !nextPageLoading() &&
            !isLoading() &&
            !endOfPage()) {
          nextPageLoading.value = true;
          loadChatList(++page);
        }
      });
    });
  }

  var isLoading = true.obs;

  void sendMessage() async {
    sendingMessage(true);

    ChatRepository.sendMessage(chatArg().id, messageToSend,
        cancelToken: sendMessageCancelToken, onError: (e) {
      if (!(e is DioError && CancelToken.isCancel(e))) {
        // isLoading.value = false;
        Future.delayed(Duration(seconds: 2), () {
          sendMessageCancelToken.cancel();
          sendMessageCancelToken = CancelToken();
          sendMessage();
        });
      }
    }).then((value) {
      if (value != null) {
        // _trySocket() {
        //   if (socket.connected) {
        //     socket.emit("new message", value.toJson());
        //   } else {
        //     Future.delayed(Duration(seconds: 1), () {
        //       _trySocket();
        //     });
        //   }
        // }

        // _trySocket();
        if (socket.disconnected) {
          print("isDisconnected is true");
          sendingMessageFailed(true);
          lastFailedMessage = value;
          sendingMessage(true);
          socket.connect();
        } else {
          socket.emit("new message", value.toJson());
          sendingMessageFailed(false);
          sendingMessage(false);
        }
        // if (value.isEmpty) {
        //   endOfPage.value = true;
        // } else {
        chat.value.insert(0, value);
        //   log(value.toString());
        // }
        chat.refresh();
        // isLoading.value = false;
        // nextPageLoading(false);
        // //
      }
    }).catchError((e, s) {
      Logger().e("message", e, s);
    });
    // if (messageC.text.isNotEmpty || image.isNotEmpty) {
    //   isLoading.value = true;

    //   if (image != null && image.isNotEmpty) {
    //     await Future.delayed(Duration(seconds: 2));
    //   }
    //   List<String> sendImages = [];
    //   for (var img in image) {
    //     sendImages.add(base64Encode(await File(img.path).readAsBytes()));
    //   }
    //   Get.find<MessagesListController>().chats[index].messages = [
    //     MessageModel(
    //         message: messageC.text,
    //         isUsers: true,
    //         messageStatus: MessageStatus.sent,
    //         image: image != null && image.isNotEmpty ? sendImages : null),
    //     ...Get.find<MessagesListController>().chats[index].messages
    //   ];
    //   messageC.clear();
    //   image.value = [];
    //   isLoading.value = false;
    //   Get.find<MessagesListController>().chats.refresh();
    //   generateReply();
    // }
  }

  void _sendFailedMessages() {
    if (sendingMessageFailed()) {
      socket.emit("new message", lastFailedMessage.toJson());
      sendingMessageFailed(false);
      sendingMessage(false);
    }
  }

  // void generateReply() async {
  //   await Future.delayed(Duration(seconds: 1));
  //   Get.find<MessagesListController>()
  //       .chats[index]
  //       .messages
  //       .first
  //       .messageStatus = MessageStatus.seen;
  //   Get.find<MessagesListController>().chats.refresh();
  //   await Future.delayed(Duration(seconds: 1));
  //   var replies = [
  //     'Hello, its a test message?',
  //     'This is text message',
  //     'Hi! You have a appointment!',
  //     'Write your suggestion about the subject'
  //   ];
  //   Get.find<MessagesListController>().chats[index].messages = [
  //     MessageModel(
  //         message: replies[Random().nextInt(replies.length)],
  //         isUsers: false,
  //         messageStatus: MessageStatus.delivered,
  //         image: null),
  //     ...Get.find<MessagesListController>().chats[index].messages
  //   ];
  //   Get.find<MessagesListController>().chats.refresh();
  //   isLoading.value = false;
  // }
  Socket socket;
  initSocket() {
    socket = IO.io(ApiConsts.socketServerURL, <String, dynamic>{
      'autoConnect': true,
      'transports': ['websocket'],
    });
    socket.connect();
    socket.onConnect((_) {
      print('Connection established');
      socket.emit("join chat", chatArg()?.id);
      socket.emit("setup", {"_id": chatArg()?.id});
      _sendFailedMessages();
    });
    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err));

    //
    socket.on('message received', (m) {
      print("new message: ${m.runtimeType}");
      try {
        ///TODO have a note that we areforce removing this, because they dont match here
        m["readBy"] = [];
        if (m["chat"] != null) m["chat"]["users"] = [];
        // var _json = jsonDecode(m);
        // _json["readBy"] = [];
        log("json encoded: ${json.encode(m)}");
        var _msg = ChatApiModel.fromJson(m);

        chat.insert(0, _msg);
        chat.refresh();

        // scrollToEnd();
      } catch (e, s) {
        Logger().e("failed to add msg from socket", e, s);
      }
      // socket.emit(event)
      // try {
      //   Get.find<MessagesListController>().chats.refresh();
      // } catch (e) {}
    });
  }

  void scrollToEnd() {
    scrollC.animateTo(
      scrollC.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  void pickImage() async {
    image.value = await ImagePicker().pickMultiImage();
  }

  @override
  void onInit() {
    initSocket();
    super.onInit();
  }

  @override
  void onReady() {
    // scrollToEnd();

    super.onReady();
    loadChatList(1);
    init();
  }

  @override
  void onClose() {
    socket.disconnect();
    socket.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    if (messageC != null) {
      messageC.dispose();
    }
    scrollC.dispose();
    chatCancelToken.cancel();
    super.dispose();
  }

  Future<void> loadChatList(int p) async {
    ChatRepository.fetchChatsById(chatArg().id,
        cancelToken: chatCancelToken,
        page: p,
        limitPerPage: chatsPerPageLimit, onError: (e) {
      if (!(e is DioError && CancelToken.isCancel(e))) {
        // isLoading.value = false;
        Future.delayed(Duration(seconds: 2), () {
          chatCancelToken.cancel();
          chatCancelToken = CancelToken();
          loadChatList(page);
        });
      }
    }).then((value) {
      if (value != null) {
        if (value.isEmpty) {
          endOfPage.value = true;
        } else {
          chat.value.addAll(value);
          log(value.toString());
        }
        chat.refresh();
        isLoading.value = false;
        nextPageLoading(false);
        //
      }
    }).catchError((e, s) {
      Logger().e("message", e, s);
    });
  }

  void swithChat(ChatListApiModel chatListApiModel) {
    chatArg.value = chatListApiModel;

    //

    page = 1;
    nextPageLoading.value = false;
    endOfPage.value = false;
    chatsPerPageLimit = 20;
    // nextPageTrigger will have a value equivalent to 80% of the list size.
    nextPageTrigger = 0.0;

    messageToSend = "";

    ///
    //socket.io

    chatCancelToken.cancel();
    sendMessageCancelToken.cancel();

    ///
    chatCancelToken = CancelToken();
    sendMessageCancelToken = CancelToken();
    sendingMessage(false);
    sendingMessageFailed(false);
    lastFailedMessage = null;
    //

    chat.clear();
    messageC.clear();
    isLoading.value = true;

    socket.disconnect();
    socket.connect();
    loadChatList(1);
  }
}
