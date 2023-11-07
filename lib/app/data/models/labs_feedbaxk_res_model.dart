// To parse this JSON data, do
//
//     final labsFeedbackModel = labsFeedbackModelFromJson(jsonString);

import 'dart:convert';

import 'labs_model.dart';

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
  String id;
  String comment;
  String whoPosted;
  PostedBy postedBy;
  String photo;
  String createAt;
  String commentId;
  String labId;
  int v;

  LabsFeedback({
    this.id,
    this.comment,
    this.whoPosted,
    this.postedBy,
    this.photo,
    this.createAt,
    this.commentId,
    this.labId,
    this.v,
  });

  factory LabsFeedback.fromJson(Map<String, dynamic> json) => LabsFeedback(
        id: json["_id"],
        comment: json["comment"],
        whoPosted: json["whoPosted"],
        postedBy: PostedBy.fromJson(json["postedBy"]),
        photo: json["photo"],
        createAt: json["createAt"],
        commentId: json["commentId"],
        labId: json["labId"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "comment": comment,
        "whoPosted": whoPosted,
        "postedBy": postedBy.toJson(),
        "photo": photo,
        "createAt": createAt,
        "commentId": commentId,
        "labId": labId,
        "__v": v,
      };
}

class PostedBy {
  Geometry geometry;
  String photo;
  String id;
  String email;
  String language;
  String fcm;
  String createAt;
  String patientId;
  int v;
  String city;
  String gender;
  String name;
  String phone;
  int age;

  PostedBy({
    this.geometry,
    this.photo,
    this.id,
    this.email,
    this.language,
    this.fcm,
    this.createAt,
    this.patientId,
    this.v,
    this.city,
    this.gender,
    this.name,
    this.phone,
    this.age,
  });

  factory PostedBy.fromJson(Map<String, dynamic> json) => PostedBy(
        geometry: Geometry.fromJson(json["geometry"]),
        photo: json["photo"],
        id: json["_id"],
        email: json["email"],
        language: json["language"],
        fcm: json["fcm"],
        createAt: json["createAt"],
        patientId: json["patientID"],
        v: json["__v"],
        city: json["city"],
        gender: json["gender"],
        name: json["name"],
        phone: json["phone"],
        age: json["age"],
      );

  Map<String, dynamic> toJson() => {
        "geometry": geometry.toJson(),
        "photo": photo,
        "_id": id,
        "email": email,
        "language": language,
        "fcm": fcm,
        "createAt": createAt,
        "patientID": patientId,
        "__v": v,
        "city": city,
        "gender": gender,
        "name": name,
        "phone": phone,
        "age": age,
      };
}
