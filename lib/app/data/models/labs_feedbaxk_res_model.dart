// To parse this JSON data, do
//
//     final labsFeedbackModel = labsFeedbackModelFromJson(jsonString);

import 'dart:convert';
import 'package:doctor_yab/app/data/models/labs_model.dart';

LabsFeedbackModel labsFeedbackModelFromJson(String str) =>
    LabsFeedbackModel.fromJson(json.decode(str));

String labsFeedbackModelToJson(LabsFeedbackModel data) =>
    json.encode(data.toJson());

class LabsFeedbackModel {
  List<LabsFeedback> data;
  int averageRating;
  int totalRating;

  LabsFeedbackModel({
    this.data,
    this.averageRating,
    this.totalRating,
  });

  factory LabsFeedbackModel.fromJson(Map<String, dynamic> json) =>
      LabsFeedbackModel(
        data: List<LabsFeedback>.from(
            json["data"].map((x) => LabsFeedback.fromJson(x))),
        averageRating: json["averageRating"],
        totalRating: json["totalRating"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "averageRating": averageRating,
        "totalRating": totalRating,
      };
}

class LabsFeedback {
  String datumId;
  String comment;
  String whoPosted;
  PostedBy postedBy;
  String rating;
  String photo;
  String createAt;
  String commentId;
  LabId labId;
  String id;
  int v;

  LabsFeedback({
    this.datumId,
    this.comment,
    this.whoPosted,
    this.postedBy,
    this.photo,
    this.rating,
    this.createAt,
    this.commentId,
    this.labId,
    this.id,
    this.v,
  });

  factory LabsFeedback.fromJson(Map<String, dynamic> json) => LabsFeedback(
        datumId: json["_id"],
        comment: json["comment"],
        whoPosted: json["whoPosted"],
        postedBy: PostedBy.fromJson(json["postedBy"]),
        photo: json["photo"],
        rating: json["rating"],
        createAt: json["createAt"],
        commentId: json["commentId"],
        labId: LabId.fromJson(json["labId"]),
        id: json["ID"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": datumId,
        "comment": comment,
        "whoPosted": whoPosted,
        "postedBy": postedBy.toJson(),
        "photo": photo,
        "rating": rating,
        "createAt": createAt,
        "commentId": commentId,
        "labId": labId.toJson(),
        "ID": id,
        "__v": v,
      };
}

class LabId {
  Geometry geometry;
  String photo;
  String email;
  bool isDeleted;
  List<String> phone;
  List<List<String>> times;
  String totalFeedbacks;
  String averageRating;
  bool active;
  String rating;
  String labIdId;
  String name;
  String city;
  String address;
  String createAt;
  List<CheckUp> checkUp;
  int v;
  int id;

  LabId({
    this.geometry,
    this.photo,
    this.email,
    this.isDeleted,
    this.phone,
    this.times,
    this.totalFeedbacks,
    this.averageRating,
    this.active,
    this.rating,
    this.labIdId,
    this.name,
    this.city,
    this.address,
    this.createAt,
    this.checkUp,
    this.v,
    this.id,
  });

  factory LabId.fromJson(Map<String, dynamic> json) => LabId(
        geometry: Geometry.fromJson(json["geometry"]),
        photo: json["photo"],
        email: json["email"],
        isDeleted: json["is_deleted"],
        phone: List<String>.from(json["phone"].map((x) => x)),
        times: List<List<String>>.from(
            json["times"].map((x) => List<String>.from(x.map((x) => x)))),
        totalFeedbacks: json["totalFeedbacks"],
        averageRating: json["averageRating"],
        active: json["active"],
        rating: json["rating"],
        labIdId: json["_id"],
        name: json["name"],
        city: json["city"],
        address: json["address"],
        createAt: json["createAt"],
        checkUp:
            List<CheckUp>.from(json["checkUp"].map((x) => CheckUp.fromJson(x))),
        v: json["__v"],
        id: json["ID"],
      );

  Map<String, dynamic> toJson() => {
        "geometry": geometry.toJson(),
        "photo": photo,
        "email": email,
        "is_deleted": isDeleted,
        "phone": List<dynamic>.from(phone.map((x) => x)),
        "times": List<dynamic>.from(
            times.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "totalFeedbacks": totalFeedbacks,
        "averageRating": averageRating,
        "active": active,
        "rating": rating,
        "_id": labIdId,
        "name": name,
        "city": city,
        "address": address,
        "createAt": createAt,
        "checkUp": List<dynamic>.from(checkUp.map((x) => x.toJson())),
        "__v": v,
        "ID": id,
      };
}

class CheckUp {
  bool isBrief;
  int price;
  String id;
  String title;
  String content;
  String img;

  CheckUp({
    this.isBrief,
    this.price,
    this.id,
    this.title,
    this.content,
    this.img,
  });

  factory CheckUp.fromJson(Map<String, dynamic> json) => CheckUp(
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

class PostedBy {
  Geometry geometry;
  String photo;
  String id;
  String phone;
  String fcm;
  String createAt;
  String patientId;
  int v;
  int age;
  String name;

  PostedBy({
    this.geometry,
    this.photo,
    this.id,
    this.phone,
    this.fcm,
    this.createAt,
    this.patientId,
    this.v,
    this.age,
    this.name,
  });

  factory PostedBy.fromJson(Map<String, dynamic> json) => PostedBy(
        geometry: Geometry.fromJson(json["geometry"]),
        photo: json["photo"],
        id: json["_id"],
        phone: json["phone"],
        fcm: json["fcm"],
        createAt: json["createAt"],
        patientId: json["patientID"],
        v: json["__v"],
        age: json["age"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "geometry": geometry.toJson(),
        "photo": photo,
        "_id": id,
        "phone": phone,
        "fcm": fcm,
        "createAt": createAt,
        "patientID": patientId,
        "__v": v,
        "age": age,
        "name": name,
      };
}
