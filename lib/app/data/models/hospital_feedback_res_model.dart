// To parse this JSON data, do
//
//     final hospitalFeedBackResModel = hospitalFeedBackResModelFromJson(jsonString);

import 'dart:convert';

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
  HospitalId hospitalId;
  String id;
  int v;
  double averageRating;

  HospitalFeedback({
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
    this.hospitalId,
    this.id,
    this.v,
    this.averageRating,
  });

  factory HospitalFeedback.fromJson(Map<String, dynamic> json) =>
      HospitalFeedback(
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
        hospitalId: HospitalId.fromJson(json["hospitalId"]),
        id: json["ID"],
        v: json["__v"],
        averageRating: json["averageRating"]?.toDouble(),
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
        "hospitalId": hospitalId.toJson(),
        "ID": id,
        "__v": v,
        "averageRating": averageRating,
      };
}

class HospitalId {
  Geometry geometry;
  String photo;
  List<String> tags;
  List<String> categories;
  List<String> doctors;
  int type;
  List<List<String>> times;
  String description;
  String email;
  String totalFeedbacks;
  String averageRating;
  int stars;
  bool isEmergency;
  bool active;
  int usersStaredCount;
  String hospitalIdId;
  String address;
  String name;
  String city;
  String phone;
  String createAt;
  List<CheckUp> checkUp;
  int v;
  int id;

  HospitalId({
    this.geometry,
    this.photo,
    this.tags,
    this.categories,
    this.doctors,
    this.type,
    this.times,
    this.description,
    this.email,
    this.totalFeedbacks,
    this.averageRating,
    this.stars,
    this.isEmergency,
    this.active,
    this.usersStaredCount,
    this.hospitalIdId,
    this.address,
    this.name,
    this.city,
    this.phone,
    this.createAt,
    this.checkUp,
    this.v,
    this.id,
  });

  factory HospitalId.fromJson(Map<String, dynamic> json) => HospitalId(
        geometry: Geometry.fromJson(json["geometry"]),
        photo: json["photo"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        categories: List<String>.from(json["categories"].map((x) => x)),
        doctors: List<String>.from(json["doctors"].map((x) => x)),
        type: json["type"],
        times: List<List<String>>.from(
            json["times"].map((x) => List<String>.from(x.map((x) => x)))),
        description: json["description"],
        email: json["email"],
        totalFeedbacks: json["totalFeedbacks"],
        averageRating: json["averageRating"],
        stars: json["stars"],
        isEmergency: json["is_emergency"],
        active: json["active"],
        usersStaredCount: json["users_stared_count"],
        hospitalIdId: json["_id"],
        address: json["address"],
        name: json["name"],
        city: json["city"],
        phone: json["phone"],
        createAt: json["createAt"],
        checkUp:
            List<CheckUp>.from(json["checkUp"].map((x) => CheckUp.fromJson(x))),
        v: json["__v"],
        id: json["ID"],
      );

  Map<String, dynamic> toJson() => {
        "geometry": geometry.toJson(),
        "photo": photo,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "doctors": List<dynamic>.from(doctors.map((x) => x)),
        "type": type,
        "times": List<dynamic>.from(
            times.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "description": description,
        "email": email,
        "totalFeedbacks": totalFeedbacks,
        "averageRating": averageRating,
        "stars": stars,
        "is_emergency": isEmergency,
        "active": active,
        "users_stared_count": usersStaredCount,
        "_id": hospitalIdId,
        "address": address,
        "name": name,
        "city": city,
        "phone": phone,
        "createAt": createAt,
        "checkUp": List<dynamic>.from(checkUp.map((x) => x.toJson())),
        "__v": v,
        "ID": id,
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
