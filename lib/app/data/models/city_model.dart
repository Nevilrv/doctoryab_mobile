import 'package:get/get.dart';

class City {
  String? sId;
  bool? isDeleted;
  String? fName;
  String? eName;
  String? pName;
  String? rName;
  String? uName;
  int? iV;

  City({
    this.sId,
    this.isDeleted,
    this.fName,
    this.eName,
    this.pName,
    this.rName,
    this.uName,
    this.iV,
  });

  City.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isDeleted = json['is_deleted'];
    fName = json['f_name'] ?? "";
    pName = json['p_name'] ?? "";
    eName = json['e_name'] ?? "";
    rName = json['r_name'] ?? "";
    uName = json['u_name'] ?? "";
    iV = json['__v'];
  }
  String? getMultiLangName() {
    if (Get.locale!.languageCode == "fa") return this.fName;
    if (Get.locale!.languageCode == "ps") return this.pName;
    if (Get.locale!.languageCode == "uz") return this.uName;
    if (Get.locale!.languageCode == "ru") return this.rName;

    return this.eName;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['is_deleted'] = isDeleted;
    data['f_name'] = fName;
    data['e_name'] = eName;
    data['p_name'] = pName;
    data['r_name'] = rName;
    data['u_name'] = uName;
    data['__v'] = iV;
    return data;
  }
}
