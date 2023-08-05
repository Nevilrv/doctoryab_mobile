// To parse this JSON data, do
//
//     final bloodDonorUpdateResponseModel = bloodDonorUpdateResponseModelFromJson(jsonString);

import 'dart:convert';

BloodDonorUpdateResponseModel bloodDonorUpdateResponseModelFromJson(
        String str) =>
    BloodDonorUpdateResponseModel.fromJson(json.decode(str));

String bloodDonorUpdateResponseModelToJson(
        BloodDonorUpdateResponseModel data) =>
    json.encode(data.toJson());

class BloodDonorUpdateResponseModel {
  BloodDonorUpdateResponseModel({
    this.msg,
    this.data,
  });

  String msg;
  Data data;

  BloodDonorUpdateResponseModel copyWith({
    String msg,
    Data data,
  }) =>
      BloodDonorUpdateResponseModel(
        msg: msg ?? this.msg,
        data: data ?? this.data,
      );

  factory BloodDonorUpdateResponseModel.fromJson(Map<String, dynamic> json) =>
      BloodDonorUpdateResponseModel(
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.geometry,
    this.verified,
    this.createAt,
    this.dataId,
    this.donorName,
    this.age,
    this.phone,
    this.bloodGroup,
    this.gender,
    this.id,
    this.v,
  });

  Geometry geometry;
  bool verified;
  DateTime createAt;
  String dataId;
  String donorName;
  int age;
  int phone;
  String bloodGroup;
  String gender;
  int id;
  int v;

  Data copyWith({
    Geometry geometry,
    bool verified,
    DateTime createAt,
    String dataId,
    String donorName,
    int age,
    int phone,
    String bloodGroup,
    String gender,
    int id,
    int v,
  }) =>
      Data(
        geometry: geometry ?? this.geometry,
        verified: verified ?? this.verified,
        createAt: createAt ?? this.createAt,
        dataId: dataId ?? this.dataId,
        donorName: donorName ?? this.donorName,
        age: age ?? this.age,
        phone: phone ?? this.phone,
        bloodGroup: bloodGroup ?? this.bloodGroup,
        gender: gender ?? this.gender,
        id: id ?? this.id,
        v: v ?? this.v,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        geometry: Geometry.fromJson(json["geometry"]),
        verified: json["verified"],
        createAt: DateTime.parse(json["createAt"]),
        dataId: json["_id"],
        donorName: json["donorName"],
        age: json["age"],
        phone: json["phone"],
        bloodGroup: json["bloodGroup"],
        gender: json["gender"],
        id: json["ID"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "geometry": geometry.toJson(),
        "verified": verified,
        "createAt": createAt.toIso8601String(),
        "_id": dataId,
        "donorName": donorName,
        "age": age,
        "phone": phone,
        "bloodGroup": bloodGroup,
        "gender": gender,
        "ID": id,
        "__v": v,
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
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}
