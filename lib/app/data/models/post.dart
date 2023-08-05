// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  PostModel({
    this.data,
    this.count,
  });

  List<Post> data;
  int count;

  PostModel copyWith({
    List<Post> data,
    int count,
  }) =>
      PostModel(
        data: data ?? this.data,
        count: count ?? this.count,
      );

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
  Post({
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
    this.isDeleted,
    this.isPublic,
  });

  String img;
  List<dynamic> likes;
  List<dynamic> shares;
  List<Comment> comments;
  bool isPublished;
  String id;
  String name;
  String desc;
  String category;
  String blogTitle;
  String doctorId;
  DateTime createAt;
  int v;
  DateTime publishedAt;
  bool isDeleted;
  bool isPublic;

  Post copyWith({
    String img,
    List<dynamic> likes,
    List<dynamic> shares,
    List<Comment> comments,
    bool isPublished,
    String id,
    String name,
    String desc,
    String category,
    String blogTitle,
    String doctorId,
    DateTime createAt,
    int v,
    DateTime publishedAt,
    bool isDeleted,
    bool isPublic,
  }) =>
      Post(
        img: img ?? this.img,
        likes: likes ?? this.likes,
        shares: shares ?? this.shares,
        comments: comments ?? this.comments,
        isPublished: isPublished ?? this.isPublished,
        id: id ?? this.id,
        name: name ?? this.name,
        desc: desc ?? this.desc,
        category: category ?? this.category,
        blogTitle: blogTitle ?? this.blogTitle,
        doctorId: doctorId ?? this.doctorId,
        createAt: createAt ?? this.createAt,
        v: v ?? this.v,
        publishedAt: publishedAt ?? this.publishedAt,
        isDeleted: isDeleted ?? this.isDeleted,
        isPublic: isPublic ?? this.isPublic,
      );

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        img: json["img"],
        likes: List<dynamic>.from(json["likes"].map((x) => x)),
        shares: List<dynamic>.from(json["shares"].map((x) => x)),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        isPublished: json["is_published"],
        id: json["_id"],
        name: json["name"],
        desc: json["desc"],
        category: json["category"],
        blogTitle: json["blogTitle"],
        doctorId: json["doctorId"],
        createAt: DateTime.tryParse(json["createAt"] ?? ""),
        v: json["__v"],
        publishedAt:
            DateTime.tryParse(json["publishedAt"] ?? "") ?? DateTime.now(),
        isDeleted: json["is_deleted"],
        isPublic: json["is_public"],
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
        "createAt": createAt.toIso8601String(),
        "__v": v,
        "publishedAt": publishedAt.toIso8601String(),
        "is_deleted": isDeleted,
        "is_public": isPublic,
      };
}

class Comment {
  Comment({
    this.text,
    this.postedBy,
    this.createAt,
    this.whoPosted,
    this.commentId,
  });

  String text;
  String postedBy;
  dynamic createAt;
  String whoPosted;
  String commentId;

  Comment copyWith({
    String text,
    String postedBy,
    dynamic createAt,
    String whoPosted,
    String commentId,
  }) =>
      Comment(
        text: text ?? this.text,
        postedBy: postedBy ?? this.postedBy,
        createAt: createAt ?? this.createAt,
        whoPosted: whoPosted ?? this.whoPosted,
        commentId: commentId ?? this.commentId,
      );

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        text: json["text"],
        postedBy: json["postedBy"],
        createAt: json["createAt"],
        whoPosted: json["whoPosted"],
        commentId: json["commentId"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "postedBy": postedBy,
        "createAt": createAt,
        "whoPosted": whoPosted,
        "commentId": commentId,
      };
}
