// To parse this JSON data, do
//
//     final chatNotificationModel = chatNotificationModelFromJson(jsonString);

import 'dart:convert';

ChatNotificationModel chatNotificationModelFromJson(String str) =>
    ChatNotificationModel.fromJson(json.decode(str));

String chatNotificationModelToJson(ChatNotificationModel data) =>
    json.encode(data.toJson());

class ChatNotificationModel {
  ChatNotificationModel({
    this.purpose,
    this.chat,
    this.body,
    this.title,
    this.messageData,
  });

  String purpose;
  String chat;
  String body;
  String title;
  String messageData;

  ChatNotificationModel copyWith({
    String purpose,
    String chat,
    String body,
    String title,
    String messageData,
  }) =>
      ChatNotificationModel(
        purpose: purpose ?? this.purpose,
        chat: chat ?? this.chat,
        body: body ?? this.body,
        title: title ?? this.title,
        messageData: messageData ?? this.messageData,
      );

  factory ChatNotificationModel.fromRawJson(String str) =>
      ChatNotificationModel.fromJson(json.decode(str));
  factory ChatNotificationModel.fromJson(Map<String, dynamic> json) =>
      ChatNotificationModel(
        purpose: json["purpose"] == null ? null : json["purpose"],
        chat: json["chat"] == null ? null : json["chat"],
        body: json["body"] == null ? null : json["body"],
        title: json["title"] == null ? null : json["title"],
        messageData: json["messageData"] == null ? null : json["messageData"],
      );

  Map<String, dynamic> toJson() => {
        "purpose": purpose == null ? null : purpose,
        "chat": chat == null ? null : chat,
        "body": body == null ? null : body,
        "title": title == null ? null : title,
        "messageData": messageData == null ? null : messageData,
      };

  String toRawJson() => json.encode(toJson());
}

ChatNotificationMessageDataModel chatNotificationMessageDataModelFromJson(
        String str) =>
    ChatNotificationMessageDataModel.fromJson(json.decode(str));

String chatNotificationMessageDataModelToJson(
        ChatNotificationMessageDataModel data) =>
    json.encode(data.toJson());

class ChatNotificationMessageDataModel {
  ChatNotificationMessageDataModel({
    this.sender,
    this.content,
    this.chat,
    this.readBy,
  });

  String sender;
  String content;
  String chat;
  List<String> readBy;

  ChatNotificationMessageDataModel copyWith({
    String sender,
    String content,
    String chat,
    List<String> readBy,
  }) =>
      ChatNotificationMessageDataModel(
        sender: sender ?? this.sender,
        content: content ?? this.content,
        chat: chat ?? this.chat,
        readBy: readBy ?? this.readBy,
      );

  factory ChatNotificationMessageDataModel.fromJson(
          Map<String, dynamic> json) =>
      ChatNotificationMessageDataModel(
        sender: json["sender"] == null ? null : json["sender"],
        content: json["content"] == null ? null : json["content"],
        chat: json["chat"] == null ? null : json["chat"],
        readBy: json["readBy"] == null
            ? null
            : List<String>.from(json["readBy"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "sender": sender == null ? null : sender,
        "content": content == null ? null : content,
        "chat": chat == null ? null : chat,
        "readBy":
            readBy == null ? null : List<dynamic>.from(readBy.map((x) => x)),
      };
}
