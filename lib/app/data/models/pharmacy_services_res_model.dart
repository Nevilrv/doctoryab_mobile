// To parse this JSON data, do
//
//     final pharmacyServicesResModel = pharmacyServicesResModelFromJson(jsonString);

import 'dart:convert';

PharmacyServicesResModel pharmacyServicesResModelFromJson(String str) =>
    PharmacyServicesResModel.fromJson(json.decode(str));

String pharmacyServicesResModelToJson(PharmacyServicesResModel data) =>
    json.encode(data.toJson());

class PharmacyServicesResModel {
  List<Services>? data;

  PharmacyServicesResModel({
    this.data,
  });

  factory PharmacyServicesResModel.fromJson(Map<String, dynamic> json) =>
      PharmacyServicesResModel(
        data:
            List<Services>.from(json["data"].map((x) => Services.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Services {
  bool? isBrief;
  int? price;
  String? id;
  String? title;
  String? content;

  Services({
    this.isBrief,
    this.price,
    this.id,
    this.title,
    this.content,
  });

  factory Services.fromJson(Map<String, dynamic> json) => Services(
        isBrief: json["is_brief"],
        price: json["price"],
        id: json["_id"],
        title: json["title"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "is_brief": isBrief,
        "price": price,
        "_id": id,
        "title": title,
        "content": content,
      };
}
