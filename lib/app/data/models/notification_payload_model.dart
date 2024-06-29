// To parse this JSON data, do
//
//     final notificationPayloadModel = notificationPayloadModelFromJson(jsonString);

import 'dart:convert';

class NotificationPayloadModel {
  NotificationPayloadModel({
    this.id,
    this.type,
    this.data,
  });

  String? id;
  String? type;
  String? data;

  NotificationPayloadModel copyWith({
    String? id,
    String? type,
    String? data,
  }) =>
      NotificationPayloadModel(
        id: id ?? this.id,
        type: type ?? this.type,
        data: data ?? this.data,
      );

  factory NotificationPayloadModel.fromRawJson(String str) =>
      NotificationPayloadModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationPayloadModel.fromJson(Map<String, dynamic> json) =>
      NotificationPayloadModel(
        id: json["id"],
        type: json["type"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "data": data,
      };
}
