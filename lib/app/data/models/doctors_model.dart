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
  List<dynamic> lang;
  List<dynamic> awards;
  String photo;
  dynamic stars;
  int popularity;
  dynamic treatment;
  dynamic knowledge;
  dynamic cleaning;
  dynamic countOfPatient;
  dynamic totalStar;
  dynamic totalCleaning;
  dynamic totalTreatment;
  dynamic totalknowledge;
  List<dynamic> comments;
  int doctor;
  List<String> tags;
  bool verification;
  int type;
  bool isActive;
  String fee;
  String email;
  String fullname;
  int id;
  String address;
  Category category;
  String city;
  String detail;
  int gender;
  String lname;
  String name;
  String phone;
  String speciality;
  List<Schedule> schedules;
  dynamic totalFeedbacks;
  dynamic averageRatings;
  int totalExperience;
  int day;
  int month;
  int year;
  bool active;

  Doctor({
    this.datumId,
    this.geometry,
    this.exp,
    this.edu,
    this.lang,
    this.awards,
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
    this.verification,
    this.type,
    this.isActive,
    this.fee,
    this.email,
    this.fullname,
    this.id,
    this.address,
    this.category,
    this.city,
    this.detail,
    this.gender,
    this.lname,
    this.name,
    this.phone,
    this.speciality,
    this.schedules,
    this.totalFeedbacks,
    this.averageRatings,
    this.totalExperience,
    this.day,
    this.month,
    this.year,
    this.active,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        datumId: json["_id"],
        geometry: Geometry.fromJson(json["geometry"]),
        exp: json["Exp"] == null
            ? null
            : List<dynamic>.from(json["Exp"].map((x) => x)),
        edu: json["Edu"] == null
            ? null
            : List<dynamic>.from(json["Edu"].map((x) => x)),
        lang: json["Lang"] == null
            ? null
            : List<dynamic>.from(json["Lang"].map((x) => x)),
        awards: json["Awards"] == null
            ? null
            : List<dynamic>.from(json["Awards"].map((x) => x)),
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
            ? null
            : List<dynamic>.from(json["comments"].map((x) => x)),
        doctor: json["doctor"],
        tags: json["tags"] == null
            ? null
            : List<String>.from(json["tags"].map((x) => x)),
        verification: json["Verification"],
        type: json["type"],
        isActive: json["is_active"],
        fee: json["fee"],
        email: json["email"],
        fullname: json["fullname"],
        id: json["ID"],
        address: json["address"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        city: json["city"],
        detail: json["detail"],
        gender: json["gender"],
        lname: json["lname"],
        name: json["name"],
        phone: json["phone"],
        speciality: json["speciality"],
        schedules: json["schedules"] == null
            ? []
            : List<Schedule>.from(
                json["schedules"].map((x) => Schedule.fromJson(x))),
        totalFeedbacks: json["totalFeedbacks"],
        averageRatings: json["averageRatings"],
        totalExperience: json["totalExperience"],
        day: json["day"],
        month: json["month"],
        year: json["year"],
        active: json["active"] == null ? false : json["active"],
      );

  Map<String, dynamic> toJson() => {
        "_id": datumId,
        "geometry": geometry.toJson(),
        "Exp": exp == null ? null : List<dynamic>.from(exp.map((x) => x)),
        "Edu": edu == null ? null : List<dynamic>.from(edu.map((x) => x)),
        "Lang": lang == null ? null : List<dynamic>.from(lang.map((x) => x)),
        "Awards":
            awards == null ? null : List<dynamic>.from(awards.map((x) => x)),
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
        "comments": comments == null
            ? null
            : List<dynamic>.from(comments.map((x) => x)),
        "doctor": doctor,
        "tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x)),
        "Verification": verification,
        "type": type,
        "is_active": isActive,
        "fee": fee,
        "email": email,
        "fullname": fullname,
        "ID": id,
        "address": address,
        "category": category == null ? null : category.toJson(),
        "city": city,
        "detail": detail,
        "gender": gender,
        "lname": lname,
        "name": name,
        "phone": phone,
        "speciality": speciality,
        "schedules": schedules == null
            ? []
            : List<dynamic>.from(schedules.map((x) => x.toJson())),
        "totalFeedbacks": totalFeedbacks,
        "averageRatings": averageRatings,
        "totalExperience": totalExperience,
        "day": day,
        "month": month,
        "year": year,
        "active": active == null ? null : active,
      };
}

class Schedule {
  List<String> times;
  List<dynamic> counts;
  String id;
  int dayOfWeek;
  String user;
  int v;

  Schedule({
    this.times,
    this.counts,
    this.id,
    this.dayOfWeek,
    this.user,
    this.v,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        times: List<String>.from(json["times"].map((x) => x)),
        counts: List<dynamic>.from(json["counts"].map((x) => x)),
        id: json["_id"],
        dayOfWeek: json["dayOfWeek"],
        user: json["user"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "times": List<dynamic>.from(times.map((x) => x)),
        "counts": List<dynamic>.from(counts.map((x) => x)),
        "_id": id,
        "dayOfWeek": dayOfWeek,
        "user": user,
        "__v": v,
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
