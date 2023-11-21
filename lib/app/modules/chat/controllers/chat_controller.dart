import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/chat_list_api_model.dart';
import 'package:doctor_yab/app/data/models/chat_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:intl/intl.dart' show DateFormat;
import '../../../data/repository/ChatRepository.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path/path.dart' as path;

class ChatController extends GetxController {
  Rx<ChatListApiModel> chatArg = (Get.arguments as ChatListApiModel).obs;
  TextEditingController messageC = TextEditingController();
  //paging
  var page = 1;
  var nextPageLoading = false.obs;
  var endOfPage = false.obs;
  var tapAttachment = false.obs;
  var attachmentString = "".obs;
  var chatsPerPageLimit = 20;
  // nextPageTrigger will have a value equivalent to 80% of the list size.
  var nextPageTrigger = 0.0;

  var messageToSend = "";

  FlutterSoundRecorder recordingSession;
  final recordingPlayer = AssetsAudioPlayer();
  String pathToAudio;
  var playAudio = false.obs;
  var playRecord = false.obs;
  var timerText = '00:00:00'.obs;
  List<StreamSubscription> _subscriptions = [];
  void initializer() async {
    pathToAudio = '/sdcard/Download/temp.wav';
    recordingSession = FlutterSoundRecorder();

    await recordingSession.openAudioSession(
        focus: AudioFocus.requestFocusAndStopOthers,
        category: SessionCategory.playAndRecord,
        mode: SessionMode.modeDefault,
        device: AudioDevice.speaker);
    await recordingSession.setSubscriptionDuration(Duration(milliseconds: 10));
    await initializeDateFormatting();
    await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
    _subscriptions.add(recordingPlayer.playlistAudioFinished.listen((data) {
      print('playlistAudioFinished : $data');
      playAudio.value = false;
    }));
  }

  Future<void> startRecording() async {
    playRecord.value = true;
    Directory directory = Directory(path.dirname(pathToAudio));
    if (!directory.existsSync()) {
      directory.createSync();
    }
    recordingSession.openAudioSession();
    await recordingSession.startRecorder(
      toFile: pathToAudio,
      codec: Codec.pcm16WAV,
    );

    StreamSubscription _recorderSubscription =
        recordingSession.onProgress.listen((e) {
      log("e.duration.inMilliseconds--------------> ${e.duration.inMilliseconds}");

      var date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds,
          isUtc: true);
      var timeText = DateFormat('mm:ss:SS', 'en_GB').format(date);
      log("timeText--------------> ${timeText}");

      timerText.value = timeText.substring(0, 8);
      update();
    });
    _recorderSubscription.cancel();
    update();
  }

  Future<String> stopRecording() async {
    playRecord.value = false;
    recordingSession.closeAudioSession();
    update();
    return await recordingSession.stopRecorder();
    update();
  }

  Future<void> playFunc() async {
    log("recordingPlayer.isPlaying-------------->11 ${recordingPlayer.playerState.value}");
    await recordingPlayer
        .open(
      Audio.file(pathToAudio),
      autoStart: true,
      showNotification: true,
    )
        .then((value) {
      log("recordingPlayer.isPlaying--------------df> ${recordingPlayer.playerState.value}");
    });

    // if (recordingPlayer.is == true) {
    //   playAudio.value = false;
    // }
  }

  Future<void> stopPlayFunc() async {
    recordingPlayer.stop();
  }

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
  var pdfFile = "".obs;
  init() {
    // nextPageTrigger will have a value equivalent to 80% of the list size.
    initializer();
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
    if (messageToSend != '') {
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
    }
    if (attachmentString.value == "image") {
      sendingMessage(true);
      if (image.isNotEmpty) {
        try {
          image.forEach((element) {
            ChatRepository()
                .uploadImage(file: File(element.path))
                .then((value) {
              log("value--------------> ${value}");
              image.clear();
              attachmentString.value = "";
              sendingMessage(false);
              update();
            });
          });
        } catch (e) {
          sendingMessage(false);
          log("e--------------> ${e}");
        }
      }
    }
    if (attachmentString.value == "voice") {
      sendingMessage(true);
      log("pathToAudio--------------> ${pathToAudio}");

      try {
        if (pathToAudio.isNotEmpty) {
          ChatRepository()
              .uploadAudio(file: Audio.file(pathToAudio))
              .then((value) {
            log("value--------------> ${value}");
            pathToAudio = null;
            attachmentString.value = "";
            sendingMessage(false);
            update();
          });
        }
      } catch (e) {
        sendingMessage(false);
        log("e--------------> ${e}");
      }
    }

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
        log("_msg------------ encoded: ${json.encode(m)}");
        var _msg = ChatApiModel.fromJson(m);
        log("_msg--------------> ${_msg}");

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

  void pickCameraImage() async {
    XFile value = await ImagePicker().pickImage(source: ImageSource.camera);
    image.add(value);
  }

  void pickPdf() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false);
    pdfFile.value = result.files[0].path;
    update();
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
      log("value--------------> ${value}");

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
