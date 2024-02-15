// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  List<Post> data;
  int count;

  PostModel({
    this.data,
    this.count,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        data: List<Post>.from(json["data"].map((x) => Post.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count,
      };
}

class Post {
  String img;
  List<String> likes;
  List<dynamic> shares;
  List<dynamic> comments;
  bool isPublished;
  String id;
  String name;
  String descEnglish;
  String descDari;
  String descPashto;
  String categoryEnglish;
  String categoryDari;
  String categoryPashto;
  String blogTitlePashto;
  String blogTitleDari;
  String blogTitleEnglish;
  String doctorId;
  String createAt;
  int v;

  Post({
    this.img,
    this.likes,
    this.shares,
    this.comments,
    this.isPublished,
    this.id,
    this.name,
    this.descEnglish,
    this.descDari,
    this.descPashto,
    this.categoryEnglish,
    this.categoryDari,
    this.categoryPashto,
    this.blogTitlePashto,
    this.blogTitleDari,
    this.blogTitleEnglish,
    this.doctorId,
    this.createAt,
    this.v,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        img: json["img"],
        likes: List<String>.from(json["likes"].map((x) => x)),
        shares: List<dynamic>.from(json["shares"].map((x) => x)),
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        isPublished: json["is_published"],
        id: json["_id"],
        name: json["name"],
        descEnglish: json["descEnglish"],
        descDari: json["descDari"],
        descPashto: json["descPashto"],
        categoryEnglish: json["categoryEnglish"],
        categoryDari: json["categoryDari"],
        categoryPashto: json["categoryPashto"],
        blogTitlePashto: json["blogTitlePashto"],
        blogTitleDari: json["blogTitleDari"],
        blogTitleEnglish: json["blogTitleEnglish"],
        doctorId: json["doctorId"],
        createAt: json["createAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "img": img,
        "likes": List<dynamic>.from(likes.map((x) => x)),
        "shares": List<dynamic>.from(shares.map((x) => x)),
        "comments": List<dynamic>.from(comments.map((x) => x)),
        "is_published": isPublished,
        "_id": id,
        "name": name,
        "descEnglish": descEnglish,
        "descDari": descDari,
        "descPashto": descPashto,
        "categoryEnglish": categoryEnglish,
        "categoryDari": categoryDari,
        "categoryPashto": categoryPashto,
        "blogTitlePashto": blogTitlePashto,
        "blogTitleDari": blogTitleDari,
        "blogTitleEnglish": blogTitleEnglish,
        "doctorId": doctorId,
        "createAt": createAt,
        "__v": v,
      };
}
