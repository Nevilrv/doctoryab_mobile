// To parse this JSON data, do
//
//     final updatedDrugDatabaseModel = updatedDrugDatabaseModelFromJson(jsonString);

import 'dart:convert';

UpdatedDrugDatabaseModel updatedDrugDatabaseModelFromJson(String str) =>
    UpdatedDrugDatabaseModel.fromJson(json.decode(str));

String updatedDrugDatabaseModelToJson(UpdatedDrugDatabaseModel data) =>
    json.encode(data.toJson());

class UpdatedDrugDatabaseModel {
  List<UpdatedDrug>? data;
  int? count;
  int? unVerifiedCount;

  UpdatedDrugDatabaseModel({
    this.data,
    this.count,
    this.unVerifiedCount,
  });

  factory UpdatedDrugDatabaseModel.fromJson(Map<String, dynamic> json) =>
      UpdatedDrugDatabaseModel(
        data: List<UpdatedDrug>.from(
            json["data"].map((x) => UpdatedDrug.fromJson(x))),
        count: json["count"],
        unVerifiedCount: json["unVerifiedCount"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "count": count,
        "unVerifiedCount": unVerifiedCount,
      };
}

class UpdatedDrug {
  bool? verified;
  bool? active;
  List<dynamic>? similarDrugs;
  List<dynamic>? aGradeTags;
  List<dynamic>? bGradeTags;
  String? totalFeedbacks;
  String? averageRating;
  String? img;
  String? id;
  String? englishDrugName;
  String? localLanguageDrugName;
  String? genericName;
  String? barcode;
  String? therapeuticClass;
  String? pharmacologicClass;
  String? usageDari;
  String? usageEnglish;
  String? usagePashto;
  String? sideEffectsEnglish;
  String? sideEffectsPashto;
  String? sideEffectsDari;
  String? dosagesEnglish;
  String? dosagesDari;
  String? dosagesPashto;
  String? packsAndPrices;
  String? wholeSalePrice;
  String? warningsEnglish;
  String? warningsDari;
  String? warningsPashto;
  String? company;
  String? origin;
  String? notes;
  String? drugTypeEnglish;
  String? drugTypeDari;
  String? drugTypePashto;
  String? quantity;
  AdminId? adminId;
  String? createdAt;
  String? updatedAt;
  int? v;

  UpdatedDrug({
    this.verified,
    this.active,
    this.similarDrugs,
    this.aGradeTags,
    this.bGradeTags,
    this.totalFeedbacks,
    this.averageRating,
    this.img,
    this.id,
    this.englishDrugName,
    this.localLanguageDrugName,
    this.genericName,
    this.barcode,
    this.therapeuticClass,
    this.pharmacologicClass,
    this.usageDari,
    this.usageEnglish,
    this.usagePashto,
    this.sideEffectsEnglish,
    this.sideEffectsPashto,
    this.sideEffectsDari,
    this.dosagesEnglish,
    this.dosagesDari,
    this.dosagesPashto,
    this.packsAndPrices,
    this.wholeSalePrice,
    this.warningsEnglish,
    this.warningsDari,
    this.warningsPashto,
    this.company,
    this.origin,
    this.notes,
    this.drugTypeEnglish,
    this.drugTypeDari,
    this.drugTypePashto,
    this.quantity,
    this.adminId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UpdatedDrug.fromJson(Map<String, dynamic> json) => UpdatedDrug(
        verified: json["verified"] == null ? null : json["verified"],
        active: json["active"] == null ? null : json["active"],
        similarDrugs: json["similarDrugs"] == null
            ? null
            : List<dynamic>.from(json["similarDrugs"].map((x) => x)),
        aGradeTags: json["aGradeTags"] == null
            ? null
            : List<dynamic>.from(json["aGradeTags"].map((x) => x)),
        bGradeTags: json["bGradeTags"] == null
            ? null
            : List<dynamic>.from(json["bGradeTags"].map((x) => x)),
        totalFeedbacks:
            json["totalFeedbacks"] == null ? null : json["totalFeedbacks"],
        averageRating:
            json["averageRating"] == null ? null : json["averageRating"],
        img: json["img"] == null ? null : json["img"],
        id: json["_id"] == null ? null : json["_id"],
        englishDrugName:
            json["englishDrugName"] == null ? null : json["englishDrugName"],
        localLanguageDrugName: json["localLanguageDrugName"] == null
            ? null
            : json["localLanguageDrugName"],
        genericName: json["genericName"] == null ? null : json["genericName"],
        barcode: json["barcode"] == null ? null : json["barcode"],
        therapeuticClass:
            json["therapeuticClass"] == null ? null : json["therapeuticClass"],
        pharmacologicClass: json["pharmacologicClass"] == null
            ? null
            : json["pharmacologicClass"],
        usageDari: json["usageDari"] == null ? null : json["usageDari"],
        usageEnglish:
            json["usageEnglish"] == null ? null : json["usageEnglish"],
        usagePashto: json["usagePashto"] == null ? null : json["usagePashto"],
        sideEffectsEnglish: json["sideEffectsEnglish"] == null
            ? null
            : json["sideEffectsEnglish"],
        sideEffectsPashto: json["sideEffectsPashto"] == null
            ? null
            : json["sideEffectsPashto"],
        sideEffectsDari:
            json["sideEffectsDari"] == null ? null : json["sideEffectsDari"],
        dosagesEnglish:
            json["dosagesEnglish"] == null ? null : json["dosagesEnglish"],
        dosagesDari: json["dosagesDari"] == null ? null : json["dosagesDari"],
        dosagesPashto:
            json["dosagesPashto"] == null ? null : json["dosagesPashto"],
        packsAndPrices:
            json["packsAndPrices"] == null ? null : json["packsAndPrices"],
        wholeSalePrice:
            json["wholeSalePrice"] == null ? null : json["wholeSalePrice"],
        warningsEnglish:
            json["warningsEnglish"] == null ? null : json["warningsEnglish"],
        warningsDari:
            json["warningsDari"] == null ? null : json["warningsDari"],
        warningsPashto:
            json["warningsPashto"] == null ? null : json["warningsPashto"],
        company: json["company"] == null ? null : json["company"],
        origin: json["origin"] == null ? null : json["origin"],
        notes: json["notes"] == null ? null : json["notes"],
        drugTypeEnglish:
            json["drugTypeEnglish"] == null ? null : json["drugTypeEnglish"],
        drugTypeDari:
            json["drugTypeDari"] == null ? null : json["drugTypeDari"],
        drugTypePashto:
            json["drugTypePashto"] == null ? null : json["drugTypePashto"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        adminId: json["adminId"] == null
            ? null
            : json["adminId"] == null
                ? null
                : AdminId.fromJson(
                    Map<String, dynamic>.from(json["adminId"] as Map)),
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "verified": verified == null ? null : verified,
        "active": active == null ? null : active,
        "similarDrugs": similarDrugs == null
            ? null
            : List<dynamic>.from(similarDrugs!.map((x) => x)),
        "aGradeTags": aGradeTags == null
            ? null
            : List<dynamic>.from(aGradeTags!.map((x) => x)),
        "bGradeTags": bGradeTags == null
            ? null
            : List<dynamic>.from(bGradeTags!.map((x) => x)),
        "totalFeedbacks": totalFeedbacks == null ? null : totalFeedbacks,
        "averageRating": averageRating == null ? null : averageRating,
        "img": img == null ? null : img,
        "_id": id == null ? null : id,
        "englishDrugName": englishDrugName == null ? null : englishDrugName,
        "localLanguageDrugName":
            localLanguageDrugName == null ? null : localLanguageDrugName,
        "genericName": genericName == null ? null : genericName,
        "barcode": barcode == null ? null : barcode,
        "therapeuticClass": therapeuticClass == null ? null : therapeuticClass,
        "pharmacologicClass":
            pharmacologicClass == null ? null : pharmacologicClass,
        "usageDari": usageDari == null ? null : usageDari,
        "usageEnglish": usageEnglish == null ? null : usageEnglish,
        "usagePashto": usagePashto == null ? null : usagePashto,
        "sideEffectsEnglish":
            sideEffectsEnglish == null ? null : sideEffectsEnglish,
        "sideEffectsPashto":
            sideEffectsPashto == null ? null : sideEffectsPashto,
        "sideEffectsDari": sideEffectsDari == null ? null : sideEffectsDari,
        "dosagesEnglish": dosagesEnglish == null ? null : dosagesEnglish,
        "dosagesDari": dosagesDari == null ? null : dosagesDari,
        "dosagesPashto": dosagesPashto == null ? null : dosagesPashto,
        "packsAndPrices": packsAndPrices == null ? null : packsAndPrices,
        "wholeSalePrice": wholeSalePrice == null ? null : wholeSalePrice,
        "warningsEnglish": warningsEnglish == null ? null : warningsEnglish,
        "warningsDari": warningsDari == null ? null : warningsDari,
        "warningsPashto": warningsPashto == null ? null : warningsPashto,
        "company": company == null ? null : company,
        "origin": origin == null ? null : origin,
        "notes": notes == null ? null : notes,
        "drugTypeEnglish": drugTypeEnglish == null ? null : drugTypeEnglish,
        "drugTypeDari": drugTypeDari == null ? null : drugTypeDari,
        "drugTypePashto": drugTypePashto == null ? null : drugTypePashto,
        "quantity": quantity == null ? null : quantity,
        "adminId": adminId == null ? null : adminId!.toJson(),
        "createdAt": createdAt == null ? null : createdAt,
        "updatedAt": updatedAt == null ? null : updatedAt,
        "__v": v == null ? null : v,
      };
}

class AdminId {
  String? name;
  String? id;
  String? email;

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
