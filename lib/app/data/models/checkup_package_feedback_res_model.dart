// To parse this JSON data, do
//
//     final checkupFeedbackResModel = checkupFeedbackResModelFromJson(jsonString);

import 'dart:convert';

CheckupFeedbackResModel checkupFeedbackResModelFromJson(String str) =>
    CheckupFeedbackResModel.fromJson(json.decode(str));

String checkupFeedbackResModelToJson(CheckupFeedbackResModel data) =>
    json.encode(data.toJson());

class CheckupFeedbackResModel {
  List<PackageFeedback>? data;
  int? averageRating;
  int? totalRating;

  CheckupFeedbackResModel({
    this.data,
    this.averageRating,
    this.totalRating,
  });

  factory CheckupFeedbackResModel.fromJson(Map<String, dynamic> json) =>
      CheckupFeedbackResModel(
        data: List<PackageFeedback>.from(
            json["data"].map((x) => PackageFeedback.fromJson(x))),
        averageRating: json["averageRating"],
        totalRating: json["totalRating"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "averageRating": averageRating,
        "totalRating": totalRating,
      };
}

class PackageFeedback {
  String? id;
  String? comment;
  String? whoPosted;
  PostedBy? postedBy;
  String? photo;
  String? createAt;
  String? commentId;
  String? rating;
  String? packageId;
  int? v;

  PackageFeedback({
    this.id,
    this.comment,
    this.whoPosted,
    this.postedBy,
    this.photo,
    this.createAt,
    this.commentId,
    this.rating,
    this.packageId,
    this.v,
  });

  factory PackageFeedback.fromJson(Map<String, dynamic> json) =>
      PackageFeedback(
        id: json["_id"],
        comment: json["comment"],
        whoPosted: json["whoPosted"],
        postedBy: PostedBy.fromJson(json["postedBy"]),
        photo: json["photo"],
        createAt: json["createAt"],
        commentId: json["commentId"],
        rating: json["rating"],
        packageId: json["packageId"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "comment": comment,
        "whoPosted": whoPosted,
        "postedBy": postedBy!.toJson(),
        "photo": photo,
        "createAt": createAt,
        "commentId": commentId,
        "rating": rating,
        "packageId": packageId,
        "__v": v,
      };
}

class PostedBy {
  Geometry? geometry;
  String? photo;
  String? id;
  String? email;
  String? language;
  String? fcm;
  String? createAt;
  String? patientId;
  int? v;
  String? city;
  String? gender;
  String? name;
  String? phone;
  int? age;

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
        "geometry": geometry!.toJson(),
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

class Geometry {
  String? type;
  List<double>? coordinates;

  Geometry({
    this.type,
    this.coordinates,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates!.map((x) => x)),
      };
}
