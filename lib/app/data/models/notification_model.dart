// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  List<Notification>? data;
  int? count;

  NotificationModel({
    this.data,
    this.count,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        data: List<Notification>.from(
            json["data"].map((x) => Notification.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "count": count,
      };
}

class Notification {
  String? id;
  String? title;
  String? status;
  String? body;
  User? user;
  PrescriptionId? prescriptionId;
  AppointmentId? appointmentId;
  ReportId? reportId;
  int? v;
  String? type;
  BlogId? blogId;
  String? bodyInEnglish;
  String? bodyInPashto;
  String? bodyInDari;
  String? doctorId;

  Notification({
    this.id,
    this.title,
    this.status,
    this.body,
    this.user,
    this.prescriptionId,
    this.appointmentId,
    this.reportId,
    this.v,
    this.type,
    this.bodyInEnglish,
    this.bodyInPashto,
    this.bodyInDari,
    this.blogId,
    this.doctorId,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["_id"],
        status: json["status"],
        title: json["title"],
        body: json["body"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        prescriptionId: json["prescriptionId"] == null
            ? null
            : PrescriptionId.fromJson(json["prescriptionId"]),
        appointmentId: json["appointmentId"] == null
            ? null
            : AppointmentId.fromJson(json["appointmentId"]),
        reportId: json["reportId"] == null
            ? null
            : ReportId.fromJson(json["reportId"]),
        v: json["__v"],
        type: json["type"],
        bodyInEnglish: json["bodyInEnglish"],
        bodyInPashto: json["bodyInPashto"],
        bodyInDari: json["bodyInDari"],
        blogId: json["blogId"] == null ? null : BlogId.fromJson(json["blogId"]),
        doctorId: json["doctorId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "title": title,
        "body": body,
        "user": user?.toJson(),
        "prescriptionId": prescriptionId?.toJson(),
        "appointmentId": appointmentId?.toJson(),
        "reportId": reportId!.toJson(),
        "__v": v,
        "type": type,
        "bodyInEnglish": bodyInEnglish,
        "bodyInPashto": bodyInPashto,
        "bodyInDari": bodyInDari,
        "blogId": blogId?.toJson(),
        "doctorId": doctorId,
      };
}

class AppointmentId {
  bool? notified24H;
  bool? notified30M;
  bool? bookingNotified;
  bool? visited;
  int? treatmentForDoc;
  int? knowledgeForDoc;
  int? cleaningForDoc;
  int? starsForDoc;
  String? doctorTitle;
  String? doctorDescription;
  List<dynamic>? medicines;
  String? appointmentIdId;
  String? name;
  int? age;
  String? phone;
  String? visitDate;
  String? patientId;
  String? doctor;
  String? role;
  String? id;
  String? createAt;
  int? v;

  AppointmentId({
    this.notified24H,
    this.notified30M,
    this.bookingNotified,
    this.visited,
    this.treatmentForDoc,
    this.knowledgeForDoc,
    this.cleaningForDoc,
    this.starsForDoc,
    this.doctorTitle,
    this.doctorDescription,
    this.medicines,
    this.appointmentIdId,
    this.name,
    this.age,
    this.phone,
    this.visitDate,
    this.patientId,
    this.doctor,
    this.role,
    this.id,
    this.createAt,
    this.v,
  });

  factory AppointmentId.fromJson(Map<String, dynamic> json) => AppointmentId(
        notified24H: json["notified_24h"],
        notified30M: json["notified_30m"],
        bookingNotified: json["bookingNotified"],
        visited: json["visited"],
        treatmentForDoc: json["treatmentForDoc"],
        knowledgeForDoc: json["knowledgeForDoc"],
        cleaningForDoc: json["cleaningForDoc"],
        starsForDoc: json["starsForDoc"],
        doctorTitle: json["DoctorTitle"],
        doctorDescription: json["DoctorDescription"],
        medicines: List<dynamic>.from(json["medicines"].map((x) => x)),
        appointmentIdId: json["_id"],
        name: json["name"],
        age: json["age"],
        phone: json["phone"],
        visitDate: json["visit_date"],
        patientId: json["patientId"],
        doctor: json["doctor"],
        role: json["role"],
        id: json["ID"],
        createAt: json["createAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "notified_24h": notified24H,
        "notified_30m": notified30M,
        "bookingNotified": bookingNotified,
        "visited": visited,
        "treatmentForDoc": treatmentForDoc,
        "knowledgeForDoc": knowledgeForDoc,
        "cleaningForDoc": cleaningForDoc,
        "starsForDoc": starsForDoc,
        "DoctorTitle": doctorTitle,
        "DoctorDescription": doctorDescription,
        "medicines": List<dynamic>.from(medicines!.map((x) => x)),
        "_id": appointmentIdId,
        "name": name,
        "age": age,
        "phone": phone,
        "visit_date": visitDate,
        "patientId": patientId,
        "doctor": doctor,
        "role": role,
        "ID": id,
        "createAt": createAt,
        "__v": v,
      };
}

class BlogId {
  String? img;
  List<dynamic>? likes;
  List<String>? shares;
  List<dynamic>? comments;
  bool? isPublished;
  String? id;
  String? name;
  String? desc;
  String? category;
  String? blogTitle;
  String? doctorId;
  String? createAt;
  int? v;
  String? publishedAt;

  BlogId({
    this.img,
    this.likes,
    this.shares,
    this.comments,
    this.isPublished,
    this.id,
    this.name,
    this.desc,
    this.category,
    this.blogTitle,
    this.doctorId,
    this.createAt,
    this.v,
    this.publishedAt,
  });

  factory BlogId.fromJson(Map<String, dynamic> json) => BlogId(
        img: json["img"],
        likes: List<dynamic>.from(json["likes"].map((x) => x)),
        shares: List<String>.from(json["shares"].map((x) => x)),
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        isPublished: json["is_published"],
        id: json["_id"],
        name: json["name"],
        desc: json["desc"],
        category: json["category"],
        blogTitle: json["blogTitle"],
        doctorId: json["doctorId"],
        createAt: json["createAt"],
        v: json["__v"],
        publishedAt: json["publishedAt"],
      );

  Map<String, dynamic> toJson() => {
        "img": img,
        "likes": List<dynamic>.from(likes!.map((x) => x)),
        "shares": List<dynamic>.from(shares!.map((x) => x)),
        "comments": List<dynamic>.from(comments!.map((x) => x)),
        "is_published": isPublished,
        "_id": id,
        "name": name,
        "desc": desc,
        "category": category,
        "blogTitle": blogTitle,
        "doctorId": doctorId,
        "createAt": createAt,
        "__v": v,
        "publishedAt": publishedAt,
      };
}

class PrescriptionId {
  List<String>? documents;
  List<Medicine>? medicines;
  String? id;
  String? phone;
  String? name;
  int? age;
  String? patientId;
  String? bp;
  String? temp;
  String? advice;
  String? doctorSignature;
  String? appointmentDocId;
  String? gender;
  String? prescriptionCreateAt;
  String? weight;
  String? height;
  String? doctor;
  String? createAt;
  int? v;

  PrescriptionId({
    this.documents,
    this.medicines,
    this.id,
    this.phone,
    this.name,
    this.age,
    this.patientId,
    this.bp,
    this.temp,
    this.advice,
    this.doctorSignature,
    this.appointmentDocId,
    this.gender,
    this.prescriptionCreateAt,
    this.weight,
    this.height,
    this.doctor,
    this.createAt,
    this.v,
  });

  factory PrescriptionId.fromJson(Map<String, dynamic> json) => PrescriptionId(
        documents: List<String>.from(json["documents"].map((x) => x)),
        medicines: List<Medicine>.from(
            json["medicines"].map((x) => Medicine.fromJson(x))),
        id: json["_id"],
        phone: json["phone"],
        name: json["name"],
        age: json["age"],
        patientId: json["patientId"],
        bp: json["bp"],
        temp: json["temp"],
        advice: json["advice"],
        doctorSignature: json["doctorSignature"],
        appointmentDocId: json["appointmentDocId"],
        gender: json["gender"],
        prescriptionCreateAt: json["prescriptionCreateAt"],
        weight: json["weight"],
        height: json["height"],
        doctor: json["doctor"],
        createAt: json["createAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "documents": List<dynamic>.from(documents!.map((x) => x)),
        "medicines": List<dynamic>.from(medicines!.map((x) => x.toJson())),
        "_id": id,
        "phone": phone,
        "name": name,
        "age": age,
        "patientId": patientId,
        "bp": bp,
        "temp": temp,
        "advice": advice,
        "doctorSignature": doctorSignature,
        "appointmentDocId": appointmentDocId,
        "gender": gender,
        "prescriptionCreateAt": prescriptionCreateAt,
        "weight": weight,
        "height": height,
        "doctor": doctor,
        "createAt": createAt,
        "__v": v,
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

class User {
  Geometry? geometry;
  String? photo;
  String? id;
  String? phone;
  String? fcm;
  String? createAt;
  String? patientId;
  int? v;
  int? age;
  String? name;
  String? city;
  String? gender;

  User({
    this.geometry,
    this.photo,
    this.id,
    this.phone,
    this.fcm,
    this.createAt,
    this.patientId,
    this.v,
    this.age,
    this.name,
    this.city,
    this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        geometry: Geometry.fromJson(json["geometry"]),
        photo: json["photo"],
        id: json["_id"],
        phone: json["phone"],
        fcm: json["fcm"],
        createAt: json["createAt"],
        patientId: json["patientID"],
        v: json["__v"],
        age: json["age"],
        name: json["name"],
        city: json["city"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "geometry": geometry!.toJson(),
        "photo": photo,
        "_id": id,
        "phone": phone,
        "fcm": fcm,
        "createAt": createAt,
        "patientID": patientId,
        "__v": v,
        "age": age,
        "name": name,
        "city": city,
        "gender": gender,
      };
}

class ReportId {
  List<String>? documents;
  String? id;
  String? patientId;
  String? name;
  String? phone;
  String? title;
  String? description;
  String? doctor;
  String? createAt;
  int? v;

  ReportId({
    this.documents,
    this.id,
    this.patientId,
    this.name,
    this.phone,
    this.title,
    this.description,
    this.doctor,
    this.createAt,
    this.v,
  });

  factory ReportId.fromJson(Map<String, dynamic> json) => ReportId(
        documents: List<String>.from(json["documents"].map((x) => x)),
        id: json["_id"],
        patientId: json["patientId"],
        name: json["name"],
        phone: json["phone"],
        title: json["title"],
        description: json["description"],
        doctor: json["doctor"],
        createAt: json["createAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "documents": List<dynamic>.from(documents!.map((x) => x)),
        "_id": id,
        "patientId": patientId,
        "name": name,
        "phone": phone,
        "title": title,
        "description": description,
        "doctor": doctor,
        "createAt": createAt,
        "__v": v,
      };
}

class Geometry {
  String? type;
  List<double>? coordinates;

  Geometry({
    this.type,
    this.coordinates,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates!.map((x) => x)),
      };
}
