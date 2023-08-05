// To parse this JSON data, do
//
//     final blogCategories = blogCategoriesFromJson(jsonString);

import 'dart:convert';

BlogCategories blogCategoriesFromJson(String str) =>
    BlogCategories.fromJson(json.decode(str));

String blogCategoriesToJson(BlogCategories data) => json.encode(data.toJson());

class BlogCategories {
  BlogCategories({
    this.data,
  });

  List<BlogCategory> data;

  BlogCategories copyWith({
    List<BlogCategory> data,
  }) =>
      BlogCategories(
        data: data ?? this.data,
      );

  factory BlogCategories.fromJson(Map<String, dynamic> json) => BlogCategories(
        data: List<BlogCategory>.from(
            json["data"].map((x) => BlogCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BlogCategory {
  BlogCategory({
    this.id,
    this.createAt,
    this.category,
    this.v,
  });

  String id;
  DateTime createAt;
  String category;
  int v;

  BlogCategory copyWith({
    String id,
    DateTime createAt,
    String category,
    int v,
  }) =>
      BlogCategory(
        id: id ?? this.id,
        createAt: createAt ?? this.createAt,
        category: category ?? this.category,
        v: v ?? this.v,
      );

  factory BlogCategory.fromJson(Map<String, dynamic> json) => BlogCategory(
        id: json["_id"],
        createAt: DateTime.parse(json["createAt"]),
        category: json["category"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "createAt": createAt.toIso8601String(),
        "category": category,
        "__v": v,
      };
}
