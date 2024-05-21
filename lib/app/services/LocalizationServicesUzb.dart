import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/lang/en_US.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../lang/ru_ru.dart';
import '../lang/uz_UZ.dart';

class LocalizationServiceUzb extends Translations {
  // Default locale
  static final defaultLocale = Locale('en', 'US');
  // static final locale = Locale('en', 'US');
  Locale get locale {
    return _getLocaleFromLanguage(SettingsController.appLanguge);
  }

  // fallbackLocale saves the day when the locale gets in trouble
  static final fallbackLocale = Locale('en', 'US');

  // Supported languages
  // Needs to be same order with locales
  static final langs = [
    'English',
    'Ўзбекча',
    'Русский',
    //'فارسی', 'پشتو'
  ];

  // Supported locales
  // Needs to be same order with langs
  static final locales = [
    Locale('en', 'US'),
    Locale('uz', 'UZ'),
    Locale('ru', 'RU'),
    // Locale('fa', 'IR'),
    // Locale('ps', 'AF'),
  ];

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        // 'fa_IR': faIR,
        "uz_UZ": uzUZ,
        'ru_RU': ruRU,
        // 'ps_AF': psAF,
      };

  // Gets locale from language, and updates the locale
  Locale changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
    Jiffy.setLocale(Get.locale!.languageCode);
    // Jiffy.locale(Get.locale.languageCode);
    return locale;
  }

  // Finds language in `langs` list and returns it as Locale
  Locale _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return defaultLocale;
  }

  //Find the short local code for API, Ex: name_en":"Category 2","name_dr":"کتگوری 2","name_ps":"2 کتکوری"
  static String getShortLocalCodeForApi() {
    String code = "";
    String getLocalCode = Get.locale!.languageCode;
    if (getLocalCode == "en")
      code = "en";
    else if (getLocalCode == "fa")
      code = "da";
    else if (getLocalCode == "ps") code = "ps";

    return code;
  }

  String standardLandguageCode() {
    var formated = Get.locale!.languageCode.toLowerCase() +
        "_" +
        Get.locale!.countryCode!.toUpperCase();
    print(formated);
    return formated;
  }
}
