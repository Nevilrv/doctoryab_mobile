// To parse this JSON data, do
//
//     final pregnancyDetailsModel = pregnancyDetailsModelFromJson(jsonString);

import 'dart:convert';

PregnancyDetailsModel pregnancyDetailsModelFromJson(String str) =>
    PregnancyDetailsModel.fromJson(json.decode(str));

String pregnancyDetailsModelToJson(PregnancyDetailsModel data) =>
    json.encode(data.toJson());

class PregnancyDetailsModel {
  bool? isSaved;
  PregnancyData? data;

  PregnancyDetailsModel({
    this.isSaved,
    this.data,
  });

  factory PregnancyDetailsModel.fromJson(Map<String, dynamic> json) =>
      PregnancyDetailsModel(
        isSaved: json["isSaved"],
        data: PregnancyData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "isSaved": isSaved,
        "data": data!.toJson(),
      };
}

class PregnancyData {
  String? id;
  String? conceptionDate;
  String? dueDate;
  String? patientId;
  String? createAt;
  String? lastPeriodDate;
  int? currentWeek;
  List<PtModule>? ptModules;

  PregnancyData({
    this.id,
    this.conceptionDate,
    this.dueDate,
    this.patientId,
    this.createAt,
    this.lastPeriodDate,
    this.currentWeek,
    this.ptModules,
  });

  factory PregnancyData.fromJson(Map<String, dynamic> json) => PregnancyData(
        id: json["_id"],
        conceptionDate: json["conceptionDate"],
        dueDate: json["dueDate"],
        patientId: json["patientId"],
        createAt: json["createAt"],
        lastPeriodDate: json["lastPeriodDate"],
        currentWeek: json["currentWeek"],
        ptModules: List<PtModule>.from(
            json["ptModules"].map((x) => PtModule.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "conceptionDate": conceptionDate,
        "dueDate": dueDate,
        "patientId": patientId,
        "createAt": createAt,
        "lastPeriodDate": lastPeriodDate,
        "currentWeek": currentWeek,
        "ptModules": List<dynamic>.from(ptModules!.map((x) => x.toJson())),
      };
}

class PtModule {
  String? img;
  String? id;
  int? week;
  String? trimister;
  String? sizeEnglish;
  String? sizeDari;
  String? sizePashto;
  String? weightEnglish;
  String? weightDari;
  String? weightPashto;
  String? lengthEnglish;
  String? lengthDari;
  String? lengthPashto;
  String? weekInfoEnglish;
  String? weekInfoDari;
  String? weekInfoPashto;
  String? userId;
  String? createAt;
  int? v;

  PtModule({
    this.img,
    this.id,
    this.week,
    this.trimister,
    this.sizeEnglish,
    this.sizeDari,
    this.sizePashto,
    this.weightEnglish,
    this.weightDari,
    this.weightPashto,
    this.lengthEnglish,
    this.lengthDari,
    this.lengthPashto,
    this.weekInfoEnglish,
    this.weekInfoDari,
    this.weekInfoPashto,
    this.userId,
    this.createAt,
    this.v,
  });

  factory PtModule.fromJson(Map<String, dynamic> json) => PtModule(
        img: json["img"],
        id: json["_id"],
        week: json["week"],
        trimister: json["trimister"],
        sizeEnglish: json["sizeEnglish"],
        sizeDari: json["sizeDari"],
        sizePashto: json["sizePashto"],
        weightEnglish: json["weightEnglish"],
        weightDari: json["weightDari"],
        weightPashto: json["weightPashto"],
        lengthEnglish: json["lengthEnglish"],
        lengthDari: json["lengthDari"],
        lengthPashto: json["lengthPashto"],
        weekInfoEnglish: json["weekInfoEnglish"],
        weekInfoDari: json["weekInfoDari"],
        weekInfoPashto: json["weekInfoPashto"],
        userId: json["userId"],
        createAt: json["createAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "img": img,
        "_id": id,
        "week": week,
        "trimister": trimister,
        "sizeEnglish": sizeEnglish,
        "sizeDari": sizeDari,
        "sizePashto": sizePashto,
        "weightEnglish": weightEnglish,
        "weightDari": weightDari,
        "weightPashto": weightPashto,
        "lengthEnglish": lengthEnglish,
        "lengthDari": lengthDari,
        "lengthPashto": lengthPashto,
        "weekInfoEnglish": weekInfoEnglish,
        "weekInfoDari": weekInfoDari,
        "weekInfoPashto": weekInfoPashto,
        "userId": userId,
        "createAt": createAt,
        "__v": v,
      };
}
