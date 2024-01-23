// To parse this JSON data, do
//
//     final drugDatabaseModel = drugDatabaseModelFromJson(jsonString);

import 'dart:convert';

import '../../controllers/settings_controller.dart';

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

  ///based on app language
  String name;
  String pashtoName;
  String englishName;
  String persianName;

  String genericName;
  String barcode;
  String therapeuticClass;
  String pharmacologicClass;
  String usage;
  String usageEnglish;
  String usageDari;
  String usagePashto;
  String sideEffectsEnglish;
  String sideEffectsDari;
  String sideEffectsPashto;
  String sideEffects;
  String dosages;
  String dosagesEnglish;
  String dosagesDari;
  String dosagesPashto;
  String packsAndPrices;
  String wholeSalePrice;
  String warnings;
  String warningsEnglish;
  String warningsDari;
  String warningsPashto;
  String company;
  String origin;
  String notes;
  String drugType;
  String drugTypeEnglish;
  String drugTypeDari;
  String drugTypePashto;
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
    this.pashtoName,
    this.englishName,
    this.persianName,
    this.genericName,
    this.barcode,
    this.therapeuticClass,
    this.pharmacologicClass,
    this.usage,
    this.usageEnglish,
    this.usageDari,
    this.usagePashto,
    this.sideEffectsEnglish,
    this.sideEffectsDari,
    this.sideEffectsPashto,
    this.sideEffects,
    this.dosages,
    this.dosagesEnglish,
    this.dosagesDari,
    this.dosagesPashto,
    this.packsAndPrices,
    this.wholeSalePrice,
    this.warnings,
    this.warningsEnglish,
    this.warningsDari,
    this.warningsPashto,
    this.company,
    this.origin,
    this.notes,
    this.drugType,
    this.drugTypeEnglish,
    this.drugTypeDari,
    this.drugTypePashto,
    this.pack,
    this.adminId,
    this.createdAt,
    this.updatedAt,
    this.v,
  }) {
    this.name = () {
      switch (SettingsController.appLanguge) {
        case "English":
          {
            var result =
                this.englishName ?? this.persianName ?? this.pashtoName;
            return result;
          }
        case "فارسی":
          {
            var result =
                this.persianName ?? this.englishName ?? this.pashtoName;
            return result;
          }
        case "پشتو":
          {
            var result =
                this.pashtoName ?? this.englishName ?? this.persianName;
            return result;
          }

          break;
        default:
          return null;
      }
    }();

    this.usage = () {
      switch (SettingsController.appLanguge) {
        case "English":
          {
            var result =
                this.usageEnglish ?? this.usageDari ?? this.usagePashto;
            return result;
          }
        case "فارسی":
          {
            var result =
                this.usageDari ?? this.usageEnglish ?? this.usagePashto;
            return result;
          }
        case "پشتو":
          {
            var result =
                this.usagePashto ?? this.usageEnglish ?? this.usageDari;
            return result;
          }

          break;
        default:
          return null;
      }
    }();

    ///
    this.sideEffects = () {
      switch (SettingsController.appLanguge) {
        case "English":
          {
            var result = this.sideEffectsEnglish ??
                this.sideEffectsDari ??
                this.sideEffectsPashto;
            return result;
          }
        case "فارسی":
          {
            var result = this.sideEffectsDari ??
                this.sideEffectsEnglish ??
                this.sideEffectsPashto;
            return result;
          }
        case "پشتو":
          {
            var result = this.sideEffectsPashto ??
                this.sideEffectsEnglish ??
                this.sideEffectsDari;
            return result;
          }

          break;
        default:
          return null;
      }
    }();

    ///
    this.warnings = () {
      switch (SettingsController.appLanguge) {
        case "English":
          {
            var result = this.warningsEnglish ??
                this.warningsDari ??
                this.warningsPashto;
            return result;
          }
        case "فارسی":
          {
            var result = this.warningsDari ??
                this.warningsEnglish ??
                this.warningsPashto;
            return result;
          }
        case "پشتو":
          {
            var result = this.warningsPashto ??
                this.warningsEnglish ??
                this.warningsDari;
            return result;
          }

          break;
        default:
          return null;
      }
    }();

    ///
    ///
    this.dosages = () {
      switch (SettingsController.appLanguge) {
        case "English":
          {
            var result =
                this.dosagesEnglish ?? this.dosagesDari ?? this.dosagesPashto;
            return result;
          }
        case "فارسی":
          {
            var result =
                this.dosagesDari ?? this.dosagesEnglish ?? this.dosagesPashto;
            return result;
          }
        case "پشتو":
          {
            var result =
                this.dosagesPashto ?? this.dosagesEnglish ?? this.dosagesDari;
            return result;
          }

          break;
        default:
          return null;
      }
    }();
  }

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        verified: json["verified"] == null ? null : json["verified"],
        active: json["active"] == null ? null : json["active"],
        img: json["img"] == null ? null : json["img"],
        id: json["_id"] == null ? null : json["_id"],
        englishName: json["englishName"] == null ? null : json["englishName"],
        persianName: json["persianName"] == null ? null : json["persianName"],
        pashtoName: json["pashtoName"] == null ? null : json["pashtoName"],
        genericName: json["genericName"] == null ? null : json["genericName"],
        barcode: json["barcode"] == null ? null : json["barcode"],
        therapeuticClass:
            json["therapeuticClass"] == null ? null : json["therapeuticClass"],
        pharmacologicClass: json["pharmacologicClass"] == null
            ? null
            : json["pharmacologicClass"],
        usage: json["usage"] == null ? null : json["usage"],
        sideEffects: json["sideEffects"] == null ? null : json["sideEffects"],
        dosages: json["dosages"] == null ? null : json["dosages"],
        dosagesEnglish:
            json["dosagesEnglish"] == null ? null : json["dosagesEnglish"],
        dosagesDari: json["dosagesDari"] == null ? null : json["dosagesDari"],
        dosagesPashto:
            json["dosagesPashto"] == null ? null : json["dosagesPashto"],
        packsAndPrices:
            json["packsAndPrices"] == null ? null : json["packsAndPrices"],
        wholeSalePrice:
            json["wholeSalePrice"] == null ? null : json["wholeSalePrice"],
        warnings: json["warnings"] == null ? null : json["warnings"],
        company: json["company"] == null ? null : json["company"],
        origin: json["origin"] == null ? null : json["origin"],
        notes: json["notes"] == null ? null : json["notes"],
        drugType: json["drugType"] == null ? null : json["drugType"],
        pack: json["pack"] == null ? null : json["pack"],
        adminId: json["adminId"] == null
            ? null
            : AdminId.fromJson(
                Map<String, dynamic>.from(json["adminId"] as Map)),
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
        v: json["__v"] == null ? null : json["__v"],
        drugTypeEnglish:
            json["drugTypeEnglish"] == null ? null : json["drugTypeEnglish"],
        drugTypeDari:
            json["drugTypeDari"] == null ? null : json["drugTypeDari"],
        drugTypePashto:
            json["drugTypePashto"] == null ? null : json["drugTypePashto"],
        sideEffectsEnglish: json["sideEffectsEnglish"] == null
            ? null
            : json["sideEffectsEnglish"],
        sideEffectsDari:
            json["sideEffectsDari"] == null ? null : json["sideEffectsDari"],
        sideEffectsPashto: json["sideEffectsPashto"] == null
            ? null
            : json["sideEffectsPashto"],
        usageEnglish:
            json["usageEnglish"] == null ? null : json["usageEnglish"],
        usageDari: json["usageDari"] == null ? null : json["usageDari"],
        usagePashto: json["usagePashto"] == null ? null : json["usagePashto"],
        warningsEnglish:
            json["warningsEnglish"] == null ? null : json["warningsEnglish"],
        warningsDari:
            json["warningsDari"] == null ? null : json["warningsDari"],
        warningsPashto:
            json["warningsPashto"] == null ? null : json["warningsPashto"],
      );

  Map<String, dynamic> toJson() => {
        "verified": verified == null ? null : verified,
        "active": active == null ? null : active,
        "img": img == null ? null : img,
        "_id": id == null ? null : id,
        "englishName": englishName == null ? null : englishName,
        "persianName": persianName == null ? null : persianName,
        "pashtoName": pashtoName == null ? null : pashtoName,
        "genericName": genericName == null ? null : genericName,
        "barcode": barcode == null ? null : barcode,
        "therapeuticClass": therapeuticClass == null ? null : therapeuticClass,
        "pharmacologicClass":
            pharmacologicClass == null ? null : pharmacologicClass,
        "usage": usage == null ? null : usage,
        "sideEffects": sideEffects == null ? null : sideEffects,
        "dosages": dosages == null ? null : dosages,
        "packsAndPrices": packsAndPrices == null ? null : packsAndPrices,
        "wholeSalePrice": wholeSalePrice == null ? null : wholeSalePrice,
        "warnings": warnings == null ? null : warnings,
        "company": company == null ? null : company,
        "origin": origin == null ? null : origin,
        "notes": notes == null ? null : notes,
        "drugType": drugType == null ? null : drugType,
        "pack": pack == null ? null : pack,
        "adminId": adminId == null ? null : adminId.toJson(),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "drugTypeEnglish": drugTypeEnglish == null ? null : drugTypeEnglish,
        "drugTypeDari": drugTypeDari == null ? null : drugTypeDari,
        "drugTypePashto": drugTypePashto == null ? null : drugTypePashto,
        "sideEffectsEnglish":
            sideEffectsEnglish == null ? null : sideEffectsEnglish,
        "sideEffectsDari": sideEffectsDari == null ? null : sideEffectsDari,
        "sideEffectsPashto":
            sideEffectsPashto == null ? null : sideEffectsPashto,
        "usageEnglish": usageEnglish == null ? null : usageEnglish,
        "usageDari": usageDari == null ? null : usageDari,
        "usagePashto": usagePashto == null ? null : usagePashto,
        "warningsEnglish": warningsEnglish == null ? null : warningsEnglish,
        "warningsDari": warningsDari == null ? null : warningsDari,
        "warningsPashto": warningsPashto == null ? null : warningsPashto,
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
        name: json["name"] == null ? null : json["name"],
        id: json["_id"] == null ? null : json["_id"],
        email: json["email"] == null ? null : json["email"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "_id": id == null ? null : id,
        "email": email == null ? null : email,
      };
}
