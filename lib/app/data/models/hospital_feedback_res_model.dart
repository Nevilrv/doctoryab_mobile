// To parse this JSON data, do
//
//     final hoapitalFeedBackResModel = hoapitalFeedBackResModelFromJson(jsonString);

import 'dart:convert';

import 'labs_model.dart';

HospitalFeedBackResModel hospitalFeedBackResModelFromJson(String str) =>
    HospitalFeedBackResModel.fromJson(json.decode(str));

String hospitalFeedBackResModelToJson(HospitalFeedBackResModel data) =>
    json.encode(data.toJson());

class HospitalFeedBackResModel {
  List<HospitalFeedback> data;
  double averageRating;
  int totalFeedbacks;

  HospitalFeedBackResModel({
    this.data,
    this.averageRating,
    this.totalFeedbacks,
  });

  factory HospitalFeedBackResModel.fromJson(Map<String, dynamic> json) =>
      HospitalFeedBackResModel(
        data: List<HospitalFeedback>.from(
            json["data"].map((x) => HospitalFeedback.fromJson(x))),
        averageRating: json["averageRating"]?.toDouble(),
        totalFeedbacks: json["totalFeedbacks"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "averageRating": averageRating,
        "totalFeedbacks": totalFeedbacks,
      };
}

class HospitalFeedback {
  String id;
  String comment;
  String whoPosted;
  PostedBy postedBy;
  String photo;
  String createAt;
  String commentId;
  String cleaningRating;
  String satifyRating;
  String expertiseRating;
  String doctorId;
  int v;

  HospitalFeedback({
    this.id,
    this.comment,
    this.whoPosted,
    this.postedBy,
    this.photo,
    this.createAt,
    this.commentId,
    this.cleaningRating,
    this.satifyRating,
    this.expertiseRating,
    this.doctorId,
    this.v,
  });

  factory HospitalFeedback.fromJson(Map<String, dynamic> json) =>
      HospitalFeedback(
        id: json["_id"],
        comment: json["comment"],
        whoPosted: json["whoPosted"],
        postedBy: PostedBy.fromJson(json["postedBy"]),
        photo: json["photo"],
        createAt: json["createAt"],
        commentId: json["commentId"],
        cleaningRating: json["cleaningRating"],
        satifyRating: json["satifyRating"],
        expertiseRating: json["expertiseRating"],
        doctorId: json["doctorId"],
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
        "cleaningRating": cleaningRating,
        "satifyRating": satifyRating,
        "expertiseRating": expertiseRating,
        "doctorId": doctorId,
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
