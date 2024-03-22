// import 'package:flutter/cupertino.dart';

// class ChatModel {
//   String sendarName;
//   String senderImage;
//   Status status = Status.online;
//   List<MessageModel> messages = [];
//   ChatModel(
//       {@required this.sendarName,
//       this.status,
//       @required this.senderImage,
//       this.messages});
// }

// class Status {
//   String _value;
//   Status._(String val) {
//     _value = val;
//   }
//   @override
//   String toString() {
//     return _value;
//   }

//   static Status online = Status._('online');
//   static Status offline = Status._('offline');
// }

// class MessageStatus {
//   String _value;
//   MessageStatus._(String val) {
//     _value = val;
//   }
//   @override
//   String toString() {
//     return _value;
//   }

//   static MessageStatus delivered = MessageStatus._('delivered');
//   static MessageStatus sent = MessageStatus._('sent');
//   static MessageStatus seen = MessageStatus._('seen');
// }

// class MessageModel {
//   String message;
//   bool isUsers;
//   List<String> image;
//   MessageStatus messageStatus = MessageStatus.seen;

//   DateTime dateTime = DateTime.now();
//   MessageModel(
//       {@required this.message,
//       @required this.isUsers,
//       this.image,
//       this.messageStatus});
// }
// To parse this JSON data, do
//
//     final chatApiModel = chatApiModelFromJson(jsonString);

//////////////////////////////////
///
// import 'dart:convert';

// import '../../controllers/settings_controller.dart';

// List<ChatApiModel> chatApiModelFromJson(String str) => List<ChatApiModel>.from(
//     json.decode(str).map((x) => ChatApiModel.fromJson(x)));

// class ChatApiModel {
//   final List<dynamic> images;
//   final List<String> readBy;
//   final String id;
//   final Sender sender;
//   final String content;
//   final Chat chat;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   ChatApiModel({
//     this.images,
//     this.readBy,
//     this.id,
//     this.sender,
//     this.content,
//     this.chat,
//     this.createdAt,
//     this.updatedAt,
//   });

//   ChatApiModel copyWith({
//     List<dynamic> images,
//     List<String> readBy,
//     String id,
//     Sender sender,
//     String content,
//     Chat chat,
//     DateTime createdAt,
//     DateTime updatedAt,
//   }) =>
//       ChatApiModel(
//         images: images ?? this.images,
//         readBy: readBy ?? this.readBy,
//         id: id ?? this.id,
//         sender: sender ?? this.sender,
//         content: content ?? this.content,
//         chat: chat ?? this.chat,
//         createdAt: createdAt ?? this.createdAt,
//         updatedAt: updatedAt ?? this.updatedAt,
//       );

//   factory ChatApiModel.fromRawJson(String str) =>
//       ChatApiModel.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory ChatApiModel.fromJson(Map<String, dynamic> json) => ChatApiModel(
//         images: List<dynamic>.from(json["images"].map((x) => x)),
//         readBy: List<String>.from(json["readBy"].map((x) => x)),
//         id: json["_id"],
//         sender: Sender.fromJson(json["sender"]),
//         content: json["content"],
//         chat: Chat.fromJson(json["chat"]),
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "images": List<dynamic>.from(images.map((x) => x)),
//         "readBy": List<dynamic>.from(readBy.map((x) => x)),
//         "_id": id,
//         "sender": sender.toJson(),
//         "content": content,
//         "chat": chat.toJson(),
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//       };

//   bool get isUsersMessage {
//     var cond = (this?.sender?.patientId ?? "") !=
//         SettingsController.savedUserProfile.patientID;

//     return cond;
//   }
// }

// class Chat {
//   final bool isGroupChat;
//   final List<String> users;
//   final String id;
//   final String chatName;
//   final String reason;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final String latestMessage;

//   Chat({
//     this.isGroupChat,
//     this.users,
//     this.id,
//     this.chatName,
//     this.reason,
//     this.createdAt,
//     this.updatedAt,
//     this.latestMessage,
//   });

//   Chat copyWith({
//     bool isGroupChat,
//     List<String> users,
//     String id,
//     String chatName,
//     String reason,
//     DateTime createdAt,
//     DateTime updatedAt,
//     String latestMessage,
//   }) =>
//       Chat(
//         isGroupChat: isGroupChat ?? this.isGroupChat,
//         users: users ?? this.users,
//         id: id ?? this.id,
//         chatName: chatName ?? this.chatName,
//         reason: reason ?? this.reason,
//         createdAt: createdAt ?? this.createdAt,
//         updatedAt: updatedAt ?? this.updatedAt,
//         latestMessage: latestMessage ?? this.latestMessage,
//       );

//   factory Chat.fromRawJson(String str) => Chat.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Chat.fromJson(Map<String, dynamic> json) => Chat(
//         isGroupChat: json["isGroupChat"],
//         users: List<String>.from(json["users"].map((x) => x)),
//         id: json["_id"],
//         chatName: json["chatName"],
//         reason: json["reason"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         latestMessage: json["latestMessage"],
//       );

//   Map<String, dynamic> toJson() => {
//         "isGroupChat": isGroupChat,
//         "users": List<dynamic>.from(users.map((x) => x)),
//         "_id": id,
//         "chatName": chatName,
//         "reason": reason,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "latestMessage": latestMessage,
//       };
// }

// class Sender {
//   final Geometry geometry;
//   final String photo;
//   final String id;
//   final String phone;
//   final String fcm;
//   final DateTime createAt;
//   final String patientId;
//   final int age;
//   final String name;

//   Sender({
//     this.geometry,
//     this.photo,
//     this.id,
//     this.phone,
//     this.fcm,
//     this.createAt,
//     this.patientId,
//     this.age,
//     this.name,
//   });

//   Sender copyWith({
//     Geometry geometry,
//     String photo,
//     String id,
//     String phone,
//     String fcm,
//     DateTime createAt,
//     String patientId,
//     int age,
//     String name,
//   }) =>
//       Sender(
//         geometry: geometry ?? this.geometry,
//         photo: photo ?? this.photo,
//         id: id ?? this.id,
//         phone: phone ?? this.phone,
//         fcm: fcm ?? this.fcm,
//         createAt: createAt ?? this.createAt,
//         patientId: patientId ?? this.patientId,
//         age: age ?? this.age,
//         name: name ?? this.name,
//       );

//   factory Sender.fromRawJson(String str) => Sender.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Sender.fromJson(Map<String, dynamic> json) => Sender(
//         geometry: Geometry.fromJson(json["geometry"]),
//         photo: json["photo"],
//         id: json["_id"],
//         phone: json["phone"],
//         fcm: json["fcm"],
//         createAt: DateTime.parse(json["createAt"]),
//         patientId: json["patientID"],
//         age: json["age"],
//         name: json["name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "geometry": geometry.toJson(),
//         "photo": photo,
//         "_id": id,
//         "phone": phone,
//         "fcm": fcm,
//         "createAt": createAt.toIso8601String(),
//         "patientID": patientId,
//         "age": age,
//         "name": name,
//       };
// }

// class Geometry {
//   final String type;
//   final List<double> coordinates;

//   Geometry({
//     this.type,
//     this.coordinates,
//   });

//   Geometry copyWith({
//     String type,
//     List<double> coordinates,
//   }) =>
//       Geometry(
//         type: type ?? this.type,
//         coordinates: coordinates ?? this.coordinates,
//       );

//   factory Geometry.fromRawJson(String str) =>
//       Geometry.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
//         type: json["type"],
//         coordinates:
//             List<double>.from(json["coordinates"].map((x) => x.toDouble())),
//       );

//   Map<String, dynamic> toJson() => {
//         "type": type,
//         "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
//       };
// }

// To parse this JSON data, do
//
//     final chatApiModel = chatApiModelFromJson(jsonString);

import 'dart:convert';
import 'dart:developer';

import 'package:just_audio/just_audio.dart';

import '../../controllers/settings_controller.dart';

final player = AudioPlayer();
List<ChatApiModel> chatApiModelFromJson(String str) =>
    List<ChatApiModel>.from(json.decode(str).map((x) => ChatApiModel.fromJson(x)));

String chatApiModelToJson(List<ChatApiModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatApiModel {
  ChatApiModel({
    this.images,
    this.voiceNotes,
    this.documents,
    this.readBy,
    this.id,
    this.sender,
    this.content,
    this.chat,
    this.createdAt,
    this.updatedAt,
    this.isRead = false,
  });

  List<dynamic> images;
  List<dynamic> voiceNotes;
  List<dynamic> documents;
  List<String> readBy;
  String id;
  Sender sender;
  String content;
  Chat chat;
  DateTime createdAt;
  DateTime updatedAt;
  bool isRead;

  ChatApiModel copyWith({
    List<dynamic> images,
    List<dynamic> voiceNotes,
    List<dynamic> documents,
    List<String> readBy,
    String id,
    Sender sender,
    String content,
    Chat chat,
    DateTime createdAt,
    DateTime updatedAt,
  }) =>
      ChatApiModel(
        images: images ?? this.images,
        voiceNotes: voiceNotes ?? this.voiceNotes,
        documents: documents ?? this.documents,
        readBy: readBy ?? this.readBy,
        id: id ?? this.id,
        sender: sender ?? this.sender,
        content: content ?? this.content,
        chat: chat ?? this.chat,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ChatApiModel.fromJson(Map<String, dynamic> json) => ChatApiModel(
        images: json["images"] == null ? null : List<dynamic>.from(json["images"].map((x) => x)),
        voiceNotes: json["voiceNotes"] == null ? null : List<dynamic>.from(json["voiceNotes"].map((x) => x)),
        documents: json["documents"] == null ? null : List<dynamic>.from(json["documents"].map((x) => x)),
        readBy: json["readBy"] == null ? null : List<String>.from(json["readBy"].map((x) => x)),
        id: json["_id"] == null ? null : json["_id"],
        sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
        content: json["content"] == null ? null : json["content"],
        chat: json["chat"] == null ? null : Chat.fromJson(json["chat"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "images": images == null ? null : List<dynamic>.from(images.map((x) => x)),
        "voiceNotes": voiceNotes == null ? null : List<dynamic>.from(voiceNotes.map((x) => x)),
        "documents": documents == null ? null : List<dynamic>.from(documents.map((x) => x)),
        "readBy": readBy == null ? null : List<dynamic>.from(readBy.map((x) => x)),
        "_id": id == null ? null : id,
        "sender": sender == null ? null : sender.toJson(),
        "content": content == null ? null : content,
        "chat": chat == null ? null : chat.toJson(),
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
  bool get isUsersMessage {
    log("SettingsController.savedUserProfile.patientID--------------> ${SettingsController.savedUserProfile.patientID}");
    log("this?.sender?.patientId--------------> ${this?.sender?.patientId}");

    var cond = this?.sender?.patientId == null
        ? false
        : (this?.sender?.patientId ?? "") == SettingsController.savedUserProfile.patientID;
    log('-cond-------$cond');
    return cond;
  }
}

Future<String> getVoiceDuration({String url}) async {
  log("url---------->${url}");

  var voiceDuration;
  var duration = await player.setUrl(url);

  if (duration == null) {
    voiceDuration = '0';

    log("voiceDuration------>${voiceDuration}");
    return voiceDuration;
  } else {
    voiceDuration = "${duration.inMinutes.toString()}:${duration.inSeconds.toString()}";
    log("voiceDuration------>${voiceDuration}");

    return voiceDuration;
  }
}

class Chat {
  Chat({
    this.isGroupChat,
    this.users,
    this.id,
    this.chatName,
    this.reason,
    this.createdAt,
    this.updatedAt,
    this.latestMessage,
  });

  bool isGroupChat;
  List<String> users;
  String id;
  String chatName;
  String reason;
  DateTime createdAt;
  DateTime updatedAt;
  String latestMessage;

  Chat copyWith({
    bool isGroupChat,
    List<String> users,
    String id,
    String chatName,
    String reason,
    DateTime createdAt,
    DateTime updatedAt,
    String latestMessage,
  }) =>
      Chat(
        isGroupChat: isGroupChat ?? this.isGroupChat,
        users: users ?? this.users,
        id: id ?? this.id,
        chatName: chatName ?? this.chatName,
        reason: reason ?? this.reason,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        latestMessage: latestMessage ?? this.latestMessage,
      );

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        isGroupChat: json["isGroupChat"] == null ? null : json["isGroupChat"],
        users: json["users"] == null ? null : List<String>.from(json["users"].map((x) => x)),
        id: json["_id"] == null ? null : json["_id"],
        chatName: json["chatName"] == null ? null : json["chatName"],
        reason: json["reason"] == null ? null : json["reason"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        latestMessage: json["latestMessage"] == null ? null : json["latestMessage"],
      );

  Map<String, dynamic> toJson() => {
        "isGroupChat": isGroupChat == null ? null : isGroupChat,
        "users": users == null ? null : List<dynamic>.from(users.map((x) => x)),
        "_id": id == null ? null : id,
        "chatName": chatName == null ? null : chatName,
        "reason": reason == null ? null : reason,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "latestMessage": latestMessage == null ? null : latestMessage,
      };
}

class Sender {
  Sender({
    this.geometry,
    this.photo,
    this.id,
    this.phone,
    this.fcm,
    this.createAt,
    this.patientId,
    this.age,
    this.name,
  });

  Geometry geometry;
  String photo;
  String id;
  String phone;
  String fcm;
  DateTime createAt;
  String patientId;
  int age;
  String name;

  Sender copyWith({
    Geometry geometry,
    String photo,
    String id,
    String phone,
    String fcm,
    DateTime createAt,
    String patientId,
    int age,
    String name,
  }) =>
      Sender(
        geometry: geometry ?? this.geometry,
        photo: photo ?? this.photo,
        id: id ?? this.id,
        phone: phone ?? this.phone,
        fcm: fcm ?? this.fcm,
        createAt: createAt ?? this.createAt,
        patientId: patientId ?? this.patientId,
        age: age ?? this.age,
        name: name ?? this.name,
      );

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        geometry: json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]),
        photo: json["photo"] == null ? null : json["photo"],
        id: json["_id"] == null ? null : json["_id"],
        phone: json["phone"] == null ? null : json["phone"],
        fcm: json["fcm"] == null ? null : json["fcm"],
        createAt: json["createAt"] == null ? null : DateTime.parse(json["createAt"]),
        patientId: json["patientID"] == null ? null : json["patientID"],
        age: json["age"] == null ? null : json["age"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "geometry": geometry == null ? null : geometry.toJson(),
        "photo": photo == null ? null : photo,
        "_id": id == null ? null : id,
        "phone": phone == null ? null : phone,
        "fcm": fcm == null ? null : fcm,
        "createAt": createAt == null ? null : createAt.toIso8601String(),
        "patientID": patientId == null ? null : patientId,
        "age": age == null ? null : age,
        "name": name == null ? null : name,
      };
}

class Geometry {
  Geometry({
    this.type,
    this.coordinates,
  });

  String type;
  List<double> coordinates;

  Geometry copyWith({
    String type,
    List<double> coordinates,
  }) =>
      Geometry(
        type: type ?? this.type,
        coordinates: coordinates ?? this.coordinates,
      );

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"] == null ? null : json["type"],
        coordinates:
            json["coordinates"] == null ? null : List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "coordinates": coordinates == null ? null : List<dynamic>.from(coordinates.map((x) => x)),
      };
}
