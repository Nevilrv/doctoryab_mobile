// To parse this JSON data, do
//
//     final labsModel = labsModelFromJson(jsonString);

import 'dart:convert';

LabsModel labsModelFromJson(String str) => LabsModel.fromJson(json.decode(str));

String labsModelToJson(LabsModel data) => json.encode(data.toJson());

class LabsModel {
  LabsModel({
    this.data,
    this.count,
  });

  List<Labs> data;
  int count;

  LabsModel copyWith({
    List<Labs> data,
    int count,
  }) =>
      LabsModel(
        data: data ?? this.data,
        count: count ?? this.count,
      );

  factory LabsModel.fromJson(Map<String, dynamic> json) => LabsModel(
        data: json["data"] == null
            ? null
            : List<Labs>.from(json["data"].map((x) => Labs.fromJson(x))),
        count: json["count"] == null ? null : json["count"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count == null ? null : count,
      };
}

class Labs {
  Labs({
    this.id,
    this.geometry,
    this.photo,
    this.isDeleted,
    this.phone,
    this.times,
    this.name,
    this.city,
    this.address,
    this.createAt,
    this.v,
    this.checkUp,
  });

  String id;
  Geometry geometry;
  String photo;
  bool isDeleted;
  List<String> phone;
  List<List<DateTime>> times;
  String name;
  String city;
  String address;
  DateTime createAt;
  int v;
  List<CheckUp> checkUp;

  Labs copyWith({
    String id,
    Geometry geometry,
    String photo,
    bool isDeleted,
    List<String> phone,
    List<List<DateTime>> times,
    String name,
    String city,
    String address,
    DateTime createAt,
    int v,
    List<CheckUp> checkUp,
  }) =>
      Labs(
        id: id ?? this.id,
        geometry: geometry ?? this.geometry,
        photo: photo ?? this.photo,
        isDeleted: isDeleted ?? this.isDeleted,
        phone: phone ?? this.phone,
        times: times ?? this.times,
        name: name ?? this.name,
        city: city ?? this.city,
        address: address ?? this.address,
        createAt: createAt ?? this.createAt,
        v: v ?? this.v,
        checkUp: checkUp ?? this.checkUp,
      );

  factory Labs.fromJson(Map<String, dynamic> json) => Labs(
        id: json["_id"] == null ? null : json["_id"],
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
        photo: json["photo"] == null ? null : json["photo"],
        isDeleted: json["is_deleted"] == null ? null : json["is_deleted"],
        phone: json["phone"] == null
            ? null
            : List<String>.from(json["phone"].map((x) => x)),
        times: json["times"] == null
            ? null
            : List<List<DateTime>>.from(json["times"].map(
                (x) => List<DateTime>.from(x.map((x) => DateTime.parse(x))))),
        name: json["name"] == null ? null : json["name"],
        city: json["city"] == null ? null : json["city"],
        address: json["address"] == null ? null : json["address"],
        createAt:
            json["createAt"] == null ? null : DateTime.parse(json["createAt"]),
        v: json["__v"] == null ? null : json["__v"],
        checkUp: json["checkUp"] == null
            ? null
            : List<CheckUp>.from(
                json["checkUp"].map((x) => CheckUp.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "geometry": geometry == null ? null : geometry.toJson(),
        "photo": photo == null ? null : photo,
        "is_deleted": isDeleted == null ? null : isDeleted,
        "phone": phone == null ? null : List<dynamic>.from(phone.map((x) => x)),
        "times": times == null
            ? null
            : List<dynamic>.from(times.map(
                (x) => List<dynamic>.from(x.map((x) => x.toIso8601String())))),
        "name": name == null ? null : name,
        "city": city == null ? null : city,
        "address": address == null ? null : address,
        "createAt": createAt == null ? null : createAt.toIso8601String(),
        "__v": v == null ? null : v,
        "checkUp": checkUp == null
            ? null
            : List<dynamic>.from(checkUp.map((x) => x.toJson())),
      };
}

class CheckUp {
  CheckUp({
    this.isBrief,
    this.price,
    this.id,
    this.title,
    this.content,
    this.img,
  });

  bool isBrief;
  int price;
  String id;
  String title;
  String content;
  String img;

  CheckUp copyWith({
    bool isBrief,
    int price,
    String id,
    String title,
    String content,
    String img,
  }) =>
      CheckUp(
        isBrief: isBrief ?? this.isBrief,
        price: price ?? this.price,
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        img: img ?? this.img,
      );

  factory CheckUp.fromJson(Map<String, dynamic> json) => CheckUp(
        isBrief: json["is_brief"] == null ? null : json["is_brief"],
        price: json["price"] == null ? null : json["price"],
        id: json["_id"] == null ? null : json["_id"],
        title: json["title"] == null ? null : json["title"],
        content: json["content"] == null ? null : json["content"],
        img: json["img"] == null ? null : json["img"],
      );

  Map<String, dynamic> toJson() => {
        "is_brief": isBrief == null ? null : isBrief,
        "price": price == null ? null : price,
        "_id": id == null ? null : id,
        "title": title == null ? null : title,
        "content": content == null ? null : content,
        "img": img == null ? null : img,
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
        coordinates: json["coordinates"] == null
            ? null
            : List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "coordinates": coordinates == null
            ? null
            : List<dynamic>.from(coordinates.map((x) => x)),
      };
}
