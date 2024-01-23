// To parse this JSON data, do
//
//     final dieaseDataListResModel = dieaseDataListResModelFromJson(jsonString);

import 'dart:convert';

DieaseDataListResModel dieaseDataListResModelFromJson(String str) =>
    DieaseDataListResModel.fromJson(json.decode(str));

String dieaseDataListResModelToJson(DieaseDataListResModel data) =>
    json.encode(data.toJson());

class DieaseDataListResModel {
  List<Datum> data;
  int count;

  DieaseDataListResModel({
    this.data,
    this.count,
  });

  factory DieaseDataListResModel.fromJson(Map<String, dynamic> json) =>
      DieaseDataListResModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count,
      };
}

class Datum {
  String img;
  List<dynamic> views;
  String audio;
  String audioPashto;
  String audioDari;
  String id;
  String title;
  String dariTitle;
  String pashtoTitle;
  String desc;
  String pashtoDesc;
  String dariDesc;
  String pashtoCategory;
  String dariCategory;
  String category;
  String doctorId;
  String createAt;
  int v;

  Datum({
    this.img,
    this.views,
    this.audio,
    this.audioPashto,
    this.audioDari,
    this.id,
    this.title,
    this.dariTitle,
    this.pashtoTitle,
    this.desc,
    this.pashtoDesc,
    this.dariDesc,
    this.pashtoCategory,
    this.dariCategory,
    this.category,
    this.doctorId,
    this.createAt,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        img: json["img"],
        views: List<dynamic>.from(json["views"].map((x) => x)),
        audio: json["audio"],
        audioPashto: json["audioPashto"],
        audioDari: json["audioDari"],
        id: json["_id"],
        title: json["title"],
        dariTitle: json["dariTitle"],
        pashtoTitle: json["pashtoTitle"],
        desc: json["desc"],
        pashtoDesc: json["pashtoDesc"],
        dariDesc: json["dariDesc"],
        pashtoCategory: json["pashtoCategory"],
        dariCategory: json["dariCategory"],
        category: json["category"],
        doctorId: json["doctorId"],
        createAt: json["createAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "img": img,
        "views": List<dynamic>.from(views.map((x) => x)),
        "audio": audio,
        "audioPashto": audioPashto,
        "audioDari": audioDari,
        "_id": id,
        "title": title,
        "dariTitle": dariTitle,
        "pashtoTitle": pashtoTitle,
        "desc": desc,
        "pashtoDesc": pashtoDesc,
        "dariDesc": dariDesc,
        "pashtoCategory": pashtoCategory,
        "dariCategory": dariCategory,
        "category": category,
        "doctorId": doctorId,
        "createAt": createAt,
        "__v": v,
      };
}
