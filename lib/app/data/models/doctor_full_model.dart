// To parse this JSON data, do
//
//     final doctorFullModel = doctorFullModelFromJson(jsonString);

import 'dart:convert';

DoctorFullModel doctorFullModelFromJson(String str) =>
    DoctorFullModel.fromJson(json.decode(str));

String doctorFullModelToJson(DoctorFullModel data) =>
    json.encode(data.toJson());

class DoctorFullModel {
  DoctorFullModel({
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
    this.confirmed,
    this.comments,
    this.doctor,
    this.tags,
    this.type,
    this.isActive,
    this.fee,
    this.id,
    this.email,
    this.fullname,
    this.createAt,
    this.v,
    this.address,
    this.category,
    this.city,
    this.day,
    this.gender,
    this.lname,
    this.month,
    this.name,
    this.phone,
    this.speciality,
    this.year,
    this.detail,
  });

  final Geometry geometry;
  final List<Award> exp;
  final List<Edu> edu;
  final List<Award> lang;
  final List<Award> awards;
  final String photo;
  final num stars;
  final num popularity;
  final num treatment;
  final num knowledge;
  final num cleaning;
  final num countOfPatient;
  final bool isDeleted;
  final num totalStar;
  final bool confirmed;
  final List<dynamic> comments;
  final num doctor;
  final List<String> tags;
  final num type;
  final bool isActive;
  final String fee;
  final String id;
  final String email;
  final String fullname;
  final DateTime createAt;
  final num v;
  final String address;
  final String category;
  final String city;
  final num day;
  final num gender;
  final String lname;
  final num month;
  final String name;
  final String phone;
  final String speciality;
  final num year;
  final String detail;

  DoctorFullModel copyWith({
    Geometry geometry,
    List<Award> exp,
    List<Edu> edu,
    List<Award> lang,
    List<Award> awards,
    String photo,
    num stars,
    num popularity,
    num treatment,
    num knowledge,
    num cleaning,
    num countOfPatient,
    bool isDeleted,
    num totalStar,
    bool confirmed,
    List<dynamic> comments,
    num doctor,
    List<String> tags,
    num type,
    bool isActive,
    String fee,
    String id,
    String email,
    String fullname,
    DateTime createAt,
    num v,
    String address,
    String category,
    String city,
    num day,
    num gender,
    String lname,
    num month,
    String name,
    String phone,
    String speciality,
    num year,
    String detail,
  }) =>
      DoctorFullModel(
        geometry: geometry ?? this.geometry,
        exp: exp ?? this.exp,
        edu: edu ?? this.edu,
        lang: lang ?? this.lang,
        awards: awards ?? this.awards,
        photo: photo ?? this.photo,
        stars: stars ?? this.stars,
        popularity: popularity ?? this.popularity,
        treatment: treatment ?? this.treatment,
        knowledge: knowledge ?? this.knowledge,
        cleaning: cleaning ?? this.cleaning,
        countOfPatient: countOfPatient ?? this.countOfPatient,
        isDeleted: isDeleted ?? this.isDeleted,
        totalStar: totalStar ?? this.totalStar,
        confirmed: confirmed ?? this.confirmed,
        comments: comments ?? this.comments,
        doctor: doctor ?? this.doctor,
        tags: tags ?? this.tags,
        type: type ?? this.type,
        isActive: isActive ?? this.isActive,
        fee: fee ?? this.fee,
        id: id ?? this.id,
        email: email ?? this.email,
        fullname: fullname ?? this.fullname,
        createAt: createAt ?? this.createAt,
        v: v ?? this.v,
        address: address ?? this.address,
        category: category ?? this.category,
        city: city ?? this.city,
        day: day ?? this.day,
        gender: gender ?? this.gender,
        lname: lname ?? this.lname,
        month: month ?? this.month,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        speciality: speciality ?? this.speciality,
        year: year ?? this.year,
        detail: detail ?? this.detail,
      );

  factory DoctorFullModel.fromJson(Map<String, dynamic> json) =>
      DoctorFullModel(
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
        exp: json["Exp"] == null
            ? null
            : List<Award>.from(json["Exp"].map((x) => Award.fromJson(x))),
        edu: json["Edu"] == null
            ? null
            : List<Edu>.from(json["Edu"].map((x) => Edu.fromJson(x))),
        lang: json["Lang"] == null
            ? null
            : List<Award>.from(json["Lang"].map((x) => Award.fromJson(x))),
        awards: json["Awards"] == null
            ? null
            : List<Award>.from(json["Awards"].map((x) => Award.fromJson(x))),
        photo: json["photo"] == null ? null : json["photo"],
        stars: json["stars"] == null ? null : json["stars"],
        popularity: json["popularity"] == null ? null : json["popularity"],
        treatment: json["treatment"] == null ? null : json["treatment"],
        knowledge: json["knowledge"] == null ? null : json["knowledge"],
        cleaning: json["cleaning"] == null ? null : json["cleaning"],
        countOfPatient:
            json["countOfPatient"] == null ? null : json["countOfPatient"],
        isDeleted: json["is_deleted"] == null ? null : json["is_deleted"],
        totalStar: json["totalStar"] == null ? null : json["totalStar"],
        confirmed: json["confirmed"] == null ? null : json["confirmed"],
        comments: json["comments"] == null
            ? null
            : List<dynamic>.from(json["comments"].map((x) => x)),
        doctor: json["doctor"] == null ? null : json["doctor"],
        tags: json["tags"] == null
            ? null
            : List<String>.from(json["tags"].map((x) => x)),
        type: json["type"] == null ? null : json["type"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        fee: json["fee"] == null ? null : json["fee"],
        id: json["_id"] == null ? null : json["_id"],
        email: json["email"] == null ? null : json["email"],
        fullname: json["fullname"] == null ? null : json["fullname"],
        createAt:
            json["createAt"] == null ? null : DateTime.parse(json["createAt"]),
        v: json["__v"] == null ? null : json["__v"],
        address: json["address"] == null ? null : json["address"],
        category: json["category"] == null ? null : json["category"],
        city: json["city"] == null ? null : json["city"],
        day: json["day"] == null ? null : json["day"],
        gender: json["gender"] == null ? null : json["gender"],
        lname: json["lname"] == null ? null : json["lname"],
        month: json["month"] == null ? null : json["month"],
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"] == null ? null : json["phone"],
        speciality: json["speciality"] == null ? null : json["speciality"],
        year: json["year"] == null ? null : json["year"],
        detail: json["detail"] == null ? null : json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "geometry": geometry == null ? null : geometry.toJson(),
        "Exp":
            exp == null ? null : List<dynamic>.from(exp.map((x) => x.toJson())),
        "Edu":
            edu == null ? null : List<dynamic>.from(edu.map((x) => x.toJson())),
        "Lang": lang == null
            ? null
            : List<dynamic>.from(lang.map((x) => x.toJson())),
        "Awards": awards == null
            ? null
            : List<dynamic>.from(awards.map((x) => x.toJson())),
        "photo": photo == null ? null : photo,
        "stars": stars == null ? null : stars,
        "popularity": popularity == null ? null : popularity,
        "treatment": treatment == null ? null : treatment,
        "knowledge": knowledge == null ? null : knowledge,
        "cleaning": cleaning == null ? null : cleaning,
        "countOfPatient": countOfPatient == null ? null : countOfPatient,
        "is_deleted": isDeleted == null ? null : isDeleted,
        "totalStar": totalStar == null ? null : totalStar,
        "confirmed": confirmed == null ? null : confirmed,
        "comments": comments == null
            ? null
            : List<dynamic>.from(comments.map((x) => x)),
        "doctor": doctor == null ? null : doctor,
        "tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x)),
        "type": type == null ? null : type,
        "is_active": isActive == null ? null : isActive,
        "fee": fee == null ? null : fee,
        "_id": id == null ? null : id,
        "email": email == null ? null : email,
        "fullname": fullname == null ? null : fullname,
        "createAt": createAt == null ? null : createAt.toIso8601String(),
        "__v": v == null ? null : v,
        "address": address == null ? null : address,
        "category": category == null ? null : category,
        "city": city == null ? null : city,
        "day": day == null ? null : day,
        "gender": gender == null ? null : gender,
        "lname": lname == null ? null : lname,
        "month": month == null ? null : month,
        "name": name == null ? null : name,
        "phone": phone == null ? null : phone,
        "speciality": speciality == null ? null : speciality,
        "year": year == null ? null : year,
        "detail": detail == null ? null : detail,
      };
}

class Award {
  Award({
    this.id,
    this.name,
    this.year,
    this.user,
    this.v,
    this.level,
  });

  final String id;
  final String name;
  final num year;
  final String user;
  final num v;
  final num level;

  Award copyWith({
    String id,
    String name,
    num year,
    String user,
    num v,
    num level,
  }) =>
      Award(
        id: id ?? this.id,
        name: name ?? this.name,
        year: year ?? this.year,
        user: user ?? this.user,
        v: v ?? this.v,
        level: level ?? this.level,
      );

  factory Award.fromJson(Map<String, dynamic> json) => Award(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        year: json["year"] == null ? null : json["year"],
        user: json["user"] == null ? null : json["user"],
        v: json["__v"] == null ? null : json["__v"],
        level: json["level"] == null ? null : json["level"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "year": year == null ? null : year,
        "user": user == null ? null : user,
        "__v": v == null ? null : v,
        "level": level == null ? null : level,
      };
}

class Edu {
  Edu({
    this.id,
    this.name,
    this.start,
    this.end,
    this.user,
    this.v,
  });

  final String id;
  final String name;
  final String start;
  final String end;
  final String user;
  final num v;

  Edu copyWith({
    String id,
    String name,
    String start,
    String end,
    String user,
    num v,
  }) =>
      Edu(
        id: id ?? this.id,
        name: name ?? this.name,
        start: start ?? this.start,
        end: end ?? this.end,
        user: user ?? this.user,
        v: v ?? this.v,
      );

  factory Edu.fromJson(Map<String, dynamic> json) => Edu(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        start: json["start"] == null ? null : json["start"],
        end: json["end"] == null ? null : json["end"],
        user: json["user"] == null ? null : json["user"],
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "start": start == null ? null : start,
        "end": end == null ? null : end,
        "user": user == null ? null : user,
        "__v": v == null ? null : v,
      };
}

class Geometry {
  Geometry({
    this.type,
    this.coordinates,
  });

  final String type;
  final List<double> coordinates;

  Geometry copyWith({
    String type,
    List<double> coordinates,
  }) =>
      Geometry(
        type: type ?? this.type,
        coordinates: coordinates ?? this.coordinates,
      );

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"] == null ? null : json["type"],
        coordinates: json["coordinates"] == null
            ? null
            : List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "coordinates": coordinates == null
            ? null
            : List<dynamic>.from(coordinates.map((x) => x)),
      };
}
