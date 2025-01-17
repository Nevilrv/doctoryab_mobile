import 'package:doctor_yab/app/data/models/city_model.dart';
import 'package:doctor_yab/app/data/models/drug_database_updated_model.dart';
import 'package:doctor_yab/app/data/models/user_model.dart';
import 'package:doctor_yab/app/data/static.dart';
import 'package:doctor_yab/app/services/LocalizationServices.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  //*language
  static bool get isAppLanguageSet {
    return AppStatics.hive.settingsBox.get("lang") != null;
  }

  static String get appLanguge {
    //['English', 'فارسی', 'پشتو']
    var _dbLang = AppStatics.hive.settingsBox.get("lang")?.toString();
    if (_dbLang != null) {
      if (LocalizationService.langs.contains(_dbLang)) {
        return _dbLang;
      }
    }
    print("app_lang $_dbLang");
    return "فارسی";
  }

  static set appLanguge(String lang) {
    AppStatics.hive.settingsBox.put('lang', lang);
    // print(AppStatics.hive.settingsBox.get("lang"));
    LocalizationService().changeLocale(lang);
  }

  //* Auth
  static final auth = _AuthSettings();
  // static final drugAuth = _DrugSaved();
  //*old way
  static bool get isUserProfileComplete {
    //TODO make sure the saved value to database is bool and show error if patched
    return AppStatics.hive.authBox.get("profile_complete") == null
        ? false
        : AppStatics.hive.authBox.get("profile_complete");
  }

  static set userProfileComplete(bool flag) {
    AppStatics.hive.authBox.put('profile_complete', flag);
  }

  static String get userToken {
    return AppStatics.hive.authBox.get("user_token") ?? "";
  }

  static set setToken(String s) {
    AppStatics.hive.authBox.put('new_jwt', s);
  }

  static String get getToken {
    return AppStatics.hive.authBox.get("new_jwt");
  }

  static set userToken(String s) {
    AppStatics.hive.authBox.put("user_token", s);
  }

  static String get userId {
    return AppStatics.hive.authBox.get("user_id");
  }

  static set userId(String s) {
    AppStatics.hive.authBox.put("user_id", s);
  }

  static bool get userLoginGet {
    if (isUserLoggedInToApi) {
      return true;

      //patch update from version 2 to 3.0
      // SettingsController
    }
    if (AppStatics.hive.authBox.get("user_Login") == null) return false;

    print("-------------------> isUserLoggedInToApi $isUserLoggedInToApi");

    return AppStatics.hive.authBox.get("user_Login") == null ? false : true;
  }

  static set userLogin(bool s) {
    AppStatics.hive.authBox.put("user_Login", s);
  }

  static bool get isUserLoggedInToApi {
    return userToken == "" ? false : true;
  }

  static User? get savedUserProfile {
    var _user = AppStatics.hive.authBox.get("user");

    //patch update from version 2 to 3.0
    // SettingsController
    if (isUserLoggedInToApi) {
      // var _u = User()
    }

    return _user == null
        ? null
        : User.fromJson(
            Map<String, dynamic>.from(
              AppStatics.hive.authBox.get("user"),
            ),
          );
  }

  static set savedUserProfile(User? user) {
    AppStatics.hive.authBox.put("user", user!.toJson());
  }

  // static List<Datum> get drugData {
  //   var _drug = AppStatics.hive.authBox.get("drug");
  //   List<Datum> data = _drug == null
  //       ? []
  //       : List<Datum>.from(_drug
  //           .map((x) => Datum.fromJson(Map<String, dynamic>.from(x as Map))));
  //   return data;
  // }

  static List<UpdatedDrug> get getUpdatedDrugData {
    var _drug = AppStatics.hive.authBox.get("drug");
    List<UpdatedDrug> data = _drug == null
        ? []
        : List<UpdatedDrug>.from(_drug.map(
            (x) => UpdatedDrug.fromJson(Map<String, dynamic>.from(x as Map))));
    return data;
  }

  // static set drugData(List<Datum> drugItem) {
  //   if (drugData == null || drugData.isEmpty) {
  //     AppStatics.hive.authBox.put("drug", [drugItem.first.toJson()]);
  //   } else {
  //     List drugDataList =
  //         List<Map<String, dynamic>>.from(drugData.map((x) => x.toJson()));
  //
  //     int selectedIndex =
  //         drugData.indexWhere((element) => element.id == drugItem.first.id);
  //
  //     if (selectedIndex < 0) {
  //       drugDataList.add(drugItem.first.toJson());
  //     } else {
  //       drugDataList.removeAt(selectedIndex);
  //     }
  //     AppStatics.hive.authBox.put("drug", drugDataList);
  //   }
  // }

  static set updatedDrugData(List<UpdatedDrug> drugItem) {
    if (getUpdatedDrugData == null || getUpdatedDrugData.isEmpty) {
      AppStatics.hive.authBox.put("drug", [drugItem.first.toJson()]);
    } else {
      List drugDataList = List<Map<String, dynamic>>.from(
          getUpdatedDrugData.map((x) => x.toJson()));

      int selectedIndex = getUpdatedDrugData
          .indexWhere((element) => element.id == drugItem.first.id);

      if (selectedIndex < 0) {
        drugDataList.add(drugItem.first.toJson());
      } else {
        drugDataList.removeAt(selectedIndex);
      }
      AppStatics.hive.authBox.put("drug", drugDataList);
    }
  }
}

class _AuthSettings {
  // _AuthSettings();
  City? get savedCity {
    var _city = AppStatics.hive.authBox.get("city");
    return _city == null
        ? City()
        : City.fromJson(
            Map<String, dynamic>.from(
              AppStatics.hive.authBox.get("city"),
            ),
          );
  }

  set savedCity(City? city) {
    AppStatics.hive.authBox.put("city", city?.toJson());
  }
}
