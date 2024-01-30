// To parse this JSON data, do
//
//     final dieaseCategoryResModel = dieaseCategoryResModelFromJson(jsonString);

import 'dart:convert';

DieaseCategoryResModel dieaseCategoryResModelFromJson(String str) =>
    DieaseCategoryResModel.fromJson(json.decode(str));

String dieaseCategoryResModelToJson(DieaseCategoryResModel data) =>
    json.encode(data.toJson());

class DieaseCategoryResModel {
  bool success;
  List<Datum> data;
  int count;

  DieaseCategoryResModel({
    this.success,
    this.data,
    this.count,
  });

  factory DieaseCategoryResModel.fromJson(Map<String, dynamic> json) =>
      DieaseCategoryResModel(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count,
      };
}

class Datum {
  String id;
  String photo;
  String background;
  bool isDeleted;
  String fTitle;
  String eTitle;
  String pTitle;
  int order;
  String detail;
  String createdAt;
  String updatedAt;
  int v;

  Datum({
    this.id,
    this.photo,
    this.background,
    this.isDeleted,
    this.fTitle,
    this.eTitle,
    this.pTitle,
    this.order,
    this.detail,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        photo: json["photo"],
        background: json["background"],
        isDeleted: json["is_deleted"],
        fTitle: json["f_title"],
        eTitle: json["e_title"],
        pTitle: json["p_title"],
        order: json["order"],
        detail: json["detail"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "photo": photo,
        "background": background,
        "is_deleted": isDeleted,
        "f_title": fTitle,
        "e_title": eTitle,
        "p_title": pTitle,
        "order": order,
        "detail": detail,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
      };
}
