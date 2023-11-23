// To parse this JSON data, do
//
//     final doctors = doctorsFromJson(jsonString);

import 'dart:convert';

import 'package:doctor_yab/app/data/models/categories_model.dart';

import 'labs_model.dart';

Doctors doctorsFromJson(String str) => Doctors.fromJson(json.decode(str));

String doctorsToJson(Doctors data) => json.encode(data.toJson());

class Doctors {
  bool success;
  List<Doctor> data;

  Doctors({
    this.success,
    this.data,
  });

  factory Doctors.fromJson(Map<String, dynamic> json) => Doctors(
        success: json["success"],
        data: List<Doctor>.from(json["data"].map((x) => Doctor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Doctor {
  String datumId;
  Geometry geometry;
  List<dynamic> exp;
  List<dynamic> edu;
  String photo;
  dynamic stars;
  int popularity;
  dynamic treatment;
  dynamic knowledge;
  dynamic cleaning;
  int countOfPatient;
  dynamic totalStar;
  dynamic totalCleaning;
  dynamic totalTreatment;
  dynamic totalknowledge;
  List<dynamic> comments;
  int doctor;
  List<String> tags;
  int type;
  bool isActive;
  String email;
  String fullname;
  String address;
  Category category;
  String city;
  int day;
  String detail;
  int gender;
  String lname;
  int month;
  String name;
  String phone;
  String speciality;
  int year;
  int id;
  List<dynamic> awards;
  List<dynamic> lang;
  bool verification;
  String fee;
  String cleaningRating;
  String expertiseRating;
  List<Feedback> feedbacks;
  String satifyRating;
  dynamic totalFeedbacks;
  double averageRatings;
  Coordinate coordinate;

  Doctor({
    this.datumId,
    this.geometry,
    this.exp,
    this.edu,
    this.photo,
    this.stars,
    this.popularity,
    this.treatment,
    this.knowledge,
    this.cleaning,
    this.countOfPatient,
    this.totalStar,
    this.totalCleaning,
    this.totalTreatment,
    this.totalknowledge,
    this.comments,
    this.doctor,
    this.tags,
    this.type,
    this.isActive,
    this.email,
    this.fullname,
    this.address,
    this.category,
    this.city,
    this.day,
    this.detail,
    this.gender,
    this.lname,
    this.month,
    this.name,
    this.phone,
    this.speciality,
    this.year,
    this.id,
    this.awards,
    this.lang,
    this.verification,
    this.fee,
    this.cleaningRating,
    this.expertiseRating,
    this.feedbacks,
    this.satifyRating,
    this.totalFeedbacks,
    this.averageRatings,
    this.coordinate,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        datumId: json["_id"],
        geometry: Geometry.fromJson(json["geometry"]),
        exp: json["Exp"] == null
            ? []
            : List<dynamic>.from(json["Exp"].map((x) => x)),
        edu: json["Edu"] == null
            ? []
            : List<dynamic>.from(json["Edu"].map((x) => x)),
        photo: json["photo"],
        stars: json["stars"],
        popularity: json["popularity"],
        treatment: json["treatment"],
        knowledge: json["knowledge"],
        cleaning: json["cleaning"],
        countOfPatient: json["countOfPatient"],
        totalStar: json["totalStar"],
        totalCleaning: json["totalCleaning"],
        totalTreatment: json["totalTreatment"],
        totalknowledge: json["totalknowledge"],
        comments: json["comments"] == null
            ? []
            : List<dynamic>.from(json["comments"].map((x) => x)),
        doctor: json["doctor"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        type: json["type"],
        isActive: json["is_active"],
        email: json["email"],
        fullname: json["fullname"],
        address: json["address"],
        category: Category.fromJson(json["category"]),
        city: json["city"],
        day: json["day"],
        detail: json["detail"],
        gender: json["gender"],
        lname: json["lname"],
        month: json["month"],
        name: json["name"],
        phone: json["phone"],
        speciality: json["speciality"],
        year: json["year"],
        id: json["ID"],
        awards: json["Awards"] == null
            ? []
            : List<dynamic>.from(json["Awards"].map((x) => x)),
        lang: json["Lang"] == null
            ? []
            : List<dynamic>.from(json["Lang"].map((x) => x)),
        verification: json["Verification"],
        fee: json["fee"],
        cleaningRating: json["cleaningRating"],
        expertiseRating: json["expertiseRating"],
        feedbacks: json["feedbacks"] == null
            ? []
            : List<Feedback>.from(
                json["feedbacks"].map((x) => Feedback.fromJson(x))),
        satifyRating: json["satifyRating"],
        totalFeedbacks: json["totalFeedbacks"],
        averageRatings: json["averageRatings"]?.toDouble(),
        coordinate: json["coordinate"] == null
            ? null
            : Coordinate.fromJson(json["coordinate"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": datumId,
        "geometry": geometry.toJson(),
        "Exp": exp == null ? [] : List<dynamic>.from(exp.map((x) => x)),
        "Edu": edu == null ? [] : List<dynamic>.from(edu.map((x) => x)),
        "photo": photo,
        "stars": stars,
        "popularity": popularity,
        "treatment": treatment,
        "knowledge": knowledge,
        "cleaning": cleaning,
        "countOfPatient": countOfPatient,
        "totalStar": totalStar,
        "totalCleaning": totalCleaning,
        "totalTreatment": totalTreatment,
        "totalknowledge": totalknowledge,
        "comments":
            comments == null ? [] : List<dynamic>.from(comments.map((x) => x)),
        "doctor": doctor,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "type": type,
        "is_active": isActive,
        "email": email,
        "fullname": fullname,
        "address": address,
        "category": category.toJson(),
        "city": city,
        "day": day,
        "detail": detail,
        "gender": gender,
        "lname": lname,
        "month": month,
        "name": name,
        "phone": phone,
        "speciality": speciality,
        "year": year,
        "ID": id,
        "Awards":
            awards == null ? [] : List<dynamic>.from(awards.map((x) => x)),
        "Lang": lang == null ? [] : List<dynamic>.from(lang.map((x) => x)),
        "Verification": verification,
        "fee": fee,
        "cleaningRating": cleaningRating,
        "expertiseRating": expertiseRating,
        "feedbacks": feedbacks == null
            ? []
            : List<dynamic>.from(feedbacks.map((x) => x.toJson())),
        "satifyRating": satifyRating,
        "totalFeedbacks": totalFeedbacks,
        "averageRatings": averageRatings,
        "coordinate": coordinate?.toJson(),
      };
}

class Coordinate {
  double lat;
  double lng;

  Coordinate({
    this.lat,
    this.lng,
  });

  factory Coordinate.fromJson(Map<String, dynamic> json) => Coordinate(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class Feedback {
  String comment;
  String whoPosted;
  String postedBy;
  String photo;
  String createAt;
  String commentId;
  int cleaningRating;
  int satifyRating;
  int expertiseRating;
  String doctorId;

  Feedback({
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
  });

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
        comment: json["comment"],
        whoPosted: json["whoPosted"],
        postedBy: json["postedBy"],
        photo: json["photo"],
        createAt: json["createAt"],
        commentId: json["commentId"],
        cleaningRating: json["cleaningRating"],
        satifyRating: json["satifyRating"],
        expertiseRating: json["expertiseRating"],
        doctorId: json["doctorId"],
      );

  Map<String, dynamic> toJson() => {
        "comment": comment,
        "whoPosted": whoPosted,
        "postedBy": postedBy,
        "photo": photo,
        "createAt": createAt,
        "commentId": commentId,
        "cleaningRating": cleaningRating,
        "satifyRating": satifyRating,
        "expertiseRating": expertiseRating,
        "doctorId": doctorId,
      };
}
