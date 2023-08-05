// To parse this JSON data, do
//
//     final bloodDonors = bloodDonorsFromJson(jsonString);

import 'dart:convert';

BloodDonors bloodDonorsFromJson(String str) =>
    BloodDonors.fromJson(json.decode(str));

String bloodDonorsToJson(BloodDonors data) => json.encode(data.toJson());

class BloodDonors {
  BloodDonors({
    this.bloodDonors,
  });

  List<BloodDonor> bloodDonors;

  BloodDonors copyWith({
    List<BloodDonor> data,
  }) =>
      BloodDonors(
        bloodDonors: data ?? this.bloodDonors,
      );

  factory BloodDonors.fromJson(Map<String, dynamic> json) => BloodDonors(
        bloodDonors: List<BloodDonor>.from(
            json["data"].map((x) => BloodDonor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(bloodDonors.map((x) => x.toJson())),
      };
}

class BloodDonor {
  BloodDonor({
    this.datumId,
    this.geometry,
    this.verified,
    this.createAt,
    this.donorName,
    this.age,
    this.phone,
    this.bloodGroup,
    this.gender,
    this.id,
    this.v,
    this.distance,
  });

  String datumId;
  Geometry geometry;
  bool verified;
  DateTime createAt;
  String donorName;
  int age;
  num phone;
  String bloodGroup;
  String gender;
  int id;
  int v;
  double distance;

  BloodDonor copyWith({
    String datumId,
    Geometry geometry,
    bool verified,
    DateTime createAt,
    String donorName,
    int age,
    num phone,
    String bloodGroup,
    String gender,
    int id,
    int v,
    double distance,
  }) =>
      BloodDonor(
        datumId: datumId ?? this.datumId,
        geometry: geometry ?? this.geometry,
        verified: verified ?? this.verified,
        createAt: createAt ?? this.createAt,
        donorName: donorName ?? this.donorName,
        age: age ?? this.age,
        phone: phone ?? this.phone,
        bloodGroup: bloodGroup ?? this.bloodGroup,
        gender: gender ?? this.gender,
        id: id ?? this.id,
        v: v ?? this.v,
        distance: distance ?? this.distance,
      );

  factory BloodDonor.fromJson(Map<String, dynamic> json) => BloodDonor(
        datumId: json["_id"],
        geometry: Geometry.fromJson(json["geometry"]),
        verified: json["verified"],
        createAt: DateTime.parse(json["createAt"]),
        donorName: json["donorName"],
        age: json["age"],
        phone: json["phone"],
        bloodGroup: json["bloodGroup"],
        //TODO the datatype is dynamic from API
        // gender: json["gender"],
        id: json["ID"],
        v: json["__v"],
        distance: json["distance"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": datumId,
        "geometry": geometry.toJson(),
        "verified": verified,
        "createAt": createAt.toIso8601String(),
        "donorName": donorName,
        "age": age,
        "phone": phone,
        "bloodGroup": bloodGroup,
        "gender": gender,
        "ID": id,
        "__v": v,
        "distance": distance,
      };
}

class Geometry {
  Geometry({
    this.type,
    this.coordinates,
  });

  String type;
  List<double> coordinates;

  Geometry copyWith({
    String type,
    List<double> coordinates,
  }) =>
      Geometry(
        type: type ?? this.type,
        coordinates: coordinates ?? this.coordinates,
      );

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"] ?? "",
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}
