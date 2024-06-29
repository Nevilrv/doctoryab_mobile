// To parse this JSON data, do
//
//     final bloodDonorSearchModel = bloodDonorSearchModelFromJson(jsonString);

import 'dart:convert';

import 'blood_donor_update.dart';

BloodDonorSearchModel bloodDonorSearchModelFromJson(String str) =>
    BloodDonorSearchModel.fromJson(json.decode(str));

String bloodDonorSearchModelToJson(BloodDonorSearchModel data) =>
    json.encode(data.toJson());

class BloodDonorSearchModel {
  BloodDonorSearchModel({
    this.bloodGroup,
    this.bloodUnits,
    this.critical,
    this.condition,
    this.name,
    this.number,
    this.geometry,
  });

  String? bloodGroup;
  int? bloodUnits;
  bool? critical;
  String? condition;
  String? name;
  String? number;
  Geometry? geometry;

  BloodDonorSearchModel copyWith({
    String? bloodGroup,
    int? bloodUnits,
    bool? critical,
    String? condition,
    String? name,
    String? number,
    Geometry? geometry,
  }) =>
      BloodDonorSearchModel(
        bloodGroup: bloodGroup ?? this.bloodGroup,
        bloodUnits: bloodUnits ?? this.bloodUnits,
        critical: critical ?? this.critical,
        condition: condition ?? this.condition,
        name: name ?? this.name,
        number: number ?? this.number,
        geometry: geometry ?? this.geometry,
      );

  factory BloodDonorSearchModel.fromJson(Map<String, dynamic> json) =>
      BloodDonorSearchModel(
        bloodGroup: json["bloodGroup"],
        bloodUnits: json["bloodUnits"],
        critical: json["critical"],
        condition: json["condition"],
        name: json["name"],
        number: json["number"],
        geometry: Geometry.fromJson(json["geometry"]),
      );

  Map<String, dynamic> toJson() => {
        "bloodGroup": bloodGroup,
        "bloodUnits": bloodUnits,
        "critical": critical,
        "condition": condition,
        "name": name,
        "number": number,
        "geometry": geometry!.toJson(),
      };
}
