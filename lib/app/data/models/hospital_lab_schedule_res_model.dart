// To parse this JSON data, do
//
//     final hoapitalLabScheduleResModel = hoapitalLabScheduleResModelFromJson(jsonString);

import 'dart:convert';

HospitalLabScheduleResModel hospitalLabScheduleResModelFromJson(String str) =>
    HospitalLabScheduleResModel.fromJson(json.decode(str));

String hospitalLabScheduleResModelToJson(HospitalLabScheduleResModel data) =>
    json.encode(data.toJson());

class HospitalLabScheduleResModel {
  List<Schedule> data;

  HospitalLabScheduleResModel({
    this.data,
  });

  factory HospitalLabScheduleResModel.fromJson(Map<String, dynamic> json) =>
      HospitalLabScheduleResModel(
        data:
            List<Schedule>.from(json["data"].map((x) => Schedule.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Schedule {
  List<String> times;
  List<int> counts;
  String id;
  int dayOfWeek;
  String user;
  int v;

  Schedule({
    this.times,
    this.counts,
    this.id,
    this.dayOfWeek,
    this.user,
    this.v,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        times: List<String>.from(json["times"].map((x) => x)),
        counts: List<int>.from(json["counts"].map((x) => x)),
        id: json["_id"],
        dayOfWeek: json["dayOfWeek"],
        user: json["user"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "times": List<dynamic>.from(times.map((x) => x)),
        "counts": List<dynamic>.from(counts.map((x) => x)),
        "_id": id,
        "dayOfWeek": dayOfWeek,
        "user": user,
        "__v": v,
      };
}
