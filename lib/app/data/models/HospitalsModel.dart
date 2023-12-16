// To parse this JSON data, do
//
//     final hospitalsModel = hospitalsModelFromJson(jsonString);

import 'dart:convert';
import 'labs_model.dart';

HospitalsModel hospitalModelFromJson(String str) =>
    HospitalsModel.fromJson(json.decode(str));

String hospitalModelToJson(HospitalsModel data) => json.encode(data.toJson());

class HospitalsModel {
  HospitalsModel({
    this.data,
  });

  final List<Hospital> data;

  HospitalsModel copyWith({
    List<Hospital> data,
  }) =>
      HospitalsModel(
        data: data ?? this.data,
      );

  factory HospitalsModel.fromJson(Map<String, dynamic> json) => HospitalsModel(
        data: json["data"] == null
            ? null
            : List<Hospital>.from(
                json["data"].map((x) => Hospital.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Hospital {
  Hospital({
    this.id,
    this.geometry,
    this.photo,
    this.type,
    this.times,
    this.description,
    this.email,
    this.address,
    this.name,
    this.city,
    this.phone,
    this.createAt,
    this.checkUp,
    this.v,
    this.stars,
    this.usersStaredCount,
    this.checkUps,
    this.isEmergency,
    this.active,
    this.totalFeedbacks,
    this.averageRatings,
  });

  final String id;
  final Geometry geometry;
  final String photo;
  final int type;
  final List<List<DateTime>> times;
  final String description;
  final String email;
  final String address;
  final String name;
  final String city;
  final String phone;
  final bool isEmergency;
  final DateTime createAt;
  final List<CheckUp> checkUp;
  final int v;
  final double stars;
  final int usersStaredCount;
  final List<dynamic> checkUps;
  final bool active;
  dynamic totalFeedbacks;
  dynamic averageRatings;

  Hospital copyWith({
    String id,
    Geometry geometry,
    String photo,
    int type,
    List<List<DateTime>> times,
    String description,
    String email,
    String address,
    String name,
    String city,
    String phone,
    DateTime createAt,
    List<CheckUp> checkUp,
    int v,
    double stars,
    bool isEmergency,
    int usersStaredCount,
    dynamic totalFeedbacks,
    dynamic averageRatings,
    List<dynamic> checkUps,
    bool active,
  }) =>
      Hospital(
        id: id ?? this.id,
        geometry: geometry ?? this.geometry,
        photo: photo ?? this.photo,
        type: type ?? this.type,
        times: times ?? this.times,
        description: description ?? this.description,
        email: email ?? this.email,
        address: address ?? this.address,
        name: name ?? this.name,
        city: city ?? this.city,
        phone: phone ?? this.phone,
        createAt: createAt ?? this.createAt,
        checkUp: checkUp ?? this.checkUp,
        v: v ?? this.v,
        stars: stars ?? this.stars,
        usersStaredCount: usersStaredCount ?? this.usersStaredCount,
        checkUps: checkUps ?? this.checkUps,
        isEmergency: isEmergency ?? this.isEmergency,
        active: active ?? this.active,
        totalFeedbacks: totalFeedbacks ?? this.totalFeedbacks,
        averageRatings: averageRatings ?? this.averageRatings,
      );

  factory Hospital.fromJson(Map<String, dynamic> json) => Hospital(
        id: json["_id"] == null ? null : json["_id"],
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
        photo: json["photo"] == null ? null : json["photo"],
        type: json["type"] == null ? null : json["type"],
        times: json["times"] == null
            ? null
            : List<List<DateTime>>.from(json["times"].map(
                (x) => List<DateTime>.from(x.map((x) => DateTime.parse(x))))),
        description: json["description"] == null ? null : json["description"],
        email: json["email"] == null ? null : json["email"],
        address: json["address"] == null ? null : json["address"],
        name: json["name"] == null ? null : json["name"],
        city: json["city"] == null ? null : json["city"],
        phone: json["phone"] == null ? null : json["phone"],
        createAt:
            json["createAt"] == null ? null : DateTime.parse(json["createAt"]),
        checkUp: json["checkUp"] == null
            ? null
            : List<CheckUp>.from(
                json["checkUp"].map((x) => CheckUp.fromJson(x))),
        v: json["__v"] == null ? null : json["__v"],
        stars: json["stars"] == null ? null : json["stars"].toDouble(),
        isEmergency:
            json["is_emergency"] == null ? false : json["is_emergency"],
        usersStaredCount: json["users_stared_count"] == null
            ? null
            : json["users_stared_count"],
        checkUps: json["CheckUps"] == null
            ? null
            : List<dynamic>.from(json["CheckUps"].map((x) => x)),
        active: json["active"] == null ? false : json["active"],
        totalFeedbacks:
            json["totalFeedbacks"] == null ? null : json["totalFeedbacks"],
        averageRatings:
            json["averageRatings"] == null ? null : json["averageRatings"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "geometry": geometry == null ? null : geometry.toJson(),
        "photo": photo == null ? null : photo,
        "type": type == null ? null : type,
        "times": times == null
            ? null
            : List<dynamic>.from(times.map(
                (x) => List<dynamic>.from(x.map((x) => x.toIso8601String())))),
        "description": description == null ? null : description,
        "email": email == null ? null : email,
        "address": address == null ? null : address,
        "name": name == null ? null : name,
        "city": city == null ? null : city,
        "phone": phone == null ? null : phone,
        "createAt": createAt == null ? null : createAt.toIso8601String(),
        "is_emergency": isEmergency == null ? false : isEmergency,
        "checkUp": checkUp == null
            ? null
            : List<dynamic>.from(checkUp.map((x) => x.toJson())),
        "__v": v == null ? null : v,
        "stars": stars == null ? null : stars,
        "active": active == null ? false : active,
        "users_stared_count":
            usersStaredCount == null ? null : usersStaredCount,
        "CheckUps": checkUps == null
            ? null
            : List<dynamic>.from(checkUps.map((x) => x)),
        "totalFeedbacks": totalFeedbacks == null ? null : totalFeedbacks,
        "averageRatings": averageRatings == null ? null : averageRatings,
      };
}
