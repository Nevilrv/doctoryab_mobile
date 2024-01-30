// To parse this JSON data, do
//
//     final pharmacyProductResModel = pharmacyProductResModelFromJson(jsonString);

import 'dart:convert';

PharmacyProductResModel pharmacyProductResModelFromJson(String str) =>
    PharmacyProductResModel.fromJson(json.decode(str));

String pharmacyProductResModelToJson(PharmacyProductResModel data) =>
    json.encode(data.toJson());

class PharmacyProductResModel {
  List<ProductData> data;

  PharmacyProductResModel({
    this.data,
  });

  factory PharmacyProductResModel.fromJson(Map<String, dynamic> json) =>
      PharmacyProductResModel(
        data: List<ProductData>.from(
            json["data"].map((x) => ProductData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ProductData {
  bool isBrief;
  int price;
  String id;
  String title;
  String content;
  String img;

  ProductData({
    this.isBrief,
    this.price,
    this.id,
    this.title,
    this.content,
    this.img,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        isBrief: json["is_brief"],
        price: json["price"],
        id: json["_id"],
        title: json["title"],
        content: json["content"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "is_brief": isBrief,
        "price": price,
        "_id": id,
        "title": title,
        "content": content,
        "img": img,
      };
}
