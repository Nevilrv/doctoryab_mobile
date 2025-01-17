import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/chat_list_api_model.dart';
import 'package:doctor_yab/app/data/models/chat_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:just_audio/just_audio.dart' as j;
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import '../../../data/repository/ChatRepository.dart';

class ChatController extends GetxController {
  Rx<ChatListApiModel>? chatArg;
  TextEditingController messageC = TextEditingController();
  //paging
  var page = 1;
  var nextPageLoading = false.obs;
  var endOfPage = false.obs;
  var tapAttachment = false.obs;
  var attachmentString = "".obs;
  var chatsPerPageLimit = 16;
  // nextPageTrigger will have a value equivalent to 80% of the list size.
  var nextPageTrigger = 0.0;
  Timer? timer;
  int start = 0;
  String minute = "00";
  String second = "00";
  var messageToSend = "";

  FlutterSoundRecorder? recordingSession;
  final recordingPlayer = AssetsAudioPlayer();
  String? pathToAudio;
  var playAudio = false.obs;
  var playRecord = false.obs;
  var timerText = '00:00:00'.obs;
  List<StreamSubscription> _subscriptions = [];

  void initializer() async {
    final directory = await getApplicationDocumentsDirectory();
    log("directory.path--------------> ${directory.path}");

    pathToAudio = '${directory.path}/temp.wav';
    recordingSession = FlutterSoundRecorder();

    // await recordingSession?.openAudioSession(
    //     focus: AudioFocus.requestFocusAndStopOthers,
    //     category: SessionCategory.playAndRecord,
    //     mode: SessionMode.modeDefault,
    //     device: AudioDevice.speaker);

    await recordingSession!.openRecorder();

    await recordingSession!.setSubscriptionDuration(Duration(milliseconds: 10));
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
    start = 0;
    minute = "00";
    second = "00";
    playRecord.value = true;
    update();
    // Directory directory = Directory(path.dirname(pathToAudio));
    // if (!directory.existsSync()) {
    //   directory.createSync();
    // }

    if (pathToAudio == null) {
      final directory = await getApplicationDocumentsDirectory();

      pathToAudio = '${directory.path}/temp.wav';
      recordingSession = FlutterSoundRecorder();
      recordingSession!.openRecorder();
      await recordingSession!.startRecorder(
        toFile: pathToAudio,
        codec: Codec.pcm16WAV,
      );
    } else {
      recordingSession!.openRecorder();
      await recordingSession!.startRecorder(
        toFile: pathToAudio,
        codec: Codec.pcm16WAV,
      );
    }

    StreamSubscription _recorderSubscription =
        recordingSession!.onProgress!.listen((e) {
      var date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds,
          isUtc: true);
      var timeText = DateFormat('mm:ss:SS', 'en_GB').format(date);
      log('timeText ---------->>>>>>>> ${timeText}');
      // timerText.value = timeText.substring(0, 8);
      update();
    });
    _recorderSubscription.cancel();

    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      start++;
      formattedTime(timeInSecond: start);
    });
    update();
  }

  formattedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    minute = min.toString().length <= 1 ? "0$min" : "$min";
    second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    update();
  }

  Future<String?> stopRecording() async {
    timer?.cancel();
    playRecord.value = false;

    recordingSession?.closeRecorder();
    update();
    return await recordingSession!.stopRecorder();
  }

  Future pauseRecording() async {
    playRecord.value = false;
    // recordingSession.closeAudioSession();
    recordingSession!.pauseRecorder();
    update();
  }

  Future resumeRecording() async {
    playRecord.value = true;
    // recordingSession.closeAudioSession();
    recordingSession!.resumeRecorder();
    update();
  }

  Future<void> playFunc() async {
    await recordingPlayer
        .open(
      Audio.file(pathToAudio!),
      autoStart: true,
      showNotification: true,
    )
        .then((value) {
      // log("value--------------->${value}");
    });
    recordingPlayer.play();
    // recordingPlayer.playOrPause();
    duration1 = recordingPlayer.realtimePlayingInfos.value.duration;

    // recordingPlayer.realtimePlayingInfos.listen((event) {
    //   log('------event Duration-----${event.currentPosition}');
    //   position1 = event.currentPosition;
    // });

    update();
  }

  Future<void> stopPlayFunc() async {
    // recordingPlayer.pause();
    recordingPlayer.stop();
  }

  List<int> hi = [
    5,
    9,
    14,
    10,
    20,
    15,
    10,
    5,
    9,
    14,
    20,
    8,
    25,
    12,
    20,
    14,
    9,
    9,
    14,
    20,
    9,
    14,
    10,
    20,
    15,
    10,
    5,
    8,
    25,
    12,
    20,
    14,
    9,
    14,
    10,
    20,
    15,
    10,
    5
  ];

  int selectedIndex = -1;
  final audioPlayer1 = ap.AudioPlayer();
  StreamSubscription<void>? playerStateChangedSubscription1;
  StreamSubscription<Duration>? durationChangedSubscription1;
  StreamSubscription<Duration>? positionChangedSubscription1;
  Duration? position1;
  Duration? duration1;
  int current1 = -1;
  int current2 = -1;
  int? voiceTrackRowSize;
  String convertTime(int time) {
    int centiseconds = (time % 1000) ~/ 10;
    time ~/= 1000;
    int seconds = time % 60;
    time ~/= 60;
    int minutes = time % 60;
    time ~/= 60;
    int hours = time;
    if (hours > 0) {
      return "$hours:${_twoDigits(minutes)}:${seconds.toString().padLeft(2, '0')}";
    } else if (minutes > 0) {
      return "$minutes:${seconds.toString().padLeft(2, '0')}";
    } else {
      return "00:${seconds.toString().padLeft(2, '0')}";
    }
  }

  String _twoDigits(int time) {
    return "${time < 10 ? '0' : ''}$time";
  }

  Future<void> play1({String? path}) {
    if (path == '') {
    } else {
      return audioPlayer1.play(ap.UrlSource(path!));
    }
    return audioPlayer1.stop();
  }

  String? voiceDuration;

  Future<String?> getVoiceDuration({String? url}) async {
    final player = j.AudioPlayer();
    var duration = await player.setUrl(url!);

    if (duration == null) {
      voiceDuration = '0';
      update();
      return voiceDuration;
    } else {
      voiceDuration =
          "${duration.inMinutes.toString()}:${duration.inSeconds.toString()}";
      update();
      return voiceDuration;
    }
  }

  Future<void> pause1() => audioPlayer1.pause();

  Future<void> stop1() async {
    audioPlayer1.stop();
  }

  bool isPause1 = false;
  Timer? timers1;
  //socket.io
  CancelToken chatCancelToken = CancelToken();
  CancelToken sendMessageCancelToken = CancelToken();
  var sendingMessage = false.obs;
  var sendingMessageFailed = false.obs;
  ChatApiModel? lastFailedMessage;

  ScrollController scrollC = ScrollController();
  RxList<ChatApiModel> chat = <ChatApiModel>[].obs;
  RxList<XFile> image = <XFile>[].obs;

  var pdfFile = "".obs;
  init() {
    chat.clear();
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
    update();
    if (messageToSend != '') {
      log('chatArg!().id.toString() ---------->>>>>>>> ${chatArg!().id.toString()}');
      ChatRepository.sendMessage(chatArg!().id.toString(), messageToSend,
          cancelToken: sendMessageCancelToken, onError: (e) {
        if (!(e is DioError && CancelToken.isCancel(e))) {
          // isLoading.value = false;
          Future.delayed(Duration(seconds: 2), () {
            sendMessageCancelToken.cancel();
            sendMessageCancelToken = CancelToken();
            sendMessage();
          });
        }
        update();
      }).then((value) {
        if (socket!.disconnected) {
          print("isDisconnected is true");
          sendingMessageFailed(true);
          lastFailedMessage = value;
          sendingMessage(true);
          socket!.connect();
        } else {
          socket!.emit("new message", value.toJson());
          sendingMessageFailed(false);
          sendingMessage(false);
        }
        chat.value.insert(0, value);
        chat.refresh();
        update();
      }).catchError((e, s) {
        Logger().e("message", e, s);
        update();
      });
    }
    if (attachmentString.value == "image") {
      sendingMessage(true);
      update();
      if (image.isNotEmpty) {
        try {
          image.forEach((element) {
            ChatRepository()
                .uploadImage(file: File(element.path))
                .then((value) {
              ChatRepository.sendMessage(chatArg!().id.toString(), "",
                  images: value,
                  type: attachmentString.value,
                  cancelToken: sendMessageCancelToken, onError: (e) {
                if (!(e is DioError && CancelToken.isCancel(e))) {
                  // isLoading.value = false;
                  Future.delayed(Duration(seconds: 2), () {
                    sendMessageCancelToken.cancel();
                    sendMessageCancelToken = CancelToken();
                    sendMessage();
                  });
                  update();
                }
              }).then((value) {
                if (value != null) {
                  if (socket!.disconnected) {
                    print("isDisconnected is true");
                    sendingMessageFailed(true);
                    lastFailedMessage = value;
                    sendingMessage(true);
                    socket!.connect();
                  } else {
                    socket!.emit("new message", value.toJson());
                    sendingMessageFailed(false);
                    sendingMessage(false);
                  }
                  chat.value.insert(0, value);
                  chat.refresh();
                  update();
                }
              }).catchError((e, s) {
                Logger().e("message", e, s);
                update();
              });
              image.clear();
              attachmentString.value = "";
              sendingMessage(false);
              update();
            });
          });
        } catch (e) {
          sendingMessage(false);
          update();
        }
      }
    }
    if (attachmentString.value == "voice") {
      position1 = null;
      duration1 = null;
      selectedIndex = -1;
      current1 = -1;
      voiceTrackRowSize = hi.length;

      isPause1 = false;
      if (timers1 != null) {
        timers1!.cancel();
      }

      await audioPlayer1.pause();
      await audioPlayer1.stop();
      update();
      if (playRecord.value == true) {
        log('hello-------------------------stop recording');
        await stopRecording();
      }
      update();

      sendingMessage(true);
      update();
      try {
        if (pathToAudio!.isNotEmpty) {
          ChatRepository().uploadAudio(file: File(pathToAudio!)).then((value) {
            ChatRepository.sendMessage(chatArg!().id.toString(), "",
                images: value,
                type: attachmentString.value,
                cancelToken: sendMessageCancelToken, onError: (e) {
              if (!(e is DioError && CancelToken.isCancel(e))) {
                // isLoading.value = false;
                Future.delayed(
                  Duration(seconds: 2),
                  () {
                    sendMessageCancelToken.cancel();
                    sendMessageCancelToken = CancelToken();
                    sendMessage();
                  },
                );
                update();
              }
            }).then((value) {
              if (socket!.disconnected) {
                sendingMessageFailed(true);
                lastFailedMessage = value;
                sendingMessage(true);
                socket!.connect();
              } else {
                socket!.emit("new message", value.toJson());
                sendingMessageFailed(false);
                sendingMessage(false);
              }
              chat.value.insert(0, value);
              chat.refresh();
              update();
            }).catchError((e, s) {
              Logger().e("message", e, s);
              update();
            });
            pathToAudio = null;
            attachmentString.value = "";
            sendingMessage(false);
            update();
          });
        }
      } catch (e) {
        sendingMessage(false);
      }
    }
    if (attachmentString.value == "pdf") {
      sendingMessage(true);
      update();
      try {
        if (pdfFile.value != "") {
          ChatRepository().uploadPDF(file: File(pdfFile.value)).then(
            (value) {
              ChatRepository.sendMessage(chatArg!().id.toString(), "",
                  images: value,
                  type: attachmentString.value,
                  cancelToken: sendMessageCancelToken, onError: (e) {
                if (!(e is DioError && CancelToken.isCancel(e))) {
                  Future.delayed(Duration(seconds: 2), () {
                    sendMessageCancelToken.cancel();
                    sendMessageCancelToken = CancelToken();
                    sendMessage();
                  });
                  update();
                }
              }).then(
                (value) {
                  if (value != null) {
                    if (socket!.disconnected) {
                      print("isDisconnected is true");
                      sendingMessageFailed(true);
                      lastFailedMessage = value;
                      sendingMessage(true);
                      socket!.connect();
                    } else {
                      socket!.emit("new message", value.toJson());
                      sendingMessageFailed(false);
                      sendingMessage(false);
                    }
                    chat.value.insert(0, value);
                    chat.refresh();
                    update();
                  }
                },
              ).catchError(
                (e, s) {
                  sendingMessage(false);
                  Logger().e("message", e, s);
                  update();
                },
              );
              pdfFile.value = "";
              attachmentString.value = "";
              sendingMessage(false);
              update();
            },
          ).catchError(
            (e, s) {
              sendingMessage(false);
              Logger().e("message", e, s);
              update();
            },
          );
        }
      } catch (e) {
        sendingMessage(false);
        update();
      }
    }
    update();
  }

  void _sendFailedMessages() {
    if (sendingMessageFailed()) {
      socket!.emit("new message", lastFailedMessage!.toJson());
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

  Socket? socket;

  initSocket() {
    socket = IO.io(ApiConsts.socketServerURL, <String, dynamic>{
      'autoConnect': true,
      'transports': ['websocket'],
    });
    socket!.connect();
    socket!.onConnect((_) {
      log('Connection established');
      socket!.emit("join chat", chatArg!().id);
      socket!.emit("setup", {"_id": chatArg!().id});

      _sendFailedMessages();
    });
    socket!.onDisconnect((_) => print('Connection Disconnection'));
    socket!.onConnectError((err) => print(err));
    socket!.onError((err) => print(err));

    //
    socket!.on('message received', (m) {
      try {
        ///TODO have a note that we areforce removing this, because they dont match here
        m["readBy"] = [];
        if (m["chat"] != null) m["chat"]["users"] = [];
        // var _json = jsonDecode(m);
        // _json["readBy"] = [];

        var _msg = ChatApiModel.fromJson(m);

        chat.insert(0, _msg);
        update();

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
      duration: const Duration(milliseconds: 250),
    );
  }

  void pickImage() async {
    XFile? value = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (value != null) {
      image.add(value);
    } else {
      attachmentString.value = '';
    }
    update();
  }

  void pickCameraImage() async {
    XFile? value = await ImagePicker().pickImage(source: ImageSource.camera);
    if (value != null) {
      image.add(value);
    } else {
      attachmentString.value = '';
    }
    update();
  }

  void pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false);
    pdfFile.value = result!.files[0].path!;
    update();
  }

  onInitCall() {
    chatArg = (Get.arguments as ChatListApiModel).obs;
    chat.clear();
    loadChatList(1);
    init();
    // initSocket();
    voiceTrackRowSize = hi.length;

    playerStateChangedSubscription1 =
        audioPlayer1.onPlayerComplete.listen((state) async {
      await stop1();
      update();
    });

    positionChangedSubscription1 =
        audioPlayer1.onPositionChanged.listen((position) {
      position1 = position;
      update();
    });
    durationChangedSubscription1 =
        audioPlayer1.onDurationChanged.listen((duration) {
      duration1 = duration;
      update();
    });
    update();
  }

  @override
  void onInit() {
    chatArg = (Get.arguments as ChatListApiModel).obs;
    initSocket();
    voiceTrackRowSize = hi.length;

    playerStateChangedSubscription1 =
        audioPlayer1.onPlayerComplete.listen((state) async {
      await stop1();
    });

    positionChangedSubscription1 =
        audioPlayer1.onPositionChanged.listen((position) {
      position1 = position;
    });

    durationChangedSubscription1 =
        audioPlayer1.onDurationChanged.listen((duration) {
      duration1 = duration;
    });
    super.onInit();
  }

  @override
  void onReady() {
    // scrollToEnd();
    super.onReady();
    chat.clear();
    loadChatList(1);
    // init();
  }

  @override
  void onClose() {
    socket!.disconnect();
    socket!.dispose();
    playerStateChangedSubscription1!.cancel();
    positionChangedSubscription1!.cancel();
    durationChangedSubscription1!.cancel();
    audioPlayer1.dispose();
    if (timers1 != null) {
      timers1!.cancel();
    }
    super.onClose();
  }

  @override
  void dispose() {
    if (messageC != null) {
      messageC.dispose();
    }
    scrollC.dispose();
    chatCancelToken.cancel();
    recordingPlayer.dispose();
    super.dispose();
  }

  // Future<double> getFileDuration(String mediaPath) async {
  //   // final mediaInfoSession = await FFprobeKit.getMediaInformation(mediaPath);
  //   // final mediaInfo = mediaInfoSession.getMediaInformation();
  //   //
  //   // // the given duration is in fractional seconds
  //   // final duration = double.parse(mediaInfo.getDuration());
  //   // print('Duration: $duration');
  //   return duration;
  // }
  List<String> voiceDurationList = [];
  Future<void> loadChatList(int p) async {
    ChatRepository.fetchChatsById(chatArg!().id.toString(),
        cancelToken: chatCancelToken,
        page: p,
        limitPerPage: chatsPerPageLimit, onError: (e) {
      if (!(e is DioError && CancelToken.isCancel(e))) {
        // isLoading.value = false;
        Future.delayed(Duration(seconds: 2), () {
          chatCancelToken.cancel();
          chatCancelToken = CancelToken();
          chat.clear();
          loadChatList(page);
        });
      }
    }).then((value) {
      // log("value--------------> ${value[0]}");

      if (value != null) {
        if (value.isEmpty) {
          endOfPage.value = true;
        } else {
          chat.clear();
          chat.addAll(value);
          chat.forEach((element) async {
            if (element.voiceNotes!.isEmpty) {
              voiceDurationList.add('0');
            } else {
              String? d = await getVoiceDuration(
                  url: '${ApiConsts.hostUrl}${element.voiceNotes![0]}');
              voiceDurationList.add(d!);

              log('-------ELEMENET----$voiceDurationList');
            }
          });
          // chat.forEach((element) {
          //   getVoiceDuration()
          // });
        }
        chat.refresh();
        isLoading.value = false;
        nextPageLoading(false);
        update();
      }
    }).catchError((e, s) {
      Logger().e("message", e, s);
    });

    update();
  }

  void swithChat(ChatListApiModel chatListApiModel) {
    chatArg!.value = chatListApiModel;
    //
    page = 1;
    nextPageLoading.value = false;
    endOfPage.value = false;
    chatsPerPageLimit = 16;
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
    socket!.disconnect();
    socket!.connect();
    loadChatList(1);
  }
}
