// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

Categories categoriesFromJson(String str) =>
    Categories.fromJson(json.decode(str));

String categoriesToJson(Categories data) => json.encode(data.toJson());

class Categories {
  Categories({
    this.success,
    this.data,
  });

  bool? success;
  List<Category>? data;

  Categories copyWith({
    bool? success,
    List<Category>? data,
  }) =>
      Categories(
        success: success ?? this.success,
        data: data ?? this.data,
      );

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : List<Category>.from(
                json["data"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.id,
    this.isDeleted,
    this.fTitle,
    this.eTitle,
    this.pTitle,
    this.background,
    this.v,
    this.photo,
  });

  String? id;
  bool? isDeleted;
  String? fTitle;
  String? eTitle;
  String? pTitle;
  String? background;
  int? v;
  String? photo;

  ///FOR ALL LANGS
  String? get title {
    if (Get.locale!.languageCode == "fa" || Get.locale!.languageCode == "uz")
      return this.fTitle;
    if (Get.locale!.languageCode == "ps" || Get.locale!.languageCode == "ru")
      return this.pTitle;

    return this.eTitle;
  }

  Category copyWith({
    String? id,
    bool? isDeleted,
    String? fTitle,
    String? eTitle,
    String? pTitle,
    String? background,
    int? v,
    String? photo,
  }) =>
      Category(
        id: id ?? this.id,
        isDeleted: isDeleted ?? this.isDeleted,
        fTitle: fTitle ?? this.fTitle,
        eTitle: eTitle ?? this.eTitle,
        pTitle: pTitle ?? this.pTitle,
        background: background ?? this.background,
        v: v ?? this.v,
        photo: photo ?? this.photo,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"] == null ? null : json["_id"],
        isDeleted: json["is_deleted"] == null ? null : json["is_deleted"],
        fTitle: json["f_title"] == null ? null : json["f_title"],
        eTitle: json["e_title"] == null ? null : json["e_title"],
        pTitle: json["p_title"] == null ? null : json["p_title"],
        background: json["background"] == null ? null : json["background"],
        v: json["__v"] == null ? null : json["__v"],
        photo: json["photo"] == null ? null : json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "is_deleted": isDeleted == null ? null : isDeleted,
        "f_title": fTitle == null ? null : fTitle,
        "e_title": eTitle == null ? null : eTitle,
        "p_title": pTitle == null ? null : pTitle,
        "background": background == null ? null : background,
        "__v": v == null ? null : v,
        "photo": photo == null ? null : photo,
      };
}
