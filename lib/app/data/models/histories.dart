// To parse this JSON data, do
//
//     final histories = historiesFromJson(jsonString);

import 'dart:convert';

import 'package:doctor_yab/app/data/models/doctors_model.dart';

Histories historiesFromJson(String str) => Histories.fromJson(json.decode(str));

String historiesToJson(Histories data) => json.encode(data.toJson());

class Histories {
  Histories({
    this.success,
    this.data,
  });

  bool success;
  List<History> data;

  Histories copyWith({
    bool success,
    List<History> data,
  }) =>
      Histories(
        success: success ?? this.success,
        data: data ?? this.data,
      );

  factory Histories.fromJson(Map<String, dynamic> json) => Histories(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : List<History>.from(json["data"].map((x) => History.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class History {
  History({
    this.id,
    this.visited,
    this.treatmentForDoc,
    this.knowledgeForDoc,
    this.cleaningForDoc,
    this.starsForDoc,
    this.visitDate,
    this.name,
    this.age,
    this.phone,
    this.patientId,
    this.doctor,
    this.createAt,
    this.v,
  });

  String id;
  bool visited;
  num treatmentForDoc;
  num knowledgeForDoc;
  num cleaningForDoc;
  num starsForDoc;
  DateTime visitDate;
  String name;
  int age;
  String phone;
  String patientId;
  List<Doctor> doctor;
  String createAt;
  int v;

  History copyWith({
    String id,
    bool visited,
    num treatmentForDoc,
    num knowledgeForDoc,
    num cleaningForDoc,
    num starsForDoc,
    DateTime visitDate,
    String name,
    int age,
    String phone,
    String patientId,
    List<Doctor> doctor,
    String createAt,
    int v,
  }) =>
      History(
        id: id ?? this.id,
        visited: visited ?? this.visited,
        treatmentForDoc: treatmentForDoc ?? this.treatmentForDoc,
        knowledgeForDoc: knowledgeForDoc ?? this.knowledgeForDoc,
        cleaningForDoc: cleaningForDoc ?? this.cleaningForDoc,
        starsForDoc: starsForDoc ?? this.starsForDoc,
        visitDate: visitDate ?? this.visitDate,
        name: name ?? this.name,
        age: age ?? this.age,
        phone: phone ?? this.phone,
        patientId: patientId ?? this.patientId,
        doctor: doctor ?? this.doctor,
        createAt: createAt ?? this.createAt,
        v: v ?? this.v,
      );

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["_id"] == null ? null : json["_id"],
        visited: json["visited"] == null ? null : json["visited"],
        treatmentForDoc:
            json["treatmentForDoc"] == null ? null : json["treatmentForDoc"],
        knowledgeForDoc:
            json["knowledgeForDoc"] == null ? null : json["knowledgeForDoc"],
        cleaningForDoc:
            json["cleaningForDoc"] == null ? null : json["cleaningForDoc"],
        starsForDoc: json["starsForDoc"] == null ? null : json["starsForDoc"],
        visitDate: json["visit_date"] == null
            ? null
            : DateTime.parse(json["visit_date"]),
        name: json["name"] == null ? null : json["name"],
        age: json["age"] == null ? null : json["age"],
        phone: json["phone"] == null ? null : json["phone"],
        patientId: json["patientId"] == null ? null : json["patientId"],
        doctor: json["doctor"] == null
            ? null
            : List<Doctor>.from(json["doctor"].map((x) => Doctor.fromJson(x))),
        createAt: json["createAt"] == null ? null : json["createAt"],
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "visited": visited == null ? null : visited,
        "treatmentForDoc": treatmentForDoc == null ? null : treatmentForDoc,
        "knowledgeForDoc": knowledgeForDoc == null ? null : knowledgeForDoc,
        "cleaningForDoc": cleaningForDoc == null ? null : cleaningForDoc,
        "starsForDoc": starsForDoc == null ? null : starsForDoc,
        "visit_date": visitDate == null ? null : visitDate.toIso8601String(),
        "name": name == null ? null : name,
        "age": age == null ? null : age,
        "phone": phone == null ? null : phone,
        "patientId": patientId == null ? null : patientId,
        "doctor": doctor == null
            ? null
            : List<dynamic>.from(doctor.map((x) => x.toJson())),
        "createAt": createAt == null ? null : createAt,
        "__v": v == null ? null : v,
      };
}
