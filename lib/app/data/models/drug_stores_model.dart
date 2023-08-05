// To parse this JSON data, do
//
//     final drugStoresModel = drugStoresModelFromJson(jsonString);

import 'dart:convert';

DrugStoresModel drugStoresModelFromJson(String str) =>
    DrugStoresModel.fromJson(json.decode(str));

String drugStoresModelToJson(DrugStoresModel data) =>
    json.encode(data.toJson());

class DrugStoresModel {
  DrugStoresModel({
    this.data,
    this.count,
  });

  List<DrugStore> data;
  int count;

  DrugStoresModel copyWith({
    List<DrugStore> data,
    int count,
  }) =>
      DrugStoresModel(
        data: data ?? this.data,
        count: count ?? this.count,
      );

  factory DrugStoresModel.fromJson(Map<String, dynamic> json) =>
      DrugStoresModel(
        data: json["data"] == null
            ? null
            : List<DrugStore>.from(
                json["data"].map((x) => DrugStore.fromJson(x))),
        count: json["count"] == null ? null : json["count"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count == null ? null : count,
      };
}

class DrugStore {
  DrugStore({
    this.id,
    this.geometry,
    this.photo,
    this.isDeleted,
    this.phone,
    this.times,
    this.the24Hours,
    this.name,
    this.city,
    this.address,
    this.createAt,
    this.v,
  });

  String id;
  Geometry geometry;
  String photo;
  bool isDeleted;
  List<String> phone;
  List<List<DateTime>> times;
  List<int> the24Hours;
  String name;
  String city;
  String address;
  DateTime createAt;
  int v;

  DrugStore copyWith({
    String id,
    Geometry geometry,
    String photo,
    bool isDeleted,
    List<String> phone,
    List<List<DateTime>> times,
    List<int> the24Hours,
    String name,
    String city,
    String address,
    DateTime createAt,
    int v,
  }) =>
      DrugStore(
        id: id ?? this.id,
        geometry: geometry ?? this.geometry,
        photo: photo ?? this.photo,
        isDeleted: isDeleted ?? this.isDeleted,
        phone: phone ?? this.phone,
        times: times ?? this.times,
        the24Hours: the24Hours ?? this.the24Hours,
        name: name ?? this.name,
        city: city ?? this.city,
        address: address ?? this.address,
        createAt: createAt ?? this.createAt,
        v: v ?? this.v,
      );

  factory DrugStore.fromJson(Map<String, dynamic> json) => DrugStore(
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
        the24Hours: json["_24Hours"] == null
            ? null
            : List<int>.from(json["_24Hours"].map((x) => x)),
        name: json["name"] == null ? null : json["name"],
        city: json["city"] == null ? null : json["city"],
        address: json["address"] == null ? null : json["address"],
        createAt:
            json["createAt"] == null ? null : DateTime.parse(json["createAt"]),
        v: json["__v"] == null ? null : json["__v"],
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
        "_24Hours": the24Hours == null
            ? null
            : List<dynamic>.from(the24Hours.map((x) => x)),
        "name": name == null ? null : name,
        "city": city == null ? null : city,
        "address": address == null ? null : address,
        "createAt": createAt == null ? null : createAt.toIso8601String(),
        "__v": v == null ? null : v,
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
