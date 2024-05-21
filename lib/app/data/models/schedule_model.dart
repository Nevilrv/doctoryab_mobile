// To parse this JSON data, do
//
//     final schedule = scheduleFromJson(jsonString);

import 'dart:convert';

Schedule scheduleFromJson(String str) => Schedule.fromJson(json.decode(str));

String scheduleToJson(Schedule data) => json.encode(data.toJson());

class Schedule {
  Schedule({
    this.data,
  });

  List<ScheduleData>? data;

  Schedule copyWith({
    List<ScheduleData>? data,
  }) =>
      Schedule(
        data: data ?? this.data,
      );

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        data: json["data"] == null
            ? null
            : List<ScheduleData>.from(
                json["data"].map((x) => ScheduleData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ScheduleData {
  ScheduleData({
    this.date,
    this.count,
    this.times,
  });

  DateTime? date;
  int? count;
  List<DateTime>? times;

  ScheduleData copyWith({
    DateTime? date,
    int? count,
    List<DateTime>? times,
  }) =>
      ScheduleData(
        date: date ?? this.date,
        count: count ?? this.count,
        times: times ?? this.times,
      );

  factory ScheduleData.fromJson(Map<String, dynamic> json) => ScheduleData(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        count: json["count"] == null ? null : json["count"],
        times: json["times"] == null
            ? null
            : List<DateTime>.from(json["times"].map((x) => DateTime.parse(x))),
      );

  Map<String, dynamic> toJson() => {
        "date": date == null ? null : date!.toIso8601String(),
        "count": count == null ? null : count,
        "times": times == null
            ? null
            : List<dynamic>.from(times!.map((x) => x.toIso8601String())),
      };
}
