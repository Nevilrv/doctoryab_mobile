// To parse this JSON data, do
//
//     final drugDatabaseModel = drugDatabaseModelFromJson(jsonString);

import 'dart:convert';

DrugDatabaseModel drugDatabaseModelFromJson(String str) =>
    DrugDatabaseModel.fromJson(json.decode(str));

String drugDatabaseModelToJson(DrugDatabaseModel data) =>
    json.encode(data.toJson());

class DrugDatabaseModel {
  List<Datum> data;
  int count;
  int unVerifiedCount;

  DrugDatabaseModel({
    this.data,
    this.count,
    this.unVerifiedCount,
  });

  factory DrugDatabaseModel.fromJson(Map<String, dynamic> json) =>
      DrugDatabaseModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        count: json["count"],
        unVerifiedCount: json["unVerifiedCount"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count,
        "unVerifiedCount": unVerifiedCount,
      };
}

class Datum {
  bool verified;
  bool active;
  String img;
  String id;
  String englishName;
  String persianName;
  String genericName;
  String barcode;
  String therapeuticClass;
  String pharmacologicClass;
  String usage;
  String usageEnglish;
  String sideEffectsEnglish;
  String sideEffects;
  String dosages;
  String packsAndPrices;
  String wholeSalePrice;
  String warnings;
  String company;
  String origin;
  String notes;
  String drugType;
  String pack;
  AdminId adminId;
  String createdAt;
  String updatedAt;
  int v;

  Datum({
    this.verified,
    this.active,
    this.img,
    this.id,
    this.englishName,
    this.persianName,
    this.genericName,
    this.barcode,
    this.therapeuticClass,
    this.pharmacologicClass,
    this.usage,
    this.usageEnglish,
    this.sideEffectsEnglish,
    this.sideEffects,
    this.dosages,
    this.packsAndPrices,
    this.wholeSalePrice,
    this.warnings,
    this.company,
    this.origin,
    this.notes,
    this.drugType,
    this.pack,
    this.adminId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        verified: json["verified"],
        active: json["active"],
        img: json["img"],
        id: json["_id"],
        englishName: json["englishName"],
        persianName: json["persianName"],
        genericName: json["genericName"],
        barcode: json["barcode"],
        therapeuticClass: json["therapeuticClass"],
        pharmacologicClass: json["pharmacologicClass"],
        usage: json["usage"],
        usageEnglish: json["usageEnglish"],
        sideEffectsEnglish: json["sideEffectsEnglish"],
        sideEffects: json["sideEffects"],
        dosages: json["dosages"],
        packsAndPrices: json["packsAndPrices"],
        wholeSalePrice: json["wholeSalePrice"],
        warnings: json["warnings"],
        company: json["company"],
        origin: json["origin"],
        notes: json["notes"],
        drugType: json["drugType"],
        pack: json["pack"],
        adminId: AdminId.fromJson(json["adminId"]),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "verified": verified,
        "active": active,
        "img": img,
        "_id": id,
        "englishName": englishName,
        "persianName": persianName,
        "genericName": genericName,
        "barcode": barcode,
        "therapeuticClass": therapeuticClass,
        "pharmacologicClass": pharmacologicClass,
        "usage": usage,
        "usageEnglish": usageEnglish,
        "sideEffectsEnglish": sideEffectsEnglish,
        "sideEffects": sideEffects,
        "dosages": dosages,
        "packsAndPrices": packsAndPrices,
        "wholeSalePrice": wholeSalePrice,
        "warnings": warnings,
        "company": company,
        "origin": origin,
        "notes": notes,
        "drugType": drugType,
        "pack": pack,
        "adminId": adminId.toJson(),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
      };
}

class AdminId {
  String name;
  String id;
  String email;

  AdminId({
    this.name,
    this.id,
    this.email,
  });

  factory AdminId.fromJson(Map<String, dynamic> json) => AdminId(
        name: json["name"],
        id: json["_id"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "_id": id,
        "email": email,
      };
}
