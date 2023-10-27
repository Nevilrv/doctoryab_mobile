import 'package:doctor_yab/app/data/models/city_model.dart';
import 'package:doctor_yab/app/data/models/drug_database_model.dart';
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
    if (_dbLang != null && _dbLang is String) {
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
  static final drugAuth = _DrugSaved();
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
    return AppStatics.hive.authBox.get("user_token");
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

  static bool get isUserLoggedInToApi {
    return userToken != null;
  }

  static User get savedUserProfile {
    var _user = AppStatics.hive.authBox.get("user");

    return _user == null
        ? null
        : User.fromJson(
            Map<String, dynamic>.from(
              AppStatics.hive.authBox.get("user"),
            ),
          );
    // if (AppStatics.hive.settingsBox.get("user") == null) return null;
    // return User.fromJson(
    //   Map<String, dynamic>.from(
    //     AppStatics.hive.settingsBox.get("user"),
    //   ),
    // );
  }

  static set savedUserProfile(User user) {
    AppStatics.hive.authBox.put("user", user.toJson());
  }
}

class _AuthSettings {
  // _AuthSettings();
  City get savedCity {
    var _city = AppStatics.hive.authBox.get("city");
    return _city == null
        ? null
        : City.fromJson(
            Map<String, dynamic>.from(
              AppStatics.hive.authBox.get("city"),
            ),
          );
  }

  set savedCity(City city) {
    AppStatics.hive.authBox.put("city", city.toJson());
  }
}

class _DrugSaved {
  List<Datum> get drugData {
    var _drug = AppStatics.hive.authBox.get("drug");
    List<Datum> data = _drug == null
        ? []
        : List<Datum>.from(_drug.map((x) => Datum.fromJson(x)));
    print('==data==>${data.length}');
    return data;
  }

  set drugData(List<Datum> drugItem) {
    print('==drugData===111===>${drugData}');

    if (drugData == null || drugData.isEmpty) {
      AppStatics.hive.authBox.put("drug", [drugItem.first.toJson()]);

      print('==drugData===IF===>${drugData}');
    } else {
      List drugDataList = List<dynamic>.from(drugData.map((x) => x.toJson()));

      drugDataList.add(drugItem.first.toJson());

      AppStatics.hive.authBox.put("drug", drugDataList);

      print('==drugData===ELSE===>${drugData}');
    }
  }
}
