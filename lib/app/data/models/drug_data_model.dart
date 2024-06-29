class DrugData {
  bool? verified;
  bool? active;
  String? img;
  String? id;
  String? englishName;
  String? persianName;
  String? genericName;
  String? barcode;
  String? therapeuticClass;
  String? pharmacologicClass;
  String? usage;
  String? usageEnglish;
  String? sideEffectsEnglish;
  String? sideEffects;
  String? dosages;
  String? packsAndPrices;
  String? wholeSalePrice;
  String? warnings;
  String? company;
  String? origin;
  String? notes;
  String? drugType;
  String? pack;
  AdminId? adminId;
  String? createdAt;
  String? updatedAt;
  int? v;

  DrugData({
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

  factory DrugData.fromJson(Map<String, dynamic> json) => DrugData(
        verified: json["verified"] == null ? null : json["verified"],
        active: json["active"] == null ? null : json["active"],
        img: json["img"] == null ? null : json["img"],
        id: json["_id"] == null ? null : json["_id"],
        englishName: json["englishName"] == null ? null : json["englishName"],
        persianName: json["persianName"] == null ? null : json["persianName"],
        genericName: json["genericName"] == null ? null : json["genericName"],
        barcode: json["barcode"] == null ? null : json["barcode"],
        therapeuticClass:
            json["therapeuticClass"] == null ? null : json["therapeuticClass"],
        pharmacologicClass: json["pharmacologicClass"] == null
            ? null
            : json["pharmacologicClass"],
        usage: json["usage"] == null ? null : json["usage"],
        usageEnglish:
            json["usageEnglish"] == null ? null : json["usageEnglish"],
        sideEffectsEnglish: json["sideEffectsEnglish"] == null
            ? null
            : json["sideEffectsEnglish"],
        sideEffects: json["sideEffects"] == null ? null : json["sideEffects"],
        dosages: json["dosages"] == null ? null : json["dosages"],
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
        adminId:
            json["adminId"] == null ? null : AdminId.fromJson(json["adminId"]),
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "verified": verified == null ? null : verified,
        "active": active == null ? null : active,
        "img": img == null ? null : img,
        "_id": id == null ? null : id,
        "englishName": englishName == null ? null : englishName,
        "persianName": persianName == null ? null : persianName,
        "genericName": genericName == null ? null : genericName,
        "barcode": barcode == null ? null : barcode,
        "therapeuticClass": therapeuticClass == null ? null : therapeuticClass,
        "pharmacologicClass":
            pharmacologicClass == null ? null : pharmacologicClass,
        "usage": usage == null ? null : usage,
        "usageEnglish": usageEnglish == null ? null : usageEnglish,
        "sideEffectsEnglish":
            sideEffectsEnglish == null ? null : sideEffectsEnglish,
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
        "adminId": adminId == null ? null : adminId!.toJson(),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
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
