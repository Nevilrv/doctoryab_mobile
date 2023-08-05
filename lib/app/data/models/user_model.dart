class User {
  String sId;
  String phone;
  String createAt;
  String photo;
  String name;
  String patientID;
  int age;

  User({sId, phone, createAt, photo, name, age, patientID});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    phone = json['phone'];
    createAt = json['createAt'];
    photo = json['photo'];
    name = json['name'];
    age = json['age'];
    patientID = json['patientID'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['phone'] = phone;
    data['createAt'] = createAt;
    data['photo'] = photo;
    data['name'] = name;
    data['age'] = age;
    data['patientID'] = patientID;
    return data;
  }
}
