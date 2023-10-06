import 'dart:convert';
import 'dart:io';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppFonts.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:dio/dio.dart';
import 'package:doctor_yab/app/components/statefull_wraper.dart';
import 'package:doctor_yab/app/controllers/auth_controller.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/models/HospitalsModel.dart';
import 'package:doctor_yab/app/data/models/drug_stores_model.dart';
import 'package:doctor_yab/app/data/models/histories.dart';
import 'package:doctor_yab/app/data/models/labs_model.dart';
import 'package:doctor_yab/app/data/models/reports.dart';
import 'package:doctor_yab/app/data/repository/AuthRepository.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/utils/PhoneNumberValidator.dart';
import 'package:doctor_yab/app/utils/exception_handler/DioExceptionHandler.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide Response;
import 'package:hive/hive.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/ApiConsts.dart';
import '../data/models/blog_categories.dart';
import '../data/models/blood_donors.dart';
import '../data/models/chat_list_api_model.dart' hide User;
import '../data/models/chat_model.dart';
import '../data/models/post.dart';
import '../data/models/user_model.dart';
import '../data/static.dart';

class Utils {
  static Widget initBuilder(BuildContext context, Widget widget) {
    return EasyLoading.init()(context, widget);
  }

  static changeAfgNumberToIntlFormat(String number) {
    assert(number.length == 10);
    return "${AppStatics.envVars.countryCode}${number.substring(1, 10)}";
  }

  static void configEasyLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.red
      ..backgroundColor = Colors.transparent
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..maskColor = Colors.black.withOpacity(0.7)
      ..userInteractions = false
      ..maskType = EasyLoadingMaskType.custom
      ..dismissOnTap = false;
  }

  static void whereShouldIGo({bool updateProfile = true}) {
    // FbAuth.FirebaseAuth.instance.authStateChanges().listen((user) {
    //   print('Current user id: ${user?.uid}');
    // });
    if (!AuthController.to.isUserSignedInedToFirebase()) {
      if (!SettingsController.isAppLanguageSet) {
        Get.offAllNamed(Routes.INTRO);
        return;
      }
      Get.offAllNamed(Routes.AUTH_PHONE);
      return;
    } else {
      print("Fb Auth Current User id:  ${AuthController.to.getUser.uid}");
    }
    //
    if (!SettingsController.isUserLoggedInToApi) {
      Get.offAllNamed(Routes.LOGIN_VERIFY);
      return;
    }
    if (!SettingsController.isUserProfileComplete) {
      Get.offAllNamed(Routes.PROFILE_UPDATE);
      return;
    }
    if (SettingsController.auth.savedCity == null) {
      Get.offAllNamed(Routes.CITY_SELECT);
      return;
    }
    if (updateProfile) {
      _updateProfile();
    } else {
      if (Get.currentRoute == Routes.HOME) {
        Get.offAllNamed(AppPages.INITIAL);
      } else {
        //! Fix bug, not sure how
        // Get.reset();
        Get.offAllNamed(Routes.afterLoggedIn);
      }

      return;
    }
  }

  //TODO move this to a service
  static _updateProfile() {
    AuthRepository().fetchProfile().then((response) {
      var _user = User.fromJson(response.data["data"]);
      SettingsController.savedUserProfile = _user;
      whereShouldIGo(updateProfile: false);
    }).catchError((e, s) {
      if (SettingsController.savedUserProfile != null) {
        whereShouldIGo(updateProfile: false);
      } else {
        DioExceptionHandler.handleException(
          exception: e,
          retryCallBak: () => _updateProfile(),
        );
      }
      FirebaseCrashlytics.instance.recordError(e, s);
    });
  }
  // static bool isColorValid(String s) {
  //   Pattern pattern = r'^#[0-9A-F]{6}$/';
  //   RegExp regex = new RegExp(pattern);
  //   return regex.hasMatch(s);
  // }

  static Color hexToColor(String hex, {Color defaultColorIfInvalid}) {
    ////////////
    int _getColorFromHex(String hexColor) {
      hexColor = hexColor.toUpperCase().replaceAll("#", "");
      if (hexColor.length == 6) {
        hexColor = "FF" + hexColor;
      }
      return int.tryParse(hexColor, radix: 16);
    }
    ///////////

    // if (isColorValid(hex)) {
    return Color(_getColorFromHex(hex) ?? defaultColorIfInvalid.value);
    // }
    // return defaultColorIfInvalid;
  }

  static openPhoneDialer(BuildContext context, String number) {
    try {
      number = number.toEnglishDigit();
      print("Call $number");
    } catch (e) {}
    final Uri _emailLaunchUri = Uri(
      scheme: 'tel',
      path: number,
    );
    launch(_emailLaunchUri.toString()).onError((error, stackTrace) {
      ScaffoldMessenger.of(Get.context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
          ),
        ),
      );

      return;
    });
  }

  static Future<List<T>> parseResponse<T>(Future<Response<dynamic>> func(),
      {void onError(e)}) async {
    List<dynamic> _tmpList;
    try {
      var response = await func();
      //TODO move all this to some genric utils func
      // List<dynamic> _data = response.data['data'];
      var _data = response.data;
      if (_data == null) return <T>[]; //TODO take care of this

      switch (T) {
        case History:
          {
            // print("dddddddd\n");
            // print(_data.map((e) => History.fromJson(e)).toList());
            // _tmpList = _data.map((e) => History.fromJson(e)).toList();
            // break;
            // print("dddddddd\n");
            // print(_data.map((e) => History.fromJson(e)).toList());
            _tmpList = Histories.fromJson(_data).data;
            break;
          }
        case Report:
          {
            _tmpList = Reports.fromJson(_data).data;
            break;
          }
        case Hospital:
          {
            _tmpList = HospitalsModel.fromJson(_data).data;
            break;
          }
        case DrugStore:
          {
            _tmpList = DrugStoresModel.fromJson(_data).data;
            break;
          }
        case Labs:
          {
            _tmpList = LabsModel.fromJson(_data).data;
            break;
          }
        case BloodDonor:
          {
            _tmpList = BloodDonors.fromJson(_data).bloodDonors;
            break;
          }
        case BlogCategory:
          {
            _tmpList = BlogCategories.fromJson(_data).data;
            break;
          }
        case Post:
          {
            _tmpList = PostModel.fromJson(_data).data;
            break;
          }
        case ChatListApiModel:
          {
            _tmpList = chatListApiModelFromJson(jsonEncode(_data));
            break;
          }
        case ChatApiModel:
          {
            _tmpList = chatApiModelFromJson(jsonEncode(_data));
            break;
          }
      }
    } catch (e, s) {
      if (onError != null) {
        Logger().e("Network-parser-error", e, s);

        if (e is DioError) {
          if (!CancelToken.isCancel(e)) {
            onError(e);
          } //make sure not collecting error of canceling dio requests
        } else {
          onError(e);
        }
      }
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    print("tmp-list is empty: ${_tmpList == null}");
    return _tmpList;
  }

  static void addResponseToPagingController<T>(
      List<T> list, PagingController<int, T> pagingController, int pageKey) {
    if (list != null) {
      if (list.length > 0) {
        pagingController.appendPage(list, pageKey + 1);
      } else {
        pagingController.appendLastPage(list);
      }
    }
  }

  static String ageValidatore(String value, {int minAge, int maxAge}) {
    try {
      value = value.toEnglishDigit();
    } catch (e) {}

    if (!value.isNum) return "not_a_valid_number".tr;

    if (int.tryParse(value) < (minAge ?? 0)) {
      return "must_be_greater_than".trArgs(['${minAge ?? 0}']);
      // nameValid.value = false;
    }
    if (int.tryParse(value) > (maxAge ?? 120)) {
      if (maxAge != null) assert(maxAge > 0);
      return "must_be_less_than".trArgs(['${maxAge ?? 120}']);
      // nameValid.value = false;
    }
    return null;
  }

  static String numberValidator(String value) {
    try {
      value = value.toEnglishDigit();
    } catch (e) {}
    PhoneValidatorUtils phoneValidatorUtils =
        PhoneValidatorUtils(number: value);
    if (phoneValidatorUtils.isValid()) {
      return null;
    }
    return phoneValidatorUtils.errorMessage;
    // phoneValidatorUtils = null;
  }

  static String nameValidator(String value) {
    if (value.length < 5) {
      return "too_short_min_5".tr;
      // nameValid.value = false;
    } else if (value.length > 30) {
      return "very_long_max_30".tr;
    }
    return null;
  }

  static void restartApp() {
    // Get.reset();
    // Get.appUpdate();
    // Get.forceAppUpdate();
    //
    //
    //

    // Phoenix.rebirth(Get.context);
  }
  static void showSnackBar(BuildContext context, String s) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));
  }

  static String getTextOfBlaBla(int type) {
    switch (type) {
      case 2:
        {
          return " " + "doctor".tr;
        }
      case 1:
        {
          return " " + "hospital".tr;
        }
      default:
        {
          return " " + "";
        }
    }
  }

  //* Google Maps
  static openGoogleMaps(double lat, double lng) async {
    final String googleMapslocationUrl =
        "https://www.google.com/maps/search/?api=1&query=$lat,$lng";

    final String encodedURl = Uri.encodeFull(googleMapslocationUrl);

    try {
      await launch(encodedURl);
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      showSnackBar(Get.context, "please_install_google_maps".tr);
      throw 'Could not launch $encodedURl';
    }
  }

  static Future<void> restartBeta(BuildContext context,
      {VoidCallback onInit}) async {
    // Phoenix.rebirth(context);
    // Get.find<GetMaterialApp>();
    Get.reset();
    Get.reloadAll(force: true);
    await Utils.initApp();
    if (onInit != null) {
      onInit();
    }
    // Phoenix.rebirth(context);

    // Get.reloadAll(force: true);

    // Get.reloadAll(force: true);

    // Get.offAllNamed(Routes.SPLASH_SCREEN);
    Get.offAll(() => EmptyStateFullWraper(SizedBox()));
    // .then((value) {

    // Utils.whereShouldIGo();

    // });
    // Get.offAllNamed(Routes.afterLoggedIn);
    Utils.whereShouldIGo();
  }

  static Future<void> initApp() async {
    Get.put(AuthController());
    var _authBox = await Hive.openBox('auth');
    var _settingsBox = await Hive.openBox('settings');
    Get.put<Box<dynamic>>(_settingsBox, tag: "settings_box");
    Get.put<Box<dynamic>>(_authBox, tag: "auth_box");

    Get.put(GlobalKey<NavigatorState>());
    // if (kDebugMode || ApiConsts.debugModeOnRelease) {
    //   Get.put(
    //     Alice(
    //       showNotification: true,
    //       navigatorKey: Get.find(),
    //       darkTheme: false,
    //       directionality: TextDirection.ltr,
    //     ),
    //   );
    // }

    // var getMApp = ;
    // Get.put(getMApp);
  }

  static void closeApp() {
    exit(0);
  }

  static void resetPagingController(PagingController controller) {
    controller.error = null;
    controller.itemList = null;
    controller.nextPageKey = controller.firstPageKey;
    // log("leent ${controller.itemList.length}");
  }

  static String getFullPathOfAssets(String path) {
    return "${ApiConsts.hostUrl}$path";
  }

  static Widget searchBox() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      padding: EdgeInsets.only(top: 13, bottom: 22, left: 17, right: 17),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "hi_text".tr,
                    style: AppTextStyle.mediumWhite11,
                  ),
                  Text(
                    "how_do_you_feel".tr,
                    style: AppTextStyle.mediumWhite11.copyWith(
                      color: AppColors.white.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset(
                    AppImages.bell,
                    height: 22,
                    width: 22,
                  ),
                  Positioned(
                    right: 2,
                    top: 2,
                    child: CircleAvatar(
                      backgroundColor: AppColors.red2,
                      radius: 4,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 10, left: 8),
                child: Image.asset(
                  AppImages.filter,
                  height: 22,
                  width: 22,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          TextField(
            style: AppTextStyle.mediumWhite11,
            cursorColor: AppColors.white,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15),
              hintText: "search_doctor".tr,
              hintStyle: AppTextStyle.mediumWhite11,
              suffixIcon: Padding(
                padding: const EdgeInsets.all(11),
                child: SvgPicture.asset(AppImages.search),
              ),
              filled: true,
              fillColor: AppColors.white.withOpacity(0.1),
              constraints: BoxConstraints(maxHeight: 38),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: AppColors.lightWhite,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: AppColors.lightWhite,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: AppColors.lightWhite,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static PreferredSizeWidget appBar({String title, bool savedIcon = false}) {
    return AppBar(
      backgroundColor: AppColors.lightGrey,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.primary,
        ),
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: AppTextStyle.boldPrimary20,
      ),
      centerTitle: true,
      actions: [
        savedIcon
            ? GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.SAVED_DRUGS);
                },
                child: Icon(
                  Icons.bookmark_border_rounded,
                  color: AppColors.primary,
                ),
              )
            : SizedBox(),
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 10),
          child: SvgPicture.asset(
            AppImages.blackBell,
            height: 24,
            width: 24,
          ),
        ),
      ],
    );
  }
}
