// To parse this JSON data, do
//
//     final blogCategories = blogCategoriesFromJson(jsonString);

import 'dart:convert';

BlogCategories blogCategoriesFromJson(String str) =>
    BlogCategories.fromJson(json.decode(str));

String blogCategoriesToJson(BlogCategories data) => json.encode(data.toJson());

class BlogCategories {
  bool success;
  List<BlogCategory> data;
  int count;

  BlogCategories({
    this.success,
    this.data,
    this.count,
  });

  factory BlogCategories.fromJson(Map<String, dynamic> json) => BlogCategories(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<BlogCategory>.from(
                json["data"].map((x) => BlogCategory.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data":
            data == null ? [] : List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count,
      };
}

class BlogCategory {
  String id;
  bool isDeleted;
  String photo;
  String categoryEnglish;
  String categoryDari;
  String categoryPashto;
  String detail;
  String createAt;
  int v;
  bool active;

  BlogCategory({
    this.id,
    this.isDeleted,
    this.photo,
    this.categoryEnglish,
    this.categoryDari,
    this.categoryPashto,
    this.detail,
    this.createAt,
    this.v,
    this.active,
  });

  factory BlogCategory.fromJson(Map<String, dynamic> json) => BlogCategory(
        id: json["_id"],
        isDeleted: json["is_deleted"],
        photo: json["photo"],
        categoryEnglish: json["categoryEnglish"],
        categoryDari: json["categoryDari"],
        categoryPashto: json["categoryPashto"],
        detail: json["detail"],
        createAt: json["createAt"],
        v: json["__v"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "is_deleted": isDeleted,
        "photo": photo,
        "categoryEnglish": categoryEnglish,
        "categoryDari": categoryDari,
        "categoryPashto": categoryPashto,
        "detail": detail,
        "createAt": createAt,
        "__v": v,
        "active": active,
      };
}
