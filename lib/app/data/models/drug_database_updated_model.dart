// To parse this JSON data, do
//
//     final updatedDrugDatabaseModel = updatedDrugDatabaseModelFromJson(jsonString);

import 'dart:convert';

UpdatedDrugDatabaseModel updatedDrugDatabaseModelFromJson(String str) =>
    UpdatedDrugDatabaseModel.fromJson(json.decode(str));

String updatedDrugDatabaseModelToJson(UpdatedDrugDatabaseModel data) =>
    json.encode(data.toJson());

class UpdatedDrugDatabaseModel {
  List<UpdatedDrug> data;
  int count;
  int unVerifiedCount;

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
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count,
        "unVerifiedCount": unVerifiedCount,
      };
}

class UpdatedDrug {
  bool verified;
  bool active;
  List<dynamic> similarDrugs;
  List<dynamic> aGradeTags;
  List<dynamic> bGradeTags;
  String totalFeedbacks;
  String averageRating;
  String img;
  String id;
  String englishDrugName;
  String localLanguageDrugName;
  String genericName;
  String barcode;
  String therapeuticClass;
  String pharmacologicClass;
  String usageDari;
  String usageEnglish;
  String usagePashto;
  String sideEffectsEnglish;
  String sideEffectsPashto;
  String sideEffectsDari;
  String dosagesEnglish;
  String dosagesDari;
  String dosagesPashto;
  String packsAndPrices;
  String wholeSalePrice;
  String warningsEnglish;
  String warningsDari;
  String warningsPashto;
  String company;
  String origin;
  String notes;
  String drugTypeEnglish;
  String drugTypeDari;
  String drugTypePashto;
  String quantity;
  AdminId adminId;
  String createdAt;
  String updatedAt;
  int v;

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
        verified: json["verified"],
        active: json["active"],
        similarDrugs: List<dynamic>.from(json["similarDrugs"].map((x) => x)),
        aGradeTags: List<dynamic>.from(json["aGradeTags"].map((x) => x)),
        bGradeTags: List<dynamic>.from(json["bGradeTags"].map((x) => x)),
        totalFeedbacks: json["totalFeedbacks"],
        averageRating: json["averageRating"],
        img: json["img"],
        id: json["_id"],
        englishDrugName: json["englishDrugName"],
        localLanguageDrugName: json["localLanguageDrugName"],
        genericName: json["genericName"],
        barcode: json["barcode"],
        therapeuticClass: json["therapeuticClass"],
        pharmacologicClass: json["pharmacologicClass"],
        usageDari: json["usageDari"],
        usageEnglish: json["usageEnglish"],
        usagePashto: json["usagePashto"],
        sideEffectsEnglish: json["sideEffectsEnglish"],
        sideEffectsPashto: json["sideEffectsPashto"],
        sideEffectsDari: json["sideEffectsDari"],
        dosagesEnglish: json["dosagesEnglish"],
        dosagesDari: json["dosagesDari"],
        dosagesPashto: json["dosagesPashto"],
        packsAndPrices: json["packsAndPrices"],
        wholeSalePrice: json["wholeSalePrice"],
        warningsEnglish: json["warningsEnglish"],
        warningsDari: json["warningsDari"],
        warningsPashto: json["warningsPashto"],
        company: json["company"],
        origin: json["origin"],
        notes: json["notes"],
        drugTypeEnglish: json["drugTypeEnglish"],
        drugTypeDari: json["drugTypeDari"],
        drugTypePashto: json["drugTypePashto"],
        quantity: json["quantity"],
        adminId: AdminId.fromJson(json["adminId"]),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "verified": verified,
        "active": active,
        "similarDrugs": List<dynamic>.from(similarDrugs.map((x) => x)),
        "aGradeTags": List<dynamic>.from(aGradeTags.map((x) => x)),
        "bGradeTags": List<dynamic>.from(bGradeTags.map((x) => x)),
        "totalFeedbacks": totalFeedbacks,
        "averageRating": averageRating,
        "img": img,
        "_id": id,
        "englishDrugName": englishDrugName,
        "localLanguageDrugName": localLanguageDrugName,
        "genericName": genericName,
        "barcode": barcode,
        "therapeuticClass": therapeuticClass,
        "pharmacologicClass": pharmacologicClass,
        "usageDari": usageDari,
        "usageEnglish": usageEnglish,
        "usagePashto": usagePashto,
        "sideEffectsEnglish": sideEffectsEnglish,
        "sideEffectsPashto": sideEffectsPashto,
        "sideEffectsDari": sideEffectsDari,
        "dosagesEnglish": dosagesEnglish,
        "dosagesDari": dosagesDari,
        "dosagesPashto": dosagesPashto,
        "packsAndPrices": packsAndPrices,
        "wholeSalePrice": wholeSalePrice,
        "warningsEnglish": warningsEnglish,
        "warningsDari": warningsDari,
        "warningsPashto": warningsPashto,
        "company": company,
        "origin": origin,
        "notes": notes,
        "drugTypeEnglish": drugTypeEnglish,
        "drugTypeDari": drugTypeDari,
        "drugTypePashto": drugTypePashto,
        "quantity": quantity,
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
