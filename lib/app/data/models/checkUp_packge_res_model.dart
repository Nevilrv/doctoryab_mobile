// To parse this JSON data, do
//
//     final checkUpPackageResModel = checkUpPackageResModelFromJson(jsonString);

import 'dart:convert';

CheckUpPackageResModel checkUpPackageResModelFromJson(String str) =>
    CheckUpPackageResModel.fromJson(json.decode(str));

String checkUpPackageResModelToJson(CheckUpPackageResModel data) =>
    json.encode(data.toJson());

class CheckUpPackageResModel {
  List<PackageHistory> data;
  int count;

  CheckUpPackageResModel({
    this.data,
    this.count,
  });

  factory CheckUpPackageResModel.fromJson(Map<String, dynamic> json) =>
      CheckUpPackageResModel(
        data: List<PackageHistory>.from(
            json["data"].map((x) => PackageHistory.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count,
      };
}

class PackageHistory {
  bool bookingNotified;
  bool visited;
  String id;
  PatientId patientId;
  PackageId packageId;
  HospitalId hospitalId;
  String visitDate;
  String createAt;
  int v;

  PackageHistory({
    this.bookingNotified,
    this.visited,
    this.id,
    this.patientId,
    this.packageId,
    this.hospitalId,
    this.visitDate,
    this.createAt,
    this.v,
  });

  factory PackageHistory.fromJson(Map<String, dynamic> json) => PackageHistory(
        bookingNotified: json["bookingNotified"],
        visited: json["visited"],
        id: json["_id"],
        patientId: PatientId.fromJson(json["patientId"]),
        packageId: PackageId.fromJson(json["packageId"]),
        hospitalId: HospitalId.fromJson(json["hospitalId"]),
        visitDate: json["visit_date"],
        createAt: json["createAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "bookingNotified": bookingNotified,
        "visited": visited,
        "_id": id,
        "patientId": patientId.toJson(),
        "packageId": packageId.toJson(),
        "hospitalId": hospitalId.toJson(),
        "visit_date": visitDate,
        "createAt": createAt,
        "__v": v,
      };
}

class HospitalId {
  String id;
  String name;

  HospitalId({
    this.id,
    this.name,
  });

  factory HospitalId.fromJson(Map<String, dynamic> json) => HospitalId(
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
