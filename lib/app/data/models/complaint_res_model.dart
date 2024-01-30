// To parse this JSON data, do
//
//     final complaintResModel = complaintResModelFromJson(jsonString);

import 'dart:convert';

ComplaintResModel complaintResModelFromJson(String str) =>
    ComplaintResModel.fromJson(json.decode(str));

String complaintResModelToJson(ComplaintResModel data) =>
    json.encode(data.toJson());

class ComplaintResModel {
  String msg;
  Data data;

  ComplaintResModel({
    this.msg,
    this.data,
  });

  factory ComplaintResModel.fromJson(Map<String, dynamic> json) =>
      ComplaintResModel(
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "data": data.toJson(),
      };
}

class Data {
  String img;
  String id;
  String title;
  String desc;
  String user;
  String createAt;
  int v;

  Data({
    this.img,
    this.id,
    this.title,
    this.desc,
    this.user,
    this.createAt,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        img: json["img"],
        id: json["_id"],
        title: json["title"],
        desc: json["desc"],
        user: json["user"],
        createAt: json["createAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "img": img,
        "_id": id,
        "title": title,
        "desc": desc,
        "user": user,
        "createAt": createAt,
        "__v": v,
      };
}
