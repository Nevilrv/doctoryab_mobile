// To parse this JSON data, do
//
//     final doctorFeedbackResModel = doctorFeedbackResModelFromJson(jsonString);

import 'dart:convert';

DoctorFeedbackResModel doctorFeedbackResModelFromJson(String str) =>
    DoctorFeedbackResModel.fromJson(json.decode(str));

String doctorFeedbackResModelToJson(DoctorFeedbackResModel data) =>
    json.encode(data.toJson());

class DoctorFeedbackResModel {
  List<FeedbackData> data;
  int averageRating;
  int totalFeedbacks;

  DoctorFeedbackResModel({
    this.data,
    this.averageRating,
    this.totalFeedbacks,
  });

  factory DoctorFeedbackResModel.fromJson(Map<String, dynamic> json) =>
      DoctorFeedbackResModel(
        data: List<FeedbackData>.from(
            json["data"].map((x) => FeedbackData.fromJson(x))),
        averageRating: json["averageRating"],
        totalFeedbacks: json["totalFeedbacks"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "averageRating": averageRating,
        "totalFeedbacks": totalFeedbacks,
      };
}

class FeedbackData {
  String datumId;
  String comment;
  String whoPosted;
  PostedBy postedBy;
  String photo;
  String createAt;
  String commentId;
  String cleaningRating;
  String satifyRating;
  String expertiseRating;
  DoctorId doctorId;
  String id;
  int v;
  int averageRating;

  FeedbackData({
    this.datumId,
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
    this.id,
    this.v,
    this.averageRating,
  });

  factory FeedbackData.fromJson(Map<String, dynamic> json) => FeedbackData(
        datumId: json["_id"],
        comment: json["comment"],
        whoPosted: json["whoPosted"],
        postedBy: PostedBy.fromJson(json["postedBy"]),
        photo: json["photo"],
        createAt: json["createAt"],
        commentId: json["commentId"],
        cleaningRating: json["cleaningRating"],
        satifyRating: json["satifyRating"],
        expertiseRating: json["expertiseRating"],
        doctorId: DoctorId.fromJson(json["doctorId"]),
        id: json["ID"],
        v: json["__v"],
        averageRating: json["averageRating"],
      );

  Map<String, dynamic> toJson() => {
        "_id": datumId,
        "comment": comment,
        "whoPosted": whoPosted,
        "postedBy": postedBy.toJson(),
        "photo": photo,
        "createAt": createAt,
        "commentId": commentId,
        "cleaningRating": cleaningRating,
        "satifyRating": satifyRating,
        "expertiseRating": expertiseRating,
        "doctorId": doctorId.toJson(),
        "ID": id,
        "__v": v,
        "averageRating": averageRating,
      };
}

class DoctorId {
  Geometry geometry;
  List<dynamic> exp;
  List<dynamic> edu;
  List<dynamic> lang;
  List<dynamic> awards;
  String photo;
  int stars;
  int popularity;
  int treatment;
  int knowledge;
  int cleaning;
  int countOfPatient;
  bool isDeleted;
  int totalStar;
  bool active;
  bool confirmed;
  List<dynamic> comments;
  int doctor;
  List<dynamic> tags;
  bool verification;
  int type;
  bool isActive;
  String totalFeedbacks;
  String fee;
  String doctorIdId;
  String email;
  String fullname;
  int id;
  String createAt;
  int v;
  String address;
  String category;
  String city;
  String detail;
  int gender;
  String lname;
  String name;
  String phone;
  String speciality;

  DoctorId({
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
    this.isDeleted,
    this.totalStar,
    this.active,
    this.confirmed,
    this.comments,
    this.doctor,
    this.tags,
    this.verification,
    this.type,
    this.isActive,
    this.totalFeedbacks,
    this.fee,
    this.doctorIdId,
    this.email,
    this.fullname,
    this.id,
    this.createAt,
    this.v,
    this.address,
    this.category,
    this.city,
    this.detail,
    this.gender,
    this.lname,
    this.name,
    this.phone,
    this.speciality,
  });

  factory DoctorId.fromJson(Map<String, dynamic> json) => DoctorId(
        geometry: Geometry.fromJson(json["geometry"]),
        exp: List<dynamic>.from(json["Exp"].map((x) => x)),
        edu: List<dynamic>.from(json["Edu"].map((x) => x)),
        lang: List<dynamic>.from(json["Lang"].map((x) => x)),
        awards: List<dynamic>.from(json["Awards"].map((x) => x)),
        photo: json["photo"],
        stars: json["stars"],
        popularity: json["popularity"],
        treatment: json["treatment"],
        knowledge: json["knowledge"],
        cleaning: json["cleaning"],
        countOfPatient: json["countOfPatient"],
        isDeleted: json["is_deleted"],
        totalStar: json["totalStar"],
        active: json["active"],
        confirmed: json["confirmed"],
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        doctor: json["doctor"],
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        verification: json["Verification"],
        type: json["type"],
        isActive: json["is_active"],
        totalFeedbacks: json["totalFeedbacks"],
        fee: json["fee"],
        doctorIdId: json["_id"],
        email: json["email"],
        fullname: json["fullname"],
        id: json["ID"],
        createAt: json["createAt"],
        v: json["__v"],
        address: json["address"],
        category: json["category"],
        city: json["city"],
        detail: json["detail"],
        gender: json["gender"],
        lname: json["lname"],
        name: json["name"],
        phone: json["phone"],
        speciality: json["speciality"],
      );

  Map<String, dynamic> toJson() => {
        "geometry": geometry.toJson(),
        "Exp": List<dynamic>.from(exp.map((x) => x)),
        "Edu": List<dynamic>.from(edu.map((x) => x)),
        "Lang": List<dynamic>.from(lang.map((x) => x)),
        "Awards": List<dynamic>.from(awards.map((x) => x)),
        "photo": photo,
        "stars": stars,
        "popularity": popularity,
        "treatment": treatment,
        "knowledge": knowledge,
        "cleaning": cleaning,
        "countOfPatient": countOfPatient,
        "is_deleted": isDeleted,
        "totalStar": totalStar,
        "active": active,
        "confirmed": confirmed,
        "comments": List<dynamic>.from(comments.map((x) => x)),
        "doctor": doctor,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "Verification": verification,
        "type": type,
        "is_active": isActive,
        "totalFeedbacks": totalFeedbacks,
        "fee": fee,
        "_id": doctorIdId,
        "email": email,
        "fullname": fullname,
        "ID": id,
        "createAt": createAt,
        "__v": v,
        "address": address,
        "category": category,
        "city": city,
        "detail": detail,
        "gender": gender,
        "lname": lname,
        "name": name,
        "phone": phone,
        "speciality": speciality,
      };
}

class Geometry {
  String type;
  List<double> coordinates;

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
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
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
