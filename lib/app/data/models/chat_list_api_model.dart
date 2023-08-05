// To parse this JSON data, do
//
//     final chatListApiModel = chatListApiModelFromJson(jsonString);

import 'dart:convert';

List<ChatListApiModel> chatListApiModelFromJson(String str) =>
    List<ChatListApiModel>.from(
        json.decode(str).map((x) => ChatListApiModel.fromJson(x)));

String chatListApiModelToJson(List<ChatListApiModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatListApiModel {
  bool isGroupChat;
  List<User> users;
  String id;
  String chatName;
  String reason;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  LatestMessage latestMessage;

  ChatListApiModel({
    this.isGroupChat,
    this.users,
    this.id,
    this.chatName,
    this.reason,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.latestMessage,
  });

  ChatListApiModel copyWith({
    bool isGroupChat,
    List<User> users,
    String id,
    String chatName,
    String reason,
    DateTime createdAt,
    DateTime updatedAt,
    int v,
    LatestMessage latestMessage,
  }) =>
      ChatListApiModel(
        isGroupChat: isGroupChat ?? this.isGroupChat,
        users: users ?? this.users,
        id: id ?? this.id,
        chatName: chatName ?? this.chatName,
        reason: reason ?? this.reason,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
        latestMessage: latestMessage ?? this.latestMessage,
      );

  factory ChatListApiModel.fromJson(Map<String, dynamic> json) =>
      ChatListApiModel(
        isGroupChat: json["isGroupChat"],
        users:
            List<User>.from(json["users"].map((x) => User.fromJson(x))) ?? null,
        id: json["_id"],
        chatName: json["chatName"],
        reason: json["reason"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        latestMessage: LatestMessage.fromJson(json["latestMessage"]),
      );

  Map<String, dynamic> toJson() => {
        "isGroupChat": isGroupChat,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "_id": id,
        "chatName": chatName,
        "reason": reason,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "latestMessage": latestMessage.toJson(),
      };
}

class LatestMessage {
  List<dynamic> images;
  List<String> readBy;
  String id;
  User sender;
  String content;
  String chat;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  LatestMessage({
    this.images,
    this.readBy,
    this.id,
    this.sender,
    this.content,
    this.chat,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  LatestMessage copyWith({
    List<dynamic> images,
    List<String> readBy,
    String id,
    User sender,
    String content,
    String chat,
    DateTime createdAt,
    DateTime updatedAt,
    int v,
  }) =>
      LatestMessage(
        images: images ?? this.images,
        readBy: readBy ?? this.readBy,
        id: id ?? this.id,
        sender: sender ?? this.sender,
        content: content ?? this.content,
        chat: chat ?? this.chat,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory LatestMessage.fromJson(Map<String, dynamic> json) => LatestMessage(
        images: List<dynamic>.from(json["images"].map((x) => x)),
        readBy: List<String>.from(json["readBy"].map((x) => x)),
        id: json["_id"],
        sender: User.fromJson(json["sender"]) ?? null,
        content: json["content"],
        chat: json["chat"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "images": List<dynamic>.from(images.map((x) => x)),
        "readBy": List<dynamic>.from(readBy.map((x) => x)),
        "_id": id,
        "sender": sender.toJson(),
        "content": content,
        "chat": chat,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class User {
  String id;
  Email email;
  DateTime createAt;
  int v;
  // Geometry geometry;
  String photo;
  String phone;
  String fcm;
  String patientId;
  int age;
  String name;

  User({
    this.id,
    this.email,
    this.createAt,
    this.v,
    // this.geometry,
    this.photo,
    this.phone,
    this.fcm,
    this.patientId,
    this.age,
    this.name,
  });

  User copyWith({
    String id,
    Email email,
    DateTime createAt,
    int v,
    // Geometry geometry,
    String photo,
    String phone,
    String fcm,
    String patientId,
    int age,
    String name,
  }) =>
      User(
        id: id ?? this.id,
        email: email ?? this.email,
        createAt: createAt ?? this.createAt,
        v: v ?? this.v,
        // geometry: geometry ?? this.geometry,
        photo: photo ?? this.photo,
        phone: phone ?? this.phone,
        fcm: fcm ?? this.fcm,
        patientId: patientId ?? this.patientId,
        age: age ?? this.age,
        name: name ?? this.name,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"] ?? "",
        email: emailValues.map[json["email"]] ?? null,
        createAt: DateTime.parse(json["createAt"]) ?? null,
        v: json["__v"] ?? null,
        // geometry: Geometry.fromJson(json["geometry"]) ?? null,
        photo: json["photo"] ?? null,
        phone: json["phone"] ?? null,
        fcm: json["fcm"] ?? null,
        patientId: json["patientID"] ?? null,
        age: json["age"] ?? null,
        name: json["name"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": emailValues.reverse[email],
        "createAt": createAt.toIso8601String(),
        "__v": v,
        // "geometry": geometry.toJson(),
        "photo": photo,
        "phone": phone,
        "fcm": fcm,
        "patientID": patientId,
        "age": age,
        "name": name,
      };
}

enum Email { DOCTORYAB_GMAIL_COM, PAYAMHABIBZADA_GMAIL_COM, DEV_DOCTORYAB_INFO }

final emailValues = EnumValues({
  "dev@doctoryab.info": Email.DEV_DOCTORYAB_INFO,
  "doctoryab@gmail.com": Email.DOCTORYAB_GMAIL_COM,
  "Payamhabibzada@gmail.com": Email.PAYAMHABIBZADA_GMAIL_COM
});

// class Geometry {
//   String type;
//   List<double> coordinates;

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

//   factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
//         type: json["type"] ?? null,
//         coordinates:
//             List<double>.from(json["coordinates"].map((x) => x.toDouble())),
//       );

//   Map<String, dynamic> toJson() => {
//         "type": type,
//         "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
//       };
// }

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
