// To parse this JSON data, do
//
//     final reports = reportsFromJson(jsonString);

import 'dart:convert';

import 'package:doctor_yab/app/data/models/doctors_model.dart';

Reports reportsFromJson(String str) => Reports.fromJson(json.decode(str));

String reportsToJson(Reports data) => json.encode(data.toJson());

class Reports {
  List<Report>? data;

  Reports({
    this.data,
  });

  factory Reports.fromJson(Map<String, dynamic> json) => Reports(
        data: List<Report>.from(json["data"].map((x) => Report.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Report {
  String? id;
  List<String>? documents;
  String? patientId;
  String? name;
  String? phone;
  String? title;
  String? description;
  List<Doctor>? doctor;
  List<Medicine>? medicines;
  int? age;
  String? appointmentDocId;
  String? advice;
  String? bp;
  String? doctorSignature;
  String? followUp;
  String? gender;
  String? height;
  String? prescriptionCreateAt;
  String? temp;
  String? weight;

  Report({
    this.id,
    this.documents,
    this.patientId,
    this.name,
    this.phone,
    this.title,
    this.description,
    this.doctor,
    this.medicines,
    this.age,
    this.appointmentDocId,
    this.advice,
    this.bp,
    this.doctorSignature,
    this.followUp,
    this.gender,
    this.height,
    this.prescriptionCreateAt,
    this.temp,
    this.weight,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["_id"],
        documents: List<String>.from(json["documents"].map((x) => x)),
        patientId: json["patientId"],
        name: json["name"],
        phone: json["phone"],
        title: json["title"],
        description: json["description"],
        doctor:
            List<Doctor>.from(json["doctor"].map((x) => Doctor.fromJson(x))),
        medicines: json["medicines"] == null
            ? []
            : List<Medicine>.from(
                json["medicines"].map((x) => Medicine.fromJson(x))),
        age: json["age"],
        appointmentDocId: json["appointmentDocId"],
        advice: json["advice"],
        bp: json["bp"],
        doctorSignature: json["doctorSignature"],
        followUp: json["followUp"],
        gender: json["gender"],
        height: json["height"],
        prescriptionCreateAt: json["prescriptionCreateAt"],
        temp: json["temp"],
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "documents": List<dynamic>.from(documents!.map((x) => x)),
        "patientId": patientId,
        "name": name,
        "phone": phone,
        "title": title,
        "description": description,
        "doctor": List<dynamic>.from(doctor!.map((x) => x.toJson())),
        "medicines": medicines == null
            ? []
            : List<dynamic>.from(medicines!.map((x) => x.toJson())),
        "age": age,
        "appointmentDocId": appointmentDocId,
        "advice": advice,
        "bp": bp,
        "doctorSignature": doctorSignature,
        "followUp": followUp,
        "gender": gender,
        "height": height,
        "prescriptionCreateAt": prescriptionCreateAt,
        "temp": temp,
        "weight": weight,
      };
}

class Category {
  String? id;
  bool? isDeleted;
  String? fTitle;
  String? eTitle;
  String? pTitle;
  String? background;
  int? v;
  String? photo;
  String? createdAt;
  String? updatedAt;
  int? order;

  Category({
    this.id,
    this.isDeleted,
    this.fTitle,
    this.eTitle,
    this.pTitle,
    this.background,
    this.v,
    this.photo,
    this.createdAt,
    this.updatedAt,
    this.order,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        isDeleted: json["is_deleted"],
        fTitle: json["f_title"],
        eTitle: json["e_title"],
        pTitle: json["p_title"],
        background: json["background"],
        v: json["__v"],
        photo: json["photo"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        order: json["order"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "is_deleted": isDeleted,
        "f_title": fTitle,
        "e_title": eTitle,
        "p_title": pTitle,
        "background": background,
        "__v": v,
        "photo": photo,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "order": order,
      };
}

class Coordinate {
  double? lat;
  double? lng;

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

class Geometry {
  List<double>? coordinates;
  String? type;

  Geometry({
    this.coordinates,
    this.type,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(coordinates!.map((x) => x)),
        "type": type,
      };
}

class Medicine {
  String? drug;
  String? dosage;
  String? duration;

  Medicine({
    this.drug,
    this.dosage,
    this.duration,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
        drug: json["drug"],
        dosage: json["dosage"],
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "drug": drug,
        "dosage": dosage,
        "duration": duration,
      };
}
