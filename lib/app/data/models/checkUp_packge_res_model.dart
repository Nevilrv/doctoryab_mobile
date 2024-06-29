// To parse this JSON data, do
//
//     final checkUpPackageResModel = checkUpPackageResModelFromJson(jsonString);

import 'dart:convert';

CheckUpPackageResModel checkUpPackageResModelFromJson(String str) =>
    CheckUpPackageResModel.fromJson(json.decode(str));

String checkUpPackageResModelToJson(CheckUpPackageResModel data) =>
    json.encode(data.toJson());

class CheckUpPackageResModel {
  List<PackageHistory>? data;
  int? count;

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
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "count": count,
      };
}

class PackageHistory {
  bool? bookingNotified;
  bool? visited;
  String? id;
  PackageId? packageId;
  PatientId? patientId;
  String? visitDate;
  Id? labId;
  Id? hospitalId;
  String? cityId;
  String? createAt;
  int? v;

  PackageHistory({
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

  factory PackageHistory.fromJson(Map<String, dynamic> json) => PackageHistory(
        bookingNotified: json["bookingNotified"],
        visited: json["visited"],
        id: json["_id"],
        packageId: PackageId.fromJson(json["packageId"]),
        patientId: PatientId.fromJson(json["patientId"]),
        visitDate: json["visit_date"],
        labId: json["labId"] == null ? null : Id.fromJson(json["labId"]),
        hospitalId: Id.fromJson(json["hospitalId"]),
        cityId: json["cityId"],
        createAt: json["createAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "bookingNotified": bookingNotified,
        "visited": visited,
        "_id": id,
        "packageId": packageId!.toJson(),
        "patientId": patientId!.toJson(),
        "visit_date": visitDate,
        "labId": labId?.toJson(),
        "hospitalId": hospitalId!.toJson(),
        "cityId": cityId,
        "createAt": createAt,
        "__v": v,
      };
}

class Id {
  String? id;
  String? name;

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
  List<dynamic>? specialistConsultants;
  String? img;
  String? observerImg;
  bool? isPublished;
  List<HospitalLocation>? hospitalLocation;
  List<LabLocation>? labLocation;
  List<dynamic>? doctorLocation;
  List<dynamic>? cities;
  String? totalFeedbacks;
  String? averageRating;
  int? countOfPatient;
  String? id;
  String? title;
  String? description;
  List<PackageInclude>? packageInclude;
  String? sampleType;
  String? fastingRequired;
  String? byObservation;
  String? duration;
  String? price;
  String? rrp;
  String? discount;
  String? createAt;
  int? v;
  String? publishedAt;
  String? totalTests;

  PackageId({
    this.specialistConsultants,
    this.img,
    this.observerImg,
    this.isPublished,
    this.hospitalLocation,
    this.labLocation,
    this.doctorLocation,
    this.cities,
    this.totalFeedbacks,
    this.averageRating,
    this.countOfPatient,
    this.id,
    this.title,
    this.description,
    this.packageInclude,
    this.sampleType,
    this.fastingRequired,
    this.byObservation,
    this.duration,
    this.price,
    this.rrp,
    this.discount,
    this.createAt,
    this.v,
    this.publishedAt,
    this.totalTests,
  });

  factory PackageId.fromJson(Map<String, dynamic> json) => PackageId(
        specialistConsultants:
            List<dynamic>.from(json["specialistConsultants"].map((x) => x)),
        img: json["img"],
        observerImg: json["observerImg"],
        isPublished: json["is_published"],
        hospitalLocation: List<HospitalLocation>.from(
            json["hospitalLocation"].map((x) => HospitalLocation.fromJson(x))),
        labLocation: List<LabLocation>.from(
            json["labLocation"].map((x) => LabLocation.fromJson(x))),
        doctorLocation:
            List<dynamic>.from(json["doctorLocation"].map((x) => x)),
        cities: List<dynamic>.from(json["cities"].map((x) => x)),
        totalFeedbacks: json["totalFeedbacks"],
        averageRating: json["averageRating"],
        countOfPatient: json["countOfPatient"],
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        packageInclude: List<PackageInclude>.from(
            json["packageInclude"].map((x) => PackageInclude.fromJson(x))),
        sampleType: json["sampleType"],
        fastingRequired: json["fastingRequired"],
        byObservation: json["byObservation"],
        duration: json["duration"],
        price: json["price"],
        rrp: json["rrp"],
        discount: json["discount"],
        createAt: json["createAt"],
        v: json["__v"],
        publishedAt: json["publishedAt"],
        totalTests: json["totalTests"],
      );

  Map<String, dynamic> toJson() => {
        "specialistConsultants":
            List<dynamic>.from(specialistConsultants!.map((x) => x)),
        "img": img,
        "observerImg": observerImg,
        "is_published": isPublished,
        "hospitalLocation":
            List<dynamic>.from(hospitalLocation!.map((x) => x.toJson())),
        "labLocation": List<dynamic>.from(labLocation!.map((x) => x.toJson())),
        "doctorLocation": List<dynamic>.from(doctorLocation!.map((x) => x)),
        "cities": List<dynamic>.from(cities!.map((x) => x)),
        "totalFeedbacks": totalFeedbacks,
        "averageRating": averageRating,
        "countOfPatient": countOfPatient,
        "_id": id,
        "title": title,
        "description": description,
        "packageInclude":
            List<dynamic>.from(packageInclude!.map((x) => x.toJson())),
        "sampleType": sampleType,
        "fastingRequired": fastingRequired,
        "byObservation": byObservation,
        "duration": duration,
        "price": price,
        "rrp": rrp,
        "discount": discount,
        "createAt": createAt,
        "__v": v,
        "publishedAt": publishedAt,
        "totalTests": totalTests,
      };
}

class HospitalLocation {
  String? id;
  String? address;
  String? name;
  String? phone;

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
  List<String>? phone;
  String? id;
  String? name;

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
        "phone": List<dynamic>.from(phone!.map((x) => x)),
        "_id": id,
        "name": name,
      };
}

class PackageInclude {
  String? id;
  String? testTitle;
  String? testDesc;

  PackageInclude({
    this.id,
    this.testTitle,
    this.testDesc,
  });

  factory PackageInclude.fromJson(Map<String, dynamic> json) => PackageInclude(
        id: json["_id"],
        testTitle: json["testTitle"],
        testDesc: json["testDesc"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "testTitle": testTitle,
        "testDesc": testDesc,
      };
}

class PatientId {
  String? id;
  String? phone;
  String? patientId;
  String? name;

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
