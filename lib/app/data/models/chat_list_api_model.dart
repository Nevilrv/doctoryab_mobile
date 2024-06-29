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
  bool? isGroupChat;
  List<User>? users;
  List<dynamic>? documents;
  String? id;
  String? chatName;
  String? reason;
  String? createdAt;
  String? updatedAt;
  int? v;
  LatestMessage? latestMessage;
  String? status;

  ChatListApiModel({
    this.isGroupChat,
    this.users,
    this.documents,
    this.id,
    this.chatName,
    this.reason,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.latestMessage,
    this.status,
  });

  factory ChatListApiModel.fromJson(Map<String, dynamic> json) =>
      ChatListApiModel(
        isGroupChat: json["isGroupChat"],
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
        documents: List<dynamic>.from(json["documents"].map((x) => x)),
        id: json["_id"],
        chatName: json["chatName"],
        reason: json["reason"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
        latestMessage: json["latestMessage"] == null
            ? null
            : LatestMessage.fromJson(json["latestMessage"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "isGroupChat": isGroupChat,
        "users": List<dynamic>.from(users!.map((x) => x.toJson())),
        "documents": List<dynamic>.from(documents!.map((x) => x)),
        "_id": id,
        "chatName": chatName,
        "reason": reason,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
        "latestMessage": latestMessage!.toJson(),
        "status": status,
      };
}

class LatestMessage {
  List<dynamic>? images;
  List<dynamic>? voiceNotes;
  List<dynamic>? documents;
  List<String>? readBy;
  String? id;
  String? content;
  String? chat;
  String? createdAt;
  String? updatedAt;
  int? v;
  Sender? sender;

  LatestMessage({
    this.images,
    this.voiceNotes,
    this.documents,
    this.readBy,
    this.id,
    this.content,
    this.chat,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.sender,
  });

  factory LatestMessage.fromJson(Map<String, dynamic> json) => LatestMessage(
        images: json["images"] == null
            ? null
            : List<dynamic>.from(json["images"].map((x) => x)),
        voiceNotes: json["voiceNotes"] == null
            ? null
            : List<dynamic>.from(json["voiceNotes"].map((x) => x)),
        documents: json["documents"] == null
            ? null
            : List<dynamic>.from(json["documents"].map((x) => x)),
        readBy: List<String>.from(json["readBy"].map((x) => x)),
        id: json["_id"],
        content: json["content"],
        chat: json["chat"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
        sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
      );

  Map<String, dynamic> toJson() => {
        "images": List<dynamic>.from(images!.map((x) => x)),
        "voiceNotes": List<dynamic>.from(voiceNotes!.map((x) => x)),
        "documents": List<dynamic>.from(documents!.map((x) => x)),
        "readBy": List<dynamic>.from(readBy!.map((x) => x)),
        "_id": id,
        "content": content,
        "chat": chat,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
        "sender": sender?.toJson(),
      };
}

class Sender {
  Geometry? geometry;
  String? photo;
  String? id;
  String? phone;
  String? fcm;
  String? createAt;
  String? patientId;
  int? v;
  int? age;
  String? name;

  Sender({
    this.geometry,
    this.photo,
    this.id,
    this.phone,
    this.fcm,
    this.createAt,
    this.patientId,
    this.v,
    this.age,
    this.name,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
        photo: json["photo"],
        id: json["_id"],
        phone: json["phone"],
        fcm: json["fcm"],
        createAt: json["createAt"],
        patientId: json["patientID"],
        v: json["__v"],
        age: json["age"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "geometry": geometry!.toJson(),
        "photo": photo,
        "_id": id,
        "phone": phone,
        "fcm": fcm,
        "createAt": createAt,
        "patientID": patientId,
        "__v": v,
        "age": age,
        "name": name,
      };
}

class Geometry {
  String? type;
  List<double>? coordinates;

  Geometry({
    this.type,
    this.coordinates,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"] == null ? null : json["type"],
        coordinates: json["coordinates"] == null
            ? null
            : List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "coordinates": coordinates == null
            ? null
            : List<dynamic>.from(coordinates!.map((x) => x)),
      };
}

class User {
  Geometry? geometry;
  String? photo;
  String? id;
  String? phone;
  String? fcm;
  String? createAt;
  String? patientId;
  int? v;
  int? age;
  String? name;
  List<String>? routes;
  String? email;

  User({
    this.geometry,
    this.photo,
    this.id,
    this.phone,
    this.fcm,
    this.createAt,
    this.patientId,
    this.v,
    this.age,
    this.name,
    this.routes,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
        photo: json["photo"],
        id: json["_id"],
        phone: json["phone"],
        fcm: json["fcm"],
        createAt: json["createAt"],
        patientId: json["patientID"],
        v: json["__v"],
        age: json["age"],
        name: json["name"],
        routes: json["routes"] == null
            ? []
            : List<String>.from(json["routes"].map((x) => x)),
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "geometry": geometry?.toJson(),
        "photo": photo,
        "_id": id,
        "phone": phone,
        "fcm": fcm,
        "createAt": createAt,
        "patientID": patientId,
        "__v": v,
        "age": age,
        "name": name,
        "routes":
            routes == null ? [] : List<dynamic>.from(routes!.map((x) => x)),
        "email": email,
      };
}
