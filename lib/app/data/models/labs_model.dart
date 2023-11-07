// To parse this JSON data, do
//
//     final labsModel = labsModelFromJson(jsonString);

import 'dart:convert';

LabsModel labsModelFromJson(String str) => LabsModel.fromJson(json.decode(str));

String labsModelToJson(LabsModel data) => json.encode(data.toJson());

class LabsModel {
  List<Labs> data;
  int count;

  LabsModel({
    this.data,
    this.count,
  });

  factory LabsModel.fromJson(Map<String, dynamic> json) => LabsModel(
        data: List<Labs>.from(json["data"].map((x) => Labs.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count,
      };
}

class Labs {
  String datumId;
  Geometry geometry;
  String photo;
  bool isDeleted;
  List<String> phone;
  List<List<String>> times;
  String name;
  String city;
  String address;
  String createAt;
  int v;
  List<CheckUp> checkUp;
  int id;
  List<Feedback> feedbacks;
  String rating;

  Labs({
    this.datumId,
    this.geometry,
    this.photo,
    this.isDeleted,
    this.phone,
    this.times,
    this.name,
    this.city,
    this.address,
    this.createAt,
    this.v,
    this.checkUp,
    this.id,
    this.feedbacks,
    this.rating,
  });

  factory Labs.fromJson(Map<String, dynamic> json) => Labs(
        datumId: json["_id"],
        geometry: Geometry.fromJson(json["geometry"]),
        photo: json["photo"],
        isDeleted: json["is_deleted"],
        phone: List<String>.from(json["phone"].map((x) => x)),
        times: List<List<String>>.from(
            json["times"].map((x) => List<String>.from(x.map((x) => x)))),
        name: json["name"],
        city: json["city"],
        address: json["address"],
        createAt: json["createAt"],
        v: json["__v"],
        checkUp:
            List<CheckUp>.from(json["checkUp"].map((x) => CheckUp.fromJson(x))),
        id: json["ID"],
        feedbacks: json["feedbacks"] == null
            ? []
            : List<Feedback>.from(
                json["feedbacks"].map((x) => Feedback.fromJson(x))),
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "_id": datumId,
        "geometry": geometry.toJson(),
        "photo": photo,
        "is_deleted": isDeleted,
        "phone": List<dynamic>.from(phone.map((x) => x)),
        "times": List<dynamic>.from(
            times.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "name": name,
        "city": city,
        "address": address,
        "createAt": createAt,
        "__v": v,
        "checkUp": List<dynamic>.from(checkUp.map((x) => x.toJson())),
        "ID": id,
        "feedbacks": feedbacks == null
            ? []
            : List<dynamic>.from(feedbacks.map((x) => x.toJson())),
        "rating": rating,
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
  int rating;
  String labId;

  Feedback({
    this.comment,
    this.whoPosted,
    this.postedBy,
    this.photo,
    this.createAt,
    this.commentId,
    this.rating,
    this.labId,
  });

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
        comment: json["comment"],
        whoPosted: json["whoPosted"],
        postedBy: json["postedBy"],
        photo: json["photo"],
        createAt: json["createAt"],
        commentId: json["commentId"],
        rating: json["rating"],
        labId: json["labId"],
      );

  Map<String, dynamic> toJson() => {
        "comment": comment,
        "whoPosted": whoPosted,
        "postedBy": postedBy,
        "photo": photo,
        "createAt": createAt,
        "commentId": commentId,
        "rating": rating,
        "labId": labId,
      };
}

class Geometry {
  List<double> coordinates;
  String type;

  Geometry({
    this.coordinates,
    this.type,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates: json["coordinates"] == null
            ? null
            : List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": coordinates == null
            ? null
            : List<dynamic>.from(coordinates.map((x) => x)),
        "type": type,
      };
}
