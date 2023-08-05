import 'package:doctor_yab/app/data/env.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AppStatics {
  static final hive = _AppHiveStatics();
  static AppEnvVars envVars = AppEnvVars();
}

class _AppHiveStatics {
  _AppHiveStatics() {
    print("HiveStatics init compelete.");
  }

  final settingsBox = Get.find<Box<dynamic>>(tag: "settings_box");
  final authBox = Get.find<Box<dynamic>>(tag: "auth_box");
}
