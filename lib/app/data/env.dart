import 'package:flutter/material.dart';

enum AppEnvType { UZB, PROD, DEV }

class AppEnvVars {
  final AppEnvType appEnvType = AppEnvType.DEV;

  /// Test Server

  final String apiURL = "https://testserver.doctoryab.app/";

  /// Almost Server

  // final String apiURL = "https://server.doctoryab.app";
  final String countryCode = "+93";
  final String appName = "DoctorYab";
  final String phoneNumberPattern = r'^07[7,6,2,3,8,9,0,1,4][0-9]{7}';

  final langs = ['English', 'فارسی', 'پشتو'];
  final locales = [Locale('en', 'US'), Locale('fa', 'IR'), Locale('ps', 'AF')];
  final defaultLocale = Locale('fa', 'IR');

  bool get isUzbekApp => this.appEnvType == AppEnvType.UZB;
}

class DevEnvVars extends AppEnvVars {
  @override
  final AppEnvType appEnvType = AppEnvType.DEV;
  @override

  /// Test Server
  final String apiURL = "https://testserver.doctoryab.app";

  /// Live Server
  // final String apiURL = "https://server.doctoryab.app";

  /// Almost Server
  // final String apiURL = "https://almost-server.doctoryab.app";
}

class UzbEnvVars extends AppEnvVars {
  @override
  final AppEnvType appEnvType = AppEnvType.UZB;
  @override
  final String apiURL = "https://demoserver.doctoryab.app/";
  @override
  final String phoneNumberPattern = r'^099[0-9]{7}';
  @override
  final String countryCode = "+998";
  @override
  final String appName = "Sogliq";

  @override
  final langs = ['English', 'Ozbekcha', 'Русский'];
  @override
  final locales = [Locale('en', 'US'), Locale('uz', 'UZ'), Locale('ru', 'RU')];
  @override
  final defaultLocale = Locale('en', 'US');
}
