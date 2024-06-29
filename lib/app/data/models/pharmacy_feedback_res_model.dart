// To parse this JSON data, do
//
//     final pharmacyFeedbackResModel = pharmacyFeedbackResModelFromJson(jsonString);

import 'dart:convert';
import 'package:doctor_yab/app/data/models/labs_model.dart';

PharmacyFeedbackResModel pharmacyFeedbackResModelFromJson(String str) =>
    PharmacyFeedbackResModel.fromJson(json.decode(str));

String pharmacyFeedbackResModelToJson(PharmacyFeedbackResModel data) =>
    json.encode(data.toJson());

class PharmacyFeedbackResModel {
  List<PharmacyFeedback>? data;
  double? averageRating;
  int? totalFeedbacks;

  PharmacyFeedbackResModel({
    this.data,
    this.averageRating,
    this.totalFeedbacks,
  });

  factory PharmacyFeedbackResModel.fromJson(Map<String, dynamic> json) =>
      PharmacyFeedbackResModel(
        data: List<PharmacyFeedback>.from(
            json["data"].map((x) => PharmacyFeedback.fromJson(x))),
        averageRating: json["averageRating"]?.toDouble(),
        totalFeedbacks: json["totalFeedbacks"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "averageRating": averageRating,
        "totalFeedbacks": totalFeedbacks,
      };
}

class PharmacyFeedback {
  String? datumId;
  String? comment;
  String? whoPosted;
  PostedBy? postedBy;
  String? photo;
  String? createAt;
  String? commentId;
  String? cleaningRating;
  String? satifyRating;
  String? expertiseRating;
  PharmacyId? pharmacyId;
  String? id;
  int? v;
  double? averageRating;

  PharmacyFeedback({
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
    this.pharmacyId,
    this.id,
    this.v,
    this.averageRating,
  });

  factory PharmacyFeedback.fromJson(Map<String, dynamic> json) =>
      PharmacyFeedback(
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
        pharmacyId: PharmacyId.fromJson(json["pharmacyId"]),
        id: json["ID"],
        v: json["__v"],
        averageRating: json["averageRating"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": datumId,
        "comment": comment,
        "whoPosted": whoPosted,
        "postedBy": postedBy!.toJson(),
        "photo": photo,
        "createAt": createAt,
        "commentId": commentId,
        "cleaningRating": cleaningRating,
        "satifyRating": satifyRating,
        "expertiseRating": expertiseRating,
        "pharmacyId": pharmacyId!.toJson(),
        "ID": id,
        "__v": v,
        "averageRating": averageRating,
      };
}

class PharmacyId {
  Geometry? geometry;
  String? photo;
  String? email;
  bool? isDeleted;
  List<String>? phone;
  String? totalFeedbacks;
  String? averageRating;
  bool? active;
  List<List<String>>? times;
  List<int>? the24Hours;
  List<int>? schedule;
  String? pharmacyIdId;
  String? name;
  String? city;
  String? address;
  String? createAt;
  int? v;
  int? id;
  List<dynamic>? checkUp;

  PharmacyId({
    this.geometry,
    this.photo,
    this.email,
    this.isDeleted,
    this.phone,
    this.totalFeedbacks,
    this.averageRating,
    this.active,
    this.times,
    this.the24Hours,
    this.schedule,
    this.pharmacyIdId,
    this.name,
    this.city,
    this.address,
    this.createAt,
    this.v,
    this.id,
    this.checkUp,
  });

  factory PharmacyId.fromJson(Map<String, dynamic> json) => PharmacyId(
        geometry: Geometry.fromJson(json["geometry"]),
        photo: json["photo"],
        email: json["email"],
        isDeleted: json["is_deleted"],
        phone: List<String>.from(json["phone"].map((x) => x)),
        totalFeedbacks: json["totalFeedbacks"],
        averageRating: json["averageRating"],
        active: json["active"],
        times: List<List<String>>.from(
            json["times"].map((x) => List<String>.from(x.map((x) => x)))),
        the24Hours: List<int>.from(json["_24Hours"].map((x) => x)),
        schedule: List<int>.from(json["schedule"].map((x) => x)),
        pharmacyIdId: json["_id"],
        name: json["name"],
        city: json["city"],
        address: json["address"],
        createAt: json["createAt"],
        v: json["__v"],
        id: json["ID"],
        checkUp: List<dynamic>.from(json["checkUp"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "geometry": geometry!.toJson(),
        "photo": photo,
        "email": email,
        "is_deleted": isDeleted,
        "phone": List<dynamic>.from(phone!.map((x) => x)),
        "totalFeedbacks": totalFeedbacks,
        "averageRating": averageRating,
        "active": active,
        "times": List<dynamic>.from(
            times!.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "_24Hours": List<dynamic>.from(the24Hours!.map((x) => x)),
        "schedule": List<dynamic>.from(schedule!.map((x) => x)),
        "_id": pharmacyIdId,
        "name": name,
        "city": city,
        "address": address,
        "createAt": createAt,
        "__v": v,
        "ID": id,
        "checkUp": List<dynamic>.from(checkUp!.map((x) => x)),
      };
}

class PostedBy {
  Geometry? geometry;
  String? photo;
  String? id;
  String? phone;
  String? fcm;
  String? createAt;
  String? patientId;
  int? v;
  int? age;
  String? name;

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
        "geometry": geometry!.toJson(),
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
