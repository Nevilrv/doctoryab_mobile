// To parse this JSON data, do
//
//     final reports = reportsFromJson(jsonString);

import 'dart:convert';
import 'package:doctor_yab/app/data/models/doctors_model.dart';

Reports reportsFromJson(String str) => Reports.fromJson(json.decode(str));
String reportsToJson(Reports data) => json.encode(data.toJson());

class Reports {
  Reports({
    this.data,
  });

  List<Report> data;

  Reports copyWith({
    List<Report> data,
  }) =>
      Reports(
        data: data ?? this.data,
      );

  factory Reports.fromJson(Map<String, dynamic> json) => Reports(
        data: json["data"] == null
            ? null
            : List<Report>.from(json["data"].map((x) => Report.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Report {
  Report({
    this.id,
    this.documents,
    this.patientId,
    this.name,
    this.phone,
    this.title,
    this.description,
    this.doctor,
    this.createAt,
  });

  String id;
  List<String> documents;
  String patientId;
  String name;
  String phone;
  String title;
  String description;
  List<Doctor> doctor;
  DateTime createAt;

  Report copyWith({
    String id,
    List<String> documents,
    String patientId,
    String name,
    String phone,
    String title,
    String description,
    List<Doctor> doctor,
    DateTime createAt,
  }) =>
      Report(
        id: id ?? this.id,
        documents: documents ?? this.documents,
        patientId: patientId ?? this.patientId,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        title: title ?? this.title,
        description: description ?? this.description,
        doctor: doctor ?? this.doctor,
        createAt: createAt ?? this.createAt,
      );

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["_id"] == null ? null : json["_id"],
        documents: json["documents"] == null
            ? null
            : List<String>.from(json["documents"].map((x) => x)),
        patientId: json["patientId"] == null ? null : json["patientId"],
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"] == null ? null : json["phone"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        doctor: json["doctor"] == null
            ? null
            : List<Doctor>.from(json["doctor"].map((x) => Doctor.fromJson(x))),
        createAt:
            json["createAt"] == null ? null : DateTime.parse(json["createAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "documents": documents == null
            ? null
            : List<dynamic>.from(documents.map((x) => x)),
        "patientId": patientId == null ? null : patientId,
        "name": name == null ? null : name,
        "phone": phone == null ? null : phone,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "doctor": doctor == null
            ? null
            : List<dynamic>.from(doctor.map((x) => x.toJson())),
        "createAt": createAt == null ? null : createAt.toIso8601String(),
      };
}
