import 'dart:convert';
import 'dart:developer';
import 'package:doctor_yab/app/data/models/chat_notification_model.dart';
import 'package:doctor_yab/app/services/chat_notification_handler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../data/models/notification_payload_model.dart';
import '../modules/home/views/blog/tab_blog_view.dart';
import '../modules/hospital_new/tab_main/bindings/tab_main_binding.dart';
import '../routes/app_pages.dart';

class PushNotificationService {
  var _init = false;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );
  // Chat
  static var _notificationType = NotificationType.rate;
  NotificationType get notificationType => _notificationType;
  ChatNotificationModel chatNotification;

  //TODO this commit must be tested
  Future initialise() async {
    if (_init) return;
    _init = true;
    _fcm.requestPermission();
    var androidInitilize =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSinitilize = new DarwinInitializationSettings();
    var initilizationsSettings = new InitializationSettings(
        android: androidInitilize, iOS: iOSinitilize);
    flutterLocalNotificationsPlugin.initialize(
      initilizationsSettings,
      onDidReceiveNotificationResponse: (n) =>
          onDidReceiveNotificationResponse(n),
      // onDidReceiveBackgroundNotificationResponse:
      //     onDidReceiveNotificationResponse,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    // If you want to test the push notification locally,
    // you need to get the token and input to the Firebase console
    // https://console.firebase.google.com/project/YOUR_PROJECT_ID/notification/compose
    String token = await _fcm.getToken();
    log("FirebaseMessaging token: $token");

    FirebaseMessaging.onMessage.listen(fcmListener);
    // FirebaseMessaging.onBackgroundMessage(fcmListener);
    FirebaseMessaging.onMessageOpenedApp.listen((element) {
      // notificationSelected(jsonEncode(element.data ?? {}));
    });
  }

  ///
  bool get isInitDone => _init;

  ///

  Future<void> fcmListener(RemoteMessage message) async {
    RemoteNotification notification = message.notification;
    AndroidNotification android = message.notification?.android;

    log("fcm_data: ${jsonEncode(message.data)}");
    log("fcm_data: ${message.data}");
    // print(Doctor.fromJson(json.decode(message?.data['doctor'] ?? "{}") ?? {})
    //     .name);
    //
    if (message.data != null) {
      if (message.data["purpose"] != null &&
          message.data["purpose"] == "send-message") {
        _notificationType = NotificationType.message;
        log("it is a message   ${message.messageId}");
        try {
          chatNotification = ChatNotificationModel.fromJson(message.data);

          ChatNotificationHandler.handle(
            chatNotification,
            NotificationPayloadModel(
                data: chatNotification.toRawJson(),
                id: message.messageId,
                type: "$_notificationType"),
          );
        } catch (e, s) {
          Logger().e("Failed to decode the message JSON", e, s);
        }
      } else if (message.data["purpose"] != null &&
          message.data["purpose"] == "appointment-reminder") {
        await flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          message.data["title"],
          message.data["body"],
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: '@mipmap/ic_launcher',
            ),
          ),
          payload: jsonEncode(message.data ?? {}),
        );
      } else {
        await flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          message.data["title"],
          message.data["body"],
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: '@mipmap/ic_launcher',
            ),
          ),
          payload: jsonEncode(message.data ?? {}),
        );
        // _notificationType = NotificationType.rate;

        log("it is not a message");
      }
    }

    ///

    if (notification != null && android != null) {
      await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: jsonEncode(message.data ?? {}),
      );
    }
    //TODO implement IOS Push Notifications
  }

  // Future onDidReceiveNotificationResponse(String payload) async {
  Future<void> onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    log("opened $notificationType ${_notificationType.hashCode}    ${notificationType.hashCode}  ");
    log("opened ${notificationResponse.id}");
    log("opened ${notificationResponse.payload}");

    // Get.to(() => RateView());

    if (notificationResponse.payload != null) {
      NotificationPayloadModel payload =
          NotificationPayloadModel.fromRawJson(notificationResponse.payload);
      log("payload.type---->${payload.type}");
      log("payload.type---->${payload.data}");

      var data = jsonDecode(notificationResponse.payload);

      if (data['purpose'] == 'appointment-reminder') {
        Get.toNamed(Routes.APPOINTMENT_HISTORY);
      } else if (data['purpose'] == "Lab-Report-reminder") {
        Get.toNamed(Routes.REPORT_MEDICAL, arguments: {'id': "1"});
      } else if (data['purpose'] == 'prescription-reminder') {
        Get.toNamed(Routes.REPORT_MEDICAL, arguments: {'id': "0"});
      } else if (data['purpose'] == 'Blog-reminder') {
        Get.to(() => TabBlogView(),
            binding: TabMainBinding(), arguments: {'id': 'notification'});
      } else if (data['purpose'] == 'send-message') {
        ChatNotificationHandler.handleClick(
            ChatNotificationModel.fromRawJson(payload.data));
      } else {}
      log("data------------->${data['purpose']}");
      // if (payload.type == "${NotificationType.rate}")
      //   Get.toNamed(Routes.RATE, arguments: notificationResponse.payload);
      // else if (payload.type == "${NotificationType.message}")
      //   ChatNotificationHandler.handleClick(ChatNotificationModel.fromRawJson(payload.data));
    }
  }

  Future<void> showNotification(
      String title, String content, NotificationPayloadModel payLoad) async {
    await flutterLocalNotificationsPlugin.show(
      content.hashCode,
      title,
      content,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: '@mipmap/ic_launcher',
        ),
      ),
      payload: payLoad.toRawJson(),
    );
  }
}

enum NotificationType {
  message,
  rate,
}
