// To parse this JSON data, do
//
//     final checkupPackagesResModel = checkupPackagesResModelFromJson(jsonString);

import 'dart:convert';

CheckupPackagesResModel checkupPackagesResModelFromJson(String str) =>
    CheckupPackagesResModel.fromJson(json.decode(str));

String checkupPackagesResModelToJson(CheckupPackagesResModel data) =>
    json.encode(data.toJson());

class CheckupPackagesResModel {
  List<Package> data;
  int count;

  CheckupPackagesResModel({
    this.data,
    this.count,
  });

  factory CheckupPackagesResModel.fromJson(Map<String, dynamic> json) =>
      CheckupPackagesResModel(
        data: List<Package>.from(json["data"].map((x) => Package.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count,
      };
}

class Package {
  String id;
  List<SpecialistConsultant> specialistConsultants;
  String img;
  String observerImg;
  bool isPublished;
  List<HospitalLocation> hospitalLocation;
  List<LabLocation> labLocation;
  List<DoctorLocation> doctorLocation;
  String title;
  String description;
  List<PackageInclude> packageInclude;
  String createAt;
  int v;
  String byObservation;
  String discount;
  String duration;
  String fastingRequired;
  String price;
  String rrp;
  String sampleType;
  String publishedAt;
  int countOfPatient;

  Package({
    this.id,
    this.specialistConsultants,
    this.img,
    this.observerImg,
    this.isPublished,
    this.hospitalLocation,
    this.labLocation,
    this.doctorLocation,
    this.title,
    this.description,
    this.packageInclude,
    this.createAt,
    this.v,
    this.byObservation,
    this.discount,
    this.duration,
    this.fastingRequired,
    this.price,
    this.rrp,
    this.sampleType,
    this.publishedAt,
    this.countOfPatient,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        id: json["_id"],
        specialistConsultants: List<SpecialistConsultant>.from(
            json["specialistConsultants"]
                .map((x) => SpecialistConsultant.fromJson(x))),
        img: json["img"],
        observerImg: json["observerImg"],
        isPublished: json["is_published"],
        hospitalLocation: List<HospitalLocation>.from(
            json["hospitalLocation"].map((x) => HospitalLocation.fromJson(x))),
        labLocation: List<LabLocation>.from(
            json["labLocation"].map((x) => LabLocation.fromJson(x))),
        doctorLocation: List<DoctorLocation>.from(
            json["doctorLocation"].map((x) => DoctorLocation.fromJson(x))),
        title: json["title"],
        description: json["description"],
        packageInclude: List<PackageInclude>.from(
            json["packageInclude"].map((x) => PackageInclude.fromJson(x))),
        createAt: json["createAt"],
        v: json["__v"],
        byObservation: json["byObservation"],
        discount: json["discount"],
        duration: json["duration"],
        fastingRequired: json["fastingRequired"],
        price: json["price"],
        rrp: json["rrp"],
        sampleType: json["sampleType"],
        publishedAt: json["publishedAt"],
        countOfPatient: json["countOfPatient"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "specialistConsultants":
            List<dynamic>.from(specialistConsultants.map((x) => x.toJson())),
        "img": img,
        "observerImg": observerImg,
        "is_published": isPublished,
        "hospitalLocation":
            List<dynamic>.from(hospitalLocation.map((x) => x.toJson())),
        "labLocation": List<dynamic>.from(labLocation.map((x) => x.toJson())),
        "doctorLocation":
            List<dynamic>.from(doctorLocation.map((x) => x.toJson())),
        "title": title,
        "description": description,
        "packageInclude":
            List<dynamic>.from(packageInclude.map((x) => x.toJson())),
        "createAt": createAt,
        "__v": v,
        "byObservation": byObservation,
        "discount": discount,
        "duration": duration,
        "fastingRequired": fastingRequired,
        "price": price,
        "rrp": rrp,
        "sampleType": sampleType,
        "publishedAt": publishedAt,
        "countOfPatient": countOfPatient,
      };
}

class DoctorLocation {
  String id;
  String email;
  String fullname;

  DoctorLocation({
    this.id,
    this.email,
    this.fullname,
  });

  factory DoctorLocation.fromJson(Map<String, dynamic> json) => DoctorLocation(
        id: json["_id"],
        email: json["email"],
        fullname: json["fullname"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "fullname": fullname,
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

class PackageInclude {
  String id;
  String testTitle;
  String testDesc;

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

class SpecialistConsultant {
  String id;
  bool isDeleted;
  String fTitle;
  String eTitle;
  String pTitle;
  String background;
  int v;
  String photo;
  String createdAt;
  String updatedAt;
  int order;

  SpecialistConsultant({
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

  factory SpecialistConsultant.fromJson(Map<String, dynamic> json) =>
      SpecialistConsultant(
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
