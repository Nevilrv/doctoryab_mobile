// class User {
//   String sId;
//   String phone;
//   String createAt;
//   String photo;
//   String name;
//   String patientID;
//
//   int age;
//
//   User({sId, phone, createAt, photo, name, age, patientID});
//
//   User.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     phone = json['phone'];
//     createAt = json['createAt'];
//     photo = json['photo'];
//     name = json['name'];
//     age = json['age'];
//     patientID = json['patientID'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['phone'] = phone;
//     data['createAt'] = createAt;
//     data['photo'] = photo;
//     data['name'] = name;
//     data['age'] = age;
//     data['patientID'] = patientID;
//     return data;
//   }
// }
class User {
  Geometry geometry;
  String photo;
  String id;
  String email;
  String name;
  String language;
  String fcm;
  String createAt;
  String patientID;
  String gender;
  String phone;
  int v;
  int age;

  User({
    this.geometry,
    this.photo,
    this.id,
    this.email,
    this.phone,
    this.name,
    this.language,
    this.fcm,
    this.createAt,
    this.patientID,
    this.gender,
    this.v,
    this.age,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(Map<String, dynamic>.from(json["geometry"])),
        photo: json["photo"],
        id: json["_id"],
        email: json["email"],
        name: json["name"],
        language: json["language"],
        fcm: json["fcm"],
        phone: json["phone"],
        createAt: json["createAt"],
        patientID: json["patientID"],
        gender: json["gender"],
        v: json["__v"],
        age: json["age"],
      );

  Map<String, dynamic> toJson() => {
        "geometry": geometry.toJson(),
        "photo": photo,
        "_id": id,
        "email": email,
        "language": language,
        "fcm": fcm,
        "name": name,
        "phone": phone,
        "createAt": createAt,
        "patientID": patientID,
        "gender": gender,
        "__v": v,
        "age": age,
      };
}

class Geometry {
  String type;
  List<double> coordinates;

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
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}
