// To parse this JSON data, do
//
//     final blogLikeResModel = blogLikeResModelFromJson(jsonString);

import 'dart:convert';

BlogLikeResModel blogLikeResModelFromJson(String str) =>
    BlogLikeResModel.fromJson(json.decode(str));

String blogLikeResModelToJson(BlogLikeResModel data) =>
    json.encode(data.toJson());

class BlogLikeResModel {
  Data data;

  BlogLikeResModel({
    this.data,
  });

  factory BlogLikeResModel.fromJson(Map<String, dynamic> json) =>
      BlogLikeResModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  String img;
  List<String> likes;
  List<String> shares;
  List<Comment> comments;
  bool isPublished;
  String id;
  String name;
  String desc;
  String category;
  String blogTitle;
  String doctorId;
  String createAt;
  int v;
  String publishedAt;

  Data({
    this.img,
    this.likes,
    this.shares,
    this.comments,
    this.isPublished,
    this.id,
    this.name,
    this.desc,
    this.category,
    this.blogTitle,
    this.doctorId,
    this.createAt,
    this.v,
    this.publishedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        img: json["img"],
        likes: List<String>.from(json["likes"].map((x) => x)),
        shares: List<String>.from(json["shares"].map((x) => x)),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        isPublished: json["is_published"],
        id: json["_id"],
        name: json["name"],
        desc: json["desc"],
        category: json["category"],
        blogTitle: json["blogTitle"],
        doctorId: json["doctorId"],
        createAt: json["createAt"],
        v: json["__v"],
        publishedAt: json["publishedAt"],
      );

  Map<String, dynamic> toJson() => {
        "img": img,
        "likes": List<dynamic>.from(likes.map((x) => x)),
        "shares": List<dynamic>.from(shares.map((x) => x)),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "is_published": isPublished,
        "_id": id,
        "name": name,
        "desc": desc,
        "category": category,
        "blogTitle": blogTitle,
        "doctorId": doctorId,
        "createAt": createAt,
        "__v": v,
        "publishedAt": publishedAt,
      };
}

class Comment {
  String text;
  String whoPosted;
  String postedBy;
  String createAt;
  String commentId;

  Comment({
    this.text,
    this.whoPosted,
    this.postedBy,
    this.createAt,
    this.commentId,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        text: json["text"],
        whoPosted: json["whoPosted"],
        postedBy: json["postedBy"],
        createAt: json["createAt"],
        commentId: json["commentId"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "whoPosted": whoPosted,
        "postedBy": postedBy,
        "createAt": createAt,
        "commentId": commentId,
      };
}
