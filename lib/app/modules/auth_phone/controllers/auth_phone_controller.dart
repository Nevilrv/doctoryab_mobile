import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:doctor_yab/app/controllers/auth_controller.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/city_model.dart';
import 'package:doctor_yab/app/data/models/user_model.dart' as u;
import 'package:doctor_yab/app/data/repository/AuthRepository.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/services/DioService.dart';
import 'package:doctor_yab/app/utils/PhoneNumberValidator.dart';
import 'package:doctor_yab/app/utils/exception_handler/FirebaseAuthExceptionHandler.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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
  var isLoading = false.obs;

  @override
  void onInit() {
    // loadCities();
    ever(phoneValid, (_) {
      //
      if (phoneValid()) Get.focusScope!.unfocus();
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

    if (response.data['data'] != null) {
      response.data['data'].forEach((element) {
        locations.add(City.fromJson(element));
      });
    }

    return response;
  }

  void verfyPhoneNumber(String? number) {
    try {
      number = number!.toEnglishDigit();
    } catch (e) {}
    PhoneValidatorUtils? phoneValidatorUtils = PhoneValidatorUtils(number: number!);
    phoneValid(phoneValidatorUtils.isValid());
    phoneValidationError(phoneValidatorUtils.errorMessage);
    phoneValidatorUtils = null;
  }

  signInWithPhone() {
    Get.focusScope!.unfocus();
    // SettingsController.setAppLanguage(
    //     controller.selectedLang());
    var _phoneNum = Utils.changeAfgNumberToIntlFormat(textEditingController.text);
    if (GetPlatform.isWeb) {
      // EasyLoading.show(status: "please_wait".tr, indicator: CircularProgressIndicator(color: Colors.white));

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
      // EasyLoading.show(status: "please_wait".tr, indicator: CircularProgressIndicator(color: Colors.white));

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

  Future<String?> signInWithGoogle(BuildContext context) async {
    UserCredential authResult;

    AuthCredential credential;
    isLoading.value = true;

    // try {
    // googleSignIn.currentUser!.clearAuthCache();
    await googleSignIn.signOut();

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    log('GoogleSignInAccount :::::::::::::::: ${googleSignInAccount}');
    if (GoogleSignInAccount.kFailedToRecoverAuthError.toString() == 'failed_to_recover_auth') {
      isLoading.value = false;
    }

    log('GoogleSignInAccount kFailedToRecoverAuthError :::::::::::::::::::::: ${GoogleSignInAccount.kFailedToRecoverAuthError}');
    final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;
    log('googleSignInAuthentication Access Token 111 :::::::::::::::::::::: ${googleSignInAuthentication?.accessToken}');
    log('googleSignInAuthentication Id Token 2222 :::::::::::::::::::::: ${googleSignInAuthentication?.idToken}');

    credential =
        GoogleAuthProvider.credential(accessToken: googleSignInAuthentication?.accessToken, idToken: googleSignInAuthentication?.idToken);

    log('googleSignInAuthentication Credential :::::::::::::::::::::: ${credential}');

    // final userCredential =
    //     await FirebaseAuth.instance.currentUser?.linkWithCredential(credential);

    authResult = await FirebaseAuth.instance.signInWithCredential(credential);

    log('authResult ::::::::::::::- ${authResult}');

    final User? currentUser = FirebaseAuth.instance.currentUser;

    log('Current User ::::::::::::::- ${currentUser}');
    log('ACCESSTOKEN ::::::::::::::- ${googleSignInAuthentication?.accessToken}');

    log('googleSignInAuthentication idToken :::::::::::::::- ${googleSignInAuthentication?.idToken}');

    if (googleSignInAuthentication?.idToken != null) {
      try {
        AuthRepository().signInWithGoogleFacebboklApi(googleSignInAuthentication?.idToken ?? "").then((value) {
          var reponseData = value.data;

          SettingsController.userToken = reponseData["jwtoken"];

          SettingsController.userProfileComplete = reponseData["profile_completed"] == null ? false : true;

          SettingsController.userId = reponseData['user'] == null ? reponseData['newUser']['_id'] : reponseData['user']['_id'];

          isLoading.value = false;
          try {
            SettingsController.savedUserProfile =
                u.User.fromJson(reponseData['user'] == null ? reponseData['newUser'] : reponseData['user']);
            if (SettingsController.isUserProfileComplete == false) {
              Get.toNamed(Routes.ADD_PERSONAL_INFO);
            } else {
              SettingsController.auth.savedCity = City.fromJson(reponseData['city']);
              SettingsController.userLogin = true;
              Get.offAllNamed(Routes.HOME);
            }
          } catch (e) {
            Utils.commonSnackbar(context: context, text: "Google login failed");
          }
        });
      } catch (e) {
        Utils.commonSnackbar(context: context, text: "Google login failed");
        isLoading.value = false;
      }
    }

    // }
    // catch (e) {
    //   Utils.commonSnackbar(context: context, text: e);
    //   isLoading.value = false;
    //   log('ERROR-----$e');
    //   print('hrllo');
    //
    //   // commonSnackbar(message: 'Try Again', title: 'ERROR');
    //   // Get.snackbar('ERROR', '$e');
    // }
    return null;
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

// Future<void> signInWithApple() async {
//   try {
//     final rawNonce = generateNonce();
//     final nonce = sha256ofString(rawNonce);
//     // Request credential for the currently signed in Apple account.
//     final appleCredential = await SignInWithApple.getAppleIDCredential(
//       scopes: [
//         AppleIDAuthorizationScopes.email,
//         AppleIDAu
//         thorizationScopes.fullName,
//       ],
//       nonce: nonce,
//     );
//     if (appleCredential.givenName != null) {
//       // SharedPrefs().setAppleIdName(
//       //     forAppleId: '${appleCredential.userIdentifier}',
//       //     email: appleCredential.givenName!);
//     }
//     if (appleCredential.email != null) {
//       // SharedPrefs().setAppleIdEmail(
//       //     forAppleId: '${appleCredential.userIdentifier}',
//       //     email: appleCredential.email!);
//     }
//
//     // String email = await SharedPrefs()
//     //     .getAppleIdEmail(forAppleId: '${appleCredential.userIdentifier}');
//     // String name = await SharedPrefs()
//     //     .getAppleIdName(forAppleId: '${appleCredential.userIdentifier}');
//     if (appleCredential.userIdentifier != null) {
//       // socialLogin(
//       //     'apple', appleCredential.userIdentifier!, name ?? "", email ?? "");
//     }
//   } catch (e) {
//     // Loader.dismiss();
//   }
// }
}
