// To parse this JSON data, do
//
//     final appointmentHistoryResModel = appointmentHistoryResModelFromJson(jsonString);

import 'dart:convert';

AppointmentHistoryResModel appointmentHistoryResModelFromJson(String str) =>
    AppointmentHistoryResModel.fromJson(json.decode(str));

String appointmentHistoryResModelToJson(AppointmentHistoryResModel data) =>
    json.encode(data.toJson());

class AppointmentHistoryResModel {
  List<AppointmentHistory> data;
  int count;

  AppointmentHistoryResModel({
    this.data,
    this.count,
  });

  factory AppointmentHistoryResModel.fromJson(Map<String, dynamic> json) =>
      AppointmentHistoryResModel(
        data: List<AppointmentHistory>.from(
            json["data"].map((x) => AppointmentHistory.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count,
      };
}

class AppointmentHistory {
  bool bookingNotified;
  bool visited;
  String id;
  PackageId packageId;
  PatientId patientId;
  String visitDate;
  Id labId;
  Id hospitalId;
  String cityId;
  String createAt;
  int v;

  AppointmentHistory({
    this.bookingNotified,
    this.visited,
    this.id,
    this.packageId,
    this.patientId,
    this.visitDate,
    this.labId,
    this.hospitalId,
    this.cityId,
    this.createAt,
    this.v,
  });

  factory AppointmentHistory.fromJson(Map<String, dynamic> json) =>
      AppointmentHistory(
        bookingNotified: json["bookingNotified"],
        visited: json["visited"],
        id: json["_id"],
        packageId: json["packageId"] == null
            ? null
            : PackageId.fromJson(json["packageId"]),
        patientId: PatientId.fromJson(json["patientId"]),
        visitDate: json["visit_date"] ?? false,
        labId: Id.fromJson(json["labId"]),
        hospitalId:
            json["hospitalId"] == null ? null : Id.fromJson(json["hospitalId"]),
        cityId: json["cityId"],
        createAt: json["createAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "bookingNotified": bookingNotified,
        "visited": visited,
        "_id": id,
        "packageId": packageId?.toJson(),
        "patientId": patientId.toJson(),
        "visit_date": visitDate,
        "labId": labId.toJson(),
        "hospitalId": hospitalId?.toJson(),
        "cityId": cityId,
        "createAt": createAt,
        "__v": v,
      };
}

class Id {
  String id;
  String name;

  Id({
    this.id,
    this.name,
  });

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

class PackageId {
  List<HospitalLocation> hospitalLocation;
  List<LabLocation> labLocation;
  String id;
  String title;

  PackageId({
    this.hospitalLocation,
    this.labLocation,
    this.id,
    this.title,
  });

  factory PackageId.fromJson(Map<String, dynamic> json) => PackageId(
        hospitalLocation: List<HospitalLocation>.from(
            json["hospitalLocation"].map((x) => HospitalLocation.fromJson(x))),
        labLocation: List<LabLocation>.from(
            json["labLocation"].map((x) => LabLocation.fromJson(x))),
        id: json["_id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "hospitalLocation":
            List<dynamic>.from(hospitalLocation.map((x) => x.toJson())),
        "labLocation": List<dynamic>.from(labLocation.map((x) => x.toJson())),
        "_id": id,
        "title": title,
      };
}

class HospitalLocation {
  String id;
  String address;
  String name;
  String phone;

  HospitalLocation({
    this.id,
    this.address,
    this.name,
    this.phone,
  });

  factory HospitalLocation.fromJson(Map<String, dynamic> json) =>
      HospitalLocation(
        id: json["_id"],
        address: json["address"],
        name: json["name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "address": address,
        "name": name,
        "phone": phone,
      };
}

class LabLocation {
  List<String> phone;
  String id;
  String name;

  LabLocation({
    this.phone,
    this.id,
    this.name,
  });

  factory LabLocation.fromJson(Map<String, dynamic> json) => LabLocation(
        phone: List<String>.from(json["phone"].map((x) => x)),
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "phone": List<dynamic>.from(phone.map((x) => x)),
        "_id": id,
        "name": name,
      };
}

class PatientId {
  String id;
  String phone;
  String patientId;
  String name;

  PatientId({
    this.id,
    this.phone,
    this.patientId,
    this.name,
  });

  factory PatientId.fromJson(Map<String, dynamic> json) => PatientId(
        id: json["_id"],
        phone: json["phone"],
        patientId: json["patientID"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "phone": phone,
        "patientID": patientId,
        "name": name,
      };
}
