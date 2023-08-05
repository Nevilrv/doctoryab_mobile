// To parse this JSON data, do
//
//     final doctors = doctorsFromJson(jsonString);

import 'dart:convert';

import 'package:doctor_yab/app/data/models/categories_model.dart';
import 'package:doctor_yab/app/data/models/labs_model.dart';

Doctors doctorsFromJson(String str) => Doctors.fromJson(json.decode(str));

String doctorsToJson(Doctors data) => json.encode(data.toJson());

class Doctors {
  Doctors({
    this.success,
    this.data,
  });

  bool success;
  List<Doctor> data;

  Doctors copyWith({
    bool success,
    List<Doctor> data,
  }) =>
      Doctors(
        success: success ?? this.success,
        data: data ?? this.data,
      );

  factory Doctors.fromJson(Map<String, dynamic> json) => Doctors(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : List<Doctor>.from(json["data"].map((x) => Doctor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Doctor {
  Doctor({
    this.id,
    this.speciality,
    this.photo,
    this.stars,
    this.popularity,
    this.treatment,
    this.knowledge,
    this.cleaning,
    this.countOfPatient,
    this.isDeleted,
    this.totalStar,
    this.totalCleaning,
    this.totalTreatment,
    this.totalknowledge,
    this.confirmed,
    this.email,
    this.password,
    this.createAt,
    this.v,
    this.lname,
    this.name,
    this.phone,
    this.address,
    this.gender,
    this.detail,
    this.day,
    this.month,
    this.year,
    this.category,
    this.city,
    this.fullname,
    this.type,
    this.tags,
    this.coordinate,
    this.geometry,
    this.verfied,
  });

  bool verfied;
  String id;
  String speciality;
  String photo;
  double stars;
  int popularity;
  double treatment;
  double knowledge;
  double cleaning;
  int countOfPatient;
  bool isDeleted;
  num totalStar;
  num totalCleaning;
  num totalTreatment;
  num totalknowledge;
  bool confirmed;
  String email;
  String password;
  DateTime createAt;
  int v;
  String lname;
  String name;
  String phone;
  String address;
  int gender;
  String detail;
  int day;
  int month;
  int year;
  Category category;
  String city;
  String fullname;

  int type;
  List<String> tags;
  Coordinate coordinate;
  Geometry geometry;

  Doctor copyWith({
    String id,
    String speciality,
    String photo,
    double stars,
    int popularity,
    double treatment,
    double knowledge,
    double cleaning,
    int countOfPatient,
    bool isDeleted,
    num totalStar,
    num totalCleaning,
    num totalTreatment,
    num totalknowledge,
    bool confirmed,
    String email,
    String password,
    DateTime createAt,
    int v,
    String lname,
    String name,
    String phone,
    String address,
    int gender,
    String detail,
    int day,
    int month,
    int year,
    Category category,
    String city,
    String fullname,
    int type,
    List<String> tags,
    Coordinate coordinate,
    Geometry geometry,
    bool verfied,
  }) =>
      Doctor(
        id: id ?? this.id,
        speciality: speciality ?? this.speciality,
        photo: photo ?? this.photo,
        stars: stars ?? this.stars,
        popularity: popularity ?? this.popularity,
        treatment: treatment ?? this.treatment,
        knowledge: knowledge ?? this.knowledge,
        cleaning: cleaning ?? this.cleaning,
        countOfPatient: countOfPatient ?? this.countOfPatient,
        isDeleted: isDeleted ?? this.isDeleted,
        totalStar: totalStar ?? this.totalStar,
        totalCleaning: totalCleaning ?? this.totalCleaning,
        totalTreatment: totalTreatment ?? this.totalTreatment,
        totalknowledge: totalknowledge ?? this.totalknowledge,
        confirmed: confirmed ?? this.confirmed,
        email: email ?? this.email,
        password: password ?? this.password,
        createAt: createAt ?? this.createAt,
        v: v ?? this.v,
        lname: lname ?? this.lname,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        gender: gender ?? this.gender,
        detail: detail ?? this.detail,
        day: day ?? this.day,
        month: month ?? this.month,
        year: year ?? this.year,
        category: category ?? this.category,
        city: city ?? this.city,
        fullname: fullname ?? this.fullname,
        type: type ?? this.type,
        tags: tags ?? this.tags,
        coordinate: coordinate ?? this.coordinate,
        geometry: geometry ?? this.geometry,
        verfied: verfied ?? this.verfied,
      );

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json["_id"] == null ? null : json["_id"],
        speciality: json["speciality"] == null ? null : json["speciality"],
        photo: json["photo"] == null ? null : json["photo"],
        stars: json["stars"] == null ? null : json["stars"].toDouble(),
        popularity: json["popularity"] == null ? null : json["popularity"],
        treatment:
            json["treatment"] == null ? null : json["treatment"].toDouble(),
        knowledge:
            json["knowledge"] == null ? null : json["knowledge"].toDouble(),
        cleaning: json["cleaning"] == null ? null : json["cleaning"].toDouble(),
        countOfPatient:
            json["countOfPatient"] == null ? null : json["countOfPatient"],
        isDeleted: json["is_deleted"] == null ? null : json["is_deleted"],
        totalStar: json["totalStar"] == null ? null : json["totalStar"],
        totalCleaning:
            json["totalCleaning"] == null ? null : json["totalCleaning"],
        totalTreatment:
            json["totalTreatment"] == null ? null : json["totalTreatment"],
        totalknowledge:
            json["totalknowledge"] == null ? null : json["totalknowledge"],
        confirmed: json["confirmed"] == null ? null : json["confirmed"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        createAt:
            json["createAt"] == null ? null : DateTime.parse(json["createAt"]),
        v: json["__v"] == null ? null : json["__v"],
        lname: json["lname"] == null ? null : json["lname"],
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"] == null ? null : json["phone"],
        address: json["address"] == null ? null : json["address"],
        gender: json["gender"] == null ? null : json["gender"],
        detail: json["detail"] == null ? null : json["detail"],
        day: json["day"] == null ? null : json["day"],
        month: json["month"] == null ? null : json["month"],
        year: json["year"] == null ? null : json["year"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        city: json["city"] == null ? null : json["city"],
        fullname: json["fullname"] == null ? null : json["fullname"],
        type: json["type"] == null ? null : json["type"],
        tags: json["tags"] == null
            ? null
            : List<String>.from(json["tags"].map((x) => x)),
        coordinate: json["coordinate"] == null
            ? null
            : Coordinate.fromJson(json["coordinate"]),
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
        verfied: json["Verification"] == null ? null : json["Verification"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "speciality": speciality == null ? null : speciality,
        "photo": photo == null ? null : photo,
        "stars": stars == null ? null : stars,
        "popularity": popularity == null ? null : popularity,
        "treatment": treatment == null ? null : treatment,
        "knowledge": knowledge == null ? null : knowledge,
        "cleaning": cleaning == null ? null : cleaning,
        "countOfPatient": countOfPatient == null ? null : countOfPatient,
        "is_deleted": isDeleted == null ? null : isDeleted,
        "totalStar": totalStar == null ? null : totalStar,
        "totalCleaning": totalCleaning == null ? null : totalCleaning,
        "totalTreatment": totalTreatment == null ? null : totalTreatment,
        "totalknowledge": totalknowledge == null ? null : totalknowledge,
        "confirmed": confirmed == null ? null : confirmed,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "createAt": createAt == null ? null : createAt.toIso8601String(),
        "__v": v == null ? null : v,
        "lname": lname == null ? null : lname,
        "name": name == null ? null : name,
        "phone": phone == null ? null : phone,
        "address": address == null ? null : address,
        "gender": gender == null ? null : gender,
        "detail": detail == null ? null : detail,
        "day": day == null ? null : day,
        "month": month == null ? null : month,
        "year": year == null ? null : year,
        "category": category == null ? null : category.toJson(),
        "city": city == null ? null : city,
        "fullname": fullname == null ? null : fullname,
        "type": type == null ? null : type,
        "tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x)),
        "coordinate": coordinate == null ? null : coordinate.toJson(),
        "geometry": geometry == null ? null : geometry.toJson(),
        "Verification": verfied == null ? null : verfied,
      };
}

class Coordinate {
  Coordinate({
    this.lat,
    this.lng,
  });

  double lat;
  double lng;

  Coordinate copyWith({
    double lat,
    double lng,
  }) =>
      Coordinate(
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
      );

  factory Coordinate.fromJson(Map<String, dynamic> json) => Coordinate(
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lng: json["lng"] == null ? null : json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
      };
}
