// To parse this JSON data, do
//
//     final drugStoresModel = drugStoresModelFromJson(jsonString);

import 'dart:convert';

import 'labs_model.dart';

DrugStoresModel drugStoresModelFromJson(String str) =>
    DrugStoresModel.fromJson(json.decode(str));

String drugStoresModelToJson(DrugStoresModel data) =>
    json.encode(data.toJson());

class DrugStoresModel {
  List<DrugStore> data;
  int count;

  DrugStoresModel({
    this.data,
    this.count,
  });

  factory DrugStoresModel.fromJson(Map<String, dynamic> json) =>
      DrugStoresModel(
        data: List<DrugStore>.from(
            json["data"].map((x) => DrugStore.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count,
      };
}

class DrugStore {
  String id;
  Geometry geometry;
  String photo;
  bool isDeleted;
  List<String> phone;
  List<List<String>> times;
  List<int> the24Hours;
  String name;
  String city;
  String address;
  String createAt;
  int v;
  String cleaningRating;
  String expertiseRating;
  List<Feedback> feedbacks;
  String satifyRating;
  int totalFeedbacks;
  double averageRatings;
  List<CheckUp> checkUp;
  String email;
  String password;
  List<dynamic> schedule;

  DrugStore({
    this.id,
    this.geometry,
    this.photo,
    this.isDeleted,
    this.phone,
    this.times,
    this.the24Hours,
    this.name,
    this.city,
    this.address,
    this.createAt,
    this.v,
    this.cleaningRating,
    this.expertiseRating,
    this.feedbacks,
    this.satifyRating,
    this.totalFeedbacks,
    this.averageRatings,
    this.checkUp,
    this.email,
    this.password,
    this.schedule,
  });

  factory DrugStore.fromJson(Map<String, dynamic> json) => DrugStore(
        id: json["_id"],
        geometry: Geometry.fromJson(json["geometry"]),
        photo: json["photo"],
        isDeleted: json["is_deleted"],
        phone: List<String>.from(json["phone"].map((x) => x)),
        times: List<List<String>>.from(
            json["times"].map((x) => List<String>.from(x.map((x) => x)))),
        the24Hours: List<int>.from(json["_24Hours"].map((x) => x)),
        name: json["name"],
        city: json["city"],
        address: json["address"],
        createAt: json["createAt"],
        v: json["__v"],
        cleaningRating: json["cleaningRating"],
        expertiseRating: json["expertiseRating"],
        feedbacks: json["feedbacks"] == null
            ? []
            : List<Feedback>.from(
                json["feedbacks"].map((x) => Feedback.fromJson(x))),
        satifyRating: json["satifyRating"],
        totalFeedbacks: json["totalFeedbacks"],
        averageRatings: json["averageRatings"]?.toDouble(),
        checkUp: json["checkUp"] == null
            ? []
            : List<CheckUp>.from(
                json["checkUp"].map((x) => CheckUp.fromJson(x))),
        email: json["email"],
        password: json["password"],
        schedule: json["schedule"] == null
            ? []
            : List<dynamic>.from(json["schedule"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "geometry": geometry.toJson(),
        "photo": photo,
        "is_deleted": isDeleted,
        "phone": List<dynamic>.from(phone.map((x) => x)),
        "times": List<dynamic>.from(
            times.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "_24Hours": List<dynamic>.from(the24Hours.map((x) => x)),
        "name": name,
        "city": city,
        "address": address,
        "createAt": createAt,
        "__v": v,
        "cleaningRating": cleaningRating,
        "expertiseRating": expertiseRating,
        "feedbacks": feedbacks == null
            ? []
            : List<dynamic>.from(feedbacks.map((x) => x.toJson())),
        "satifyRating": satifyRating,
        "totalFeedbacks": totalFeedbacks,
        "averageRatings": averageRatings,
        "checkUp": checkUp == null
            ? []
            : List<dynamic>.from(checkUp.map((x) => x.toJson())),
        "email": email,
        "password": password,
        "schedule":
            schedule == null ? [] : List<dynamic>.from(schedule.map((x) => x)),
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
  String pharmacyId;

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
    this.pharmacyId,
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
        pharmacyId: json["pharmacyId"],
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
        "pharmacyId": pharmacyId,
      };
}
