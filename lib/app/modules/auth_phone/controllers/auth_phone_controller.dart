import 'dart:developer';

import 'package:doctor_yab/app/controllers/auth_controller.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/city_model.dart';
import 'package:doctor_yab/app/data/repository/AuthRepository.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/services/DioService.dart';
import 'package:doctor_yab/app/utils/PhoneNumberValidator.dart';
import 'package:doctor_yab/app/utils/exception_handler/FirebaseAuthExceptionHandler.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:doctor_yab/app/data/models/user_model.dart' as u;

class AuthPhoneController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController teNewNumber = TextEditingController();
  TextEditingController teAge = TextEditingController();
  TextEditingController teName = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var phoneValid = false.obs;
  var phoneValidationError = "".obs;
  var locations = <City>[].obs;

  var _cachedDio = AppDioService.getCachedDio;

  var selectedLocation = "".obs;
  var genderList = ['Male', "Female", "Other"];
  var selectedGender = "Male".obs;
  GoogleSignIn googleSignIn = GoogleSignIn();
  @override
  void onInit() {
    // loadCities();
    ever(phoneValid, (_) {
      //
      if (phoneValid()) Get.focusScope.unfocus();
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  //* City Load
  Future<dynamic> loadCities() async {
    final response = await _cachedDio.get(
      ApiConsts.cityPath,
      queryParameters: {
        "limit": '20000',
        "page": '1',
      },
      options: AppDioService.cachedDioOption(ApiConsts.defaultHttpCacheAge),
    );
    log("response--------------> ${response.data}");
    if (response.data['data'] != null) {
      response.data['data'].forEach((element) {
        locations.add(City.fromJson(element));
      });
    }
    log("response--------------> ${locations.length}");

    return response;
  }

  void verfyPhoneNumber(String number) {
    try {
      number = number.toEnglishDigit();
    } catch (e) {}
    PhoneValidatorUtils phoneValidatorUtils =
        PhoneValidatorUtils(number: number);
    phoneValid(phoneValidatorUtils.isValid());
    phoneValidationError(phoneValidatorUtils.errorMessage);
    phoneValidatorUtils = null;
  }

  signInWithPhone() {
    Get.focusScope.unfocus();
    // SettingsController.setAppLanguage(
    //     controller.selectedLang());
    var _phoneNum =
        Utils.changeAfgNumberToIntlFormat(textEditingController.text);
    if (GetPlatform.isWeb) {
      EasyLoading.show(status: "please_wait".tr);
      AuthController.to.signInWithPhoneWeb(
          phoneNum: _phoneNum,
          successCallBack: () {
            EasyLoading.dismiss();
            Get.toNamed(
              Routes.AUTH_OTP,
              arguments: textEditingController.text,
            );
          },
          errorCallBackWeb: (e) {
            EasyLoading.dismiss();
          });
    } else {
      EasyLoading.show(status: "please_wait".tr);
      AuthController.to.registerWithPhoneNumber(
        verfiedCallBack: (_) {
          EasyLoading.dismiss();
          // Get.reset(
          //   clearFactory: false,
          //   clearRouteBindings: false,
          // );
          Utils.whereShouldIGo();
        },
        phoneNumber: _phoneNum,
        smsSentCallBack: (_, __) {
          EasyLoading.dismiss();
          Get.toNamed(
            Routes.AUTH_OTP,
            arguments: textEditingController.text,
          );
        },
        // verificationFaildCallBck: (_) => AppGetDialog.show(
        //   middleText: "failed_to_send_otp".tr,
        // ),
        verificationFaildCallBck: (e) => FirebaseAuthExceptionHandler.handle(e),
      );
    }
  }

  Future<String> signInWithGoogle() async {
    UserCredential authResult;

    AuthCredential credential;

    try {
      // googleSignIn.currentUser!.clearAuthCache();
      googleSignIn.signOut();

      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      print(
          'GoogleSignInAccount>> ${GoogleSignInAccount.kFailedToRecoverAuthError}');

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      // final userCredential =
      //     await FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
      // log("userCredential${userCredential}");
      authResult = await FirebaseAuth.instance.signInWithCredential(credential);

      final User currentUser = FirebaseAuth.instance.currentUser;

      log('ACCESSTOKEN :- ${googleSignInAuthentication.accessToken}');

      log('CREDINTILA :- ${googleSignInAuthentication.idToken}');

      if (googleSignInAuthentication.idToken != null) {
        AuthRepository()
            .signInWithGoogleFacebboklApi(googleSignInAuthentication.idToken)
            .then((value) {
          var reponseData = value.data;
          // print(reponseData);
          SettingsController.userToken = reponseData["jwtoken"];
          SettingsController.userProfileComplete =
              reponseData["profile_completed"];
          SettingsController.userId = reponseData['user']['_id'];

          try {
            SettingsController.savedUserProfile =
                u.User.fromJson(reponseData['user']);
            log("SettingsController.savedUserProfile.sId--------------> ${SettingsController.savedUserProfile.id}");
          } catch (e) {
            log("e--------------> ${e}");
          }
          log("SettingsController.savedUserProfile.sId--------------> ${SettingsController.userId}");

          Utils.whereShouldIGo();
          log("value--------------> ${value}");
        });
      }
      log('token ID:- ${authResult.credential.token}');
      log('token ID:- ${currentUser.uid}');
      log('PROVIDER ID:- ${authResult.credential.providerId}');
    } catch (e) {
      print('ERROR-----$e');
      print('hrllo');

      // commonSnackbar(message: 'Try Again', title: 'ERROR');
      // Get.snackbar('ERROR', '$e');
    }
    return null;
  }
}
