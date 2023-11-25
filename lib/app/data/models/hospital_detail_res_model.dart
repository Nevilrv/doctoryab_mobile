// To parse this JSON data, do
//
//     final hospitalDetailsResModel = hospitalDetailsResModelFromJson(jsonString);

import 'dart:convert';

import 'package:doctor_yab/app/data/models/labs_model.dart';

// To parse this JSON data, do
//
//     final hospitalDetailsResModel = hospitalDetailsResModelFromJson(jsonString);

import 'dart:convert';

HospitalDetailsResModel hospitalDetailsResModelFromJson(String str) =>
    HospitalDetailsResModel.fromJson(json.decode(str));

String hospitalDetailsResModelToJson(HospitalDetailsResModel data) =>
    json.encode(data.toJson());

class HospitalDetailsResModel {
  Data data;
  List<Cat> cats;
  List<Doct> docts;

  HospitalDetailsResModel({
    this.data,
    this.cats,
    this.docts,
  });

  factory HospitalDetailsResModel.fromJson(Map<String, dynamic> json) =>
      HospitalDetailsResModel(
        data: Data.fromJson(json["data"]),
        cats: List<Cat>.from(json["cats"].map((x) => Cat.fromJson(x))),
        docts: List<Doct>.from(json["docts"].map((x) => Doct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "cats": List<dynamic>.from(cats.map((x) => x.toJson())),
        "docts": List<dynamic>.from(docts.map((x) => x.toJson())),
      };
}

class Cat {
  String id;
  String eTitle;

  Cat({
    this.id,
    this.eTitle,
  });

  factory Cat.fromJson(Map<String, dynamic> json) => Cat(
        id: json["id"],
        eTitle: json["e_title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "e_title": eTitle,
      };
}

class Data {
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
  int usersStaredCount;
  String dataId;
  String address;
  String name;
  String city;
  String phone;
  String createAt;
  List<CheckUp> checkUp;
  int v;
  int id;

  Data({
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
    this.usersStaredCount,
    this.dataId,
    this.address,
    this.name,
    this.city,
    this.phone,
    this.createAt,
    this.checkUp,
    this.v,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        usersStaredCount: json["users_stared_count"],
        dataId: json["_id"],
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
        "users_stared_count": usersStaredCount,
        "_id": dataId,
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

class Doct {
  String id;
  String fullname;
  String photo;
  List<Edu> edu;
  List<Exp> exp;
  double stars;
  String speciality;

  Doct({
    this.id,
    this.fullname,
    this.photo,
    this.edu,
    this.exp,
    this.stars,
    this.speciality,
  });

  factory Doct.fromJson(Map<String, dynamic> json) => Doct(
        id: json["_id"],
        fullname: json["fullname"],
        photo: json["photo"],
        edu: List<Edu>.from(json["Edu"].map((x) => Edu.fromJson(x))),
        exp: List<Exp>.from(json["Exp"].map((x) => Exp.fromJson(x))),
        stars: json["stars"]?.toDouble(),
        speciality: json["speciality"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullname": fullname,
        "photo": photo,
        "Edu": List<dynamic>.from(edu.map((x) => x.toJson())),
        "Exp": List<dynamic>.from(exp.map((x) => x.toJson())),
        "stars": stars,
        "speciality": speciality,
      };
}

class Edu {
  String id;
  String name;
  String start;
  String end;
  String user;
  int v;

  Edu({
    this.id,
    this.name,
    this.start,
    this.end,
    this.user,
    this.v,
  });

  factory Edu.fromJson(Map<String, dynamic> json) => Edu(
        id: json["_id"],
        name: json["name"],
        start: json["start"],
        end: json["end"],
        user: json["user"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "start": start,
        "end": end,
        "user": user,
        "__v": v,
      };
}

class Exp {
  String id;
  String name;
  double year;
  String user;
  int v;

  Exp({
    this.id,
    this.name,
    this.year,
    this.user,
    this.v,
  });

  factory Exp.fromJson(Map<String, dynamic> json) => Exp(
        id: json["_id"],
        name: json["name"],
        year: json["year"]?.toDouble(),
        user: json["user"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "year": year,
        "user": user,
        "__v": v,
      };
}
