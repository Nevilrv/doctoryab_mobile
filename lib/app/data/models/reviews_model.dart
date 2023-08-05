// To parse this JSON data, do
//
//     final reviewsModel = reviewsModelFromJson(jsonString);

import 'dart:convert';

ReviewsModel reviewsModelFromJson(String str) =>
    ReviewsModel.fromJson(json.decode(str));

String reviewsModelToJson(ReviewsModel data) => json.encode(data.toJson());

class ReviewsModel {
  ReviewsModel({
    this.data,
    this.totalHospitalVisiter,
    this.avarageHospitalRating,
  });

  final List<Review> data;
  final int totalHospitalVisiter;
  final double avarageHospitalRating;

  ReviewsModel copyWith({
    List<Review> data,
    int totalHospitalVisiter,
    double avarageHospitalRating,
  }) =>
      ReviewsModel(
        data: data ?? this.data,
        totalHospitalVisiter: totalHospitalVisiter ?? this.totalHospitalVisiter,
        avarageHospitalRating:
            avarageHospitalRating ?? this.avarageHospitalRating,
      );

  factory ReviewsModel.fromJson(Map<String, dynamic> json) => ReviewsModel(
        data: json["data"] == null
            ? null
            : List<Review>.from(json["data"].map((x) => Review.fromJson(x))),
        totalHospitalVisiter: json["totalHospitalVisiter"] == null
            ? null
            : json["totalHospitalVisiter"],
        avarageHospitalRating: json["AvarageHospitalRating"] == null
            ? null
            : json["AvarageHospitalRating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "totalHospitalVisiter":
            totalHospitalVisiter == null ? null : totalHospitalVisiter,
        "AvarageHospitalRating":
            avarageHospitalRating == null ? null : avarageHospitalRating,
      };
}

class Review {
  Review({
    this.name,
    this.email,
    this.photo,
    this.visitor,
    this.speciality,
    this.docTotalRating,
    this.id,
    this.comment,
  });

  final String name;
  final String email;
  final String photo;
  final int visitor;
  final String speciality;
  final double docTotalRating;
  final String id;
  final String comment;

  Review copyWith({
    String name,
    String email,
    String photo,
    int visitor,
    String speciality,
    double docTotalRating,
    String id,
    String comment,
  }) =>
      Review(
        name: name ?? this.name,
        email: email ?? this.email,
        photo: photo ?? this.photo,
        visitor: visitor ?? this.visitor,
        speciality: speciality ?? this.speciality,
        docTotalRating: docTotalRating ?? this.docTotalRating,
        id: id ?? this.id,
        comment: comment ?? this.comment,
      );

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        name: json["Name"] == null ? null : json["Name"],
        email: json["Email"] == null ? null : json["Email"],
        photo: json["photo"] == null ? null : json["photo"],
        visitor: json["visitor"] == null ? null : json["visitor"],
        speciality: json["speciality"] == null ? null : json["speciality"],
        docTotalRating: json["DocTotalRating"] == null
            ? null
            : json["DocTotalRating"].toDouble(),
        id: json["id"] == null ? null : json["id"],
        comment: json["comment"] == null ? null : json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name == null ? null : name,
        "Email": email == null ? null : email,
        "photo": photo == null ? null : photo,
        "visitor": visitor == null ? null : visitor,
        "speciality": speciality == null ? null : speciality,
        "DocTotalRating": docTotalRating == null ? null : docTotalRating,
        "id": id == null ? null : id,
        "comment": comment == null ? null : comment,
      };
}
