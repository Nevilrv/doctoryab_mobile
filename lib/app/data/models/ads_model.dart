// To parse this JSON data, do
//
//     final adsModel = adsModelFromJson(jsonString);

import 'dart:convert';

AdsModel adsModelFromJson(String str) => AdsModel.fromJson(json.decode(str));

String adsModelToJson(AdsModel data) => json.encode(data.toJson());

class AdsModel {
  AdsModel({
    this.data,
  });

  List<Ad>? data;

  AdsModel copyWith({
    List<Ad>? data,
  }) =>
      AdsModel(
        data: data ?? this.data,
      );

  factory AdsModel.fromJson(Map<String, dynamic> json) => AdsModel(
        data: json["data"] == null
            ? null
            : List<Ad>.from(json["data"].map((x) => Ad.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Ad {
  Ad({
    this.id,
    this.img,
    this.displayed,
    this.isDeleted,
    this.isPublic,
    this.city,
    this.createAt,
    this.link,
    this.v,
  });

  String? id;
  String? img;
  int? displayed;
  bool? isDeleted;
  bool? isPublic;
  List<String>? city;
  DateTime? createAt;
  String? link;
  int? v;

  Ad copyWith({
    String? id,
    String? img,
    int? displayed,
    bool? isDeleted,
    bool? isPublic,
    List<String>? city,
    DateTime? createAt,
    String? link,
    int? v,
  }) =>
      Ad(
        id: id ?? this.id,
        img: img ?? this.img,
        displayed: displayed ?? this.displayed,
        isDeleted: isDeleted ?? this.isDeleted,
        isPublic: isPublic ?? this.isPublic,
        city: city ?? this.city,
        createAt: createAt ?? this.createAt,
        link: link ?? this.link,
        v: v ?? this.v,
      );

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        id: json["_id"] == null ? null : json["_id"],
        img: json["img"] == null ? null : json["img"],
        displayed: json["displayed"] == null ? null : json["displayed"],
        isDeleted: json["is_deleted"] == null ? null : json["is_deleted"],
        isPublic: json["is_public"] == null ? null : json["is_public"],
        city: json["city"] == null
            ? null
            : List<String>.from(json["city"].map((x) => x)),
        createAt:
            json["createAt"] == null ? null : DateTime.parse(json["createAt"]),
        link: json["link"] == null ? null : json["link"],
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "img": img == null ? null : img,
        "displayed": displayed == null ? null : displayed,
        "is_deleted": isDeleted == null ? null : isDeleted,
        "is_public": isPublic == null ? null : isPublic,
        "city": city == null ? null : List<dynamic>.from(city!.map((x) => x)),
        "createAt": createAt == null ? null : createAt!.toIso8601String(),
        "link": link == null ? null : link,
        "__v": v == null ? null : v,
      };
}
