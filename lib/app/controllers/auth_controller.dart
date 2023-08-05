import 'dart:async';

import 'package:doctor_yab/app/data/static.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:doctor_yab/app/utils/AppGetDialog.dart';
import 'package:doctor_yab/app/utils/exception_handler/FirebaseAuthExceptionHandler.dart';
import 'package:doctor_yab/app/utils/utils.dart';
// / import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  void Function(PhoneAuthCredential phoneAuthCredential) verfiedCallBack;
  void Function(String verficationID, int resendToken) smsSentCallBack;
  void Function(FirebaseAuthException e) verificationFaildCallBck;
  void Function(Exception e) authExciptionCallBck;

  var waitingForFirebaseSmsSend = false.obs;
  var waitingForFirebaseotpToVerify = false.obs;
  var smsSent = false.obs;
  String verificationCode;
  int resendToken;

  //web
  ConfirmationResult confirmationResult;
  //hive
  // var userBox = Get.find<Box<dynamic>>(tag: "user_box");

  @override
  void onInit() {
    // firebaseAuth.setLanguageCode("en_US");

    super.onInit();
  }

  @override
  void onReady() async {
    //run every time auth state changes

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Firebase user one-time fetch
  User get getUser => firebaseAuth.currentUser;

  // Firebase user a realtime stream
  // Stream<User> get user => _auth.authStateChanges();

  // User registration using phone
  registerWithPhoneNumber(
      {@required String phoneNumber,
      void Function(PhoneAuthCredential phoneAuthCredential) verfiedCallBack,
      void Function(String verficationID, int resendToken) smsSentCallBack,
      void Function(FirebaseAuthException e) verificationFaildCallBck,
      void Function(Exception e) authExciptionCallBck,
      int resendToken}) async {
    // String intPhoneNum = "+93${phoneNumber.substring(1, 10)}";

    waitingForFirebaseSmsSend(true);
    try {
      phoneNumber = phoneNumber.toEnglishDigit();
    } catch (e) {}
    //
    try {
      firebaseAuth = FirebaseAuth.instance;
      await firebaseAuth.verifyPhoneNumber(
        forceResendingToken: resendToken,
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          UserCredential uc =
              await firebaseAuth.signInWithCredential(phoneAuthCredential);
          // Get.snackbar('Hi', "auto Signin ${firebaseAuth.currentUser.uid}");

          if (verfiedCallBack != null) {
            print("oh na nana");

            verfiedCallBack(phoneAuthCredential);
          }
          print("oh na nanana");

          // Utils.whereShouldIGo();
          print("oh na nanananan");

          _resetPhoneAuthParams();
          //
          // Get.offAllNamed(Routes.afterLoggedIn,
          //     arguments:
          //         await uc.user.getIdToken()); //TODO test exception Handle
          //
        },
        verificationFailed: (FirebaseAuthException authException) {
          Logger().e(phoneNumber,
              'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
          _resetPhoneAuthParams();
          // FirebaseAuthExceptionHandler.handle(authException);
          if (verificationFaildCallBck != null) {
            verificationFaildCallBck(authException);
          }
        },
        codeSent: (String verficationID, int resendToken) {
          Logger().i(
              "SMS-Sent",
              verficationID +
                  " " +
                  resendToken.toString() +
                  " " +
                  phoneNumber.toString());
          verificationCode = verficationID;
          this.resendToken = resendToken;
          waitingForFirebaseSmsSend(false);
          //
          if (smsSentCallBack != null)
            smsSentCallBack(verficationID, resendToken);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
          print(verificationId);
          print("Timout");
        },
        // timeout: Duration(minutes: 2),
      );
    } catch (error) {
      _resetPhoneAuthParams();
      if (authExciptionCallBck != null) authExciptionCallBck(error);
      AppGetDialog.show(middleText: error.message); //TODO
      // FirebaseAuthExceptionHandler.handle(error);
      EasyLoading.dismiss();
    }
  }

  //web
  Future<ConfirmationResult> signInWithPhoneWeb({
    @required String phoneNum,
    VoidCallback successCallBack,
    void errorCallBackWeb(dynamic e),
  }) async {
    try {
      confirmationResult = await firebaseAuth.signInWithPhoneNumber(phoneNum);
      if (successCallBack != null) successCallBack();
    } catch (e) {
      if (errorCallBackWeb != null) errorCallBackWeb(e);
      AppGetDialog.show(middleText: "web: $e");
    }
    return confirmationResult;
  }

  resendSms({
    @required String phoneNumber,
    void Function(String verficationID, int resendToken) smsSentCallBack,
    void Function(FirebaseAuthException e) verificationFaildCallBck,
    void Function(Exception e) authExciptionCallBck,
  }) {
    registerWithPhoneNumber(
      phoneNumber: phoneNumber.toEnglishDigit(),
      resendToken: resendToken,
      smsSentCallBack: smsSentCallBack,
      authExciptionCallBck: authExciptionCallBck,
      verificationFaildCallBck: verificationFaildCallBck,
    );
  }

  // Future<void> signInWithGoogle({bool forceShowAllAccounts = false}) async {
  //   EasyLoading.show();

  //   //TODO Implement [forceShowAllAccounts]
  //   var isSiginedToGoogle = await GoogleSignIn().isSignedIn();
  //   if (isSiginedToGoogle) {
  //     await GoogleSignIn().disconnect();
  //   }

  //   // Trigger the authentication flow
  //   final GoogleSignInAccount googleUser =
  //       await GoogleSignIn().signIn().whenComplete(() {
  //     print("blaaaaaaaaa");
  //   }).catchError((e) {
  //     print("Error 0xFF000000"); //network error perhabs
  //     EasyLoading.dismiss();
  //     AppGetDialog.show(
  //         middleText:
  //             "Something unexpected happend, check your internet connection and retry.\nError 0xFF000000");
  //   });

  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser?.authentication;

  //   if (googleAuth == null) {
  //     EasyLoading.dismiss();
  //     return;
  //   }
  //   // Create a new credential
  //   final GoogleAuthCredential credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );

  //   // Once signed in, return the UserCredential
  //   await firebaseAuth.signInWithCredential(credential).then((uc) {
  //     EasyLoading.dismiss();
  //     Get.offAllNamed(Routes.afterLoggedIn);
  //     print("USER ${uc.user.toString()}");
  //   }).catchError((e) {
  //     print("e3");
  //     EasyLoading.dismiss();
  //     AppGetDialog.show(
  //         middleText:
  //             "Something unExpected happend, sorry for that.\nError 0xFF000001");
  //   });
  // }

  // Future<void> signInWithFacebook() async {
  //   EasyLoading.show();
  //   // await signOut();
  //   // await FacebookAuth.instance.logOut();
  //   try {
  //     // Trigger the sign-in flow
  //     final AccessToken result = await FacebookAuth.instance.login();

  //     // Create a credential from the access token
  //     final FacebookAuthCredential facebookAuthCredential =
  //         FacebookAuthProvider.credential(result.token);

  //     // Once signed in, return the UserCredential
  //     await FirebaseAuth.instance
  //         .signInWithCredential(facebookAuthCredential)
  //         .then((uc) {
  //       EasyLoading.dismiss();
  //       Get.offAllNamed(Routes.afterLoggedIn);
  //       print("USER ${uc.user.toString()}");
  //     });
  //   } on FacebookAuthException catch (e) {
  //     EasyLoading.dismiss();
  //     FirebaseAuthExceptionHandler.handleFacebookAuthException(e);
  //   } catch (e) {
  //     EasyLoading.dismiss();
  //     AppGetDialog.show(middleText: "Unknown login error");
  //     Logger().e("unknown facebook error.");
  //   }
  // }

  // Sign out
  Future<void> signOut() async {
    // await GetStorage().erase();
    // await Get.find<Box<dynamic>>(tag: "cart_box").clear();
    // await Get.find<Box<dynamic>>(tag: "user_box").clear();
    await AppStatics.hive.authBox.clear();
    // await AppStatics.hive.settingsBox.clear();
    await firebaseAuth.signOut();

    // Utils.whereShouldIGo();
  }

  //user signined to firebase
  bool isUserSignedInedToFirebase() {
    Logger().i("user-signed-in-to-firebase", "${getUser != null}");
    print(
        "Firebase logged in: ${getUser != null}, ${FirebaseAuth.instance.currentUser}");

    return to.getUser != null;
  }

  //sign in to firebase
  signinToFirebaseWithSmsCode(
      {@required String smsCode, String verificationCode}) async {
    assert(verificationCode != null || this.verificationCode != null);
    waitingForFirebaseotpToVerify(true);
    try {
      smsCode = smsCode.toEnglishDigit();
      await firebaseAuth
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: verificationCode == null
                  ? this.verificationCode
                  : verificationCode,
              smsCode: smsCode))
          .then((value) async {
        if (value.user != null) {
          waitingForFirebaseotpToVerify(false);
          // Get.snackbar('Done', 'verfyied by sms. User id: ${value.user.uid}');
          // Get.offAllNamed(Routes.SPLASH);
          // Get.reset();
          // Utils.restartApp();
          if (this.verfiedCallBack == null) {
            Utils.whereShouldIGo();
          } else {
            this.verfiedCallBack(value.credential);
          }
          // GetStorage().write("firebase_auth_complete", true);
          EasyLoading.dismiss();
          // AppGetDialog.show(middleText: "verfied");

        }
      });
    } catch (e) {
      waitingForFirebaseotpToVerify(false);
      if (e is FirebaseAuthException) {
        FirebaseAuthExceptionHandler.handle(e);
        return;
      }
      Get.snackbar('No', e.runtimeType.toString() + " " + e.message);
    }
  }

  String getUserPhoneNumber({NUMBER_TYPE numberType}) {
    User user = getUser;
    assert(user != null);

    return numberType == NUMBER_TYPE.INTERNATIONAL
        ? user.phoneNumber
        // : "0" + user.phoneNumber.substring(3, 12);
        : "0" +
            user.phoneNumber.replaceFirst(AppStatics.envVars.countryCode, "");
  }

  // Future<void> saveUserToken(String token) async {
  //   await GetStorage().write("UerToken", token).catchError((e) {
  //     Logger().d("Get-storage-write-error", e.message);
  //   });
  // }

  // Future<void> saveUserId(String id) async {
  //   await GetStorage().write("UserId", id).catchError((e) {
  //     Logger().d("Get-storage-write-error", e.message);
  //   });
  // }

  // Future<String> getUserToken() async {
  //   return await GetStorage().read("UerToken");
  // }

  // getUserId() async {
  //   return GetStorage().read("UserId");
  // }

  // Future<void> setProfileCompleted(bool val) async {
  //   await GetStorage().write("ProfileComplete", val).catchError((e) {
  //     Logger().d("Get-storage-write-error", e.message);
  //   });
  // }

  // Future<bool> isProfileComplete() async {
  //   return await GetStorage().read("ProfileComplete") == true;
  // }

  // //hive user

  // UserDetailsApi getHiveUserDetails() {
  //   var boxMap = userBox.toMap();
  //   // Logger().d(boxMap, "user_box");
  //   var result =
  //       UserDetailsApi.fromJson(Map<String, dynamic>.from(boxMap["data"]));
  //   // Logger().d(result.toJson(), "test_user_box_result");
  //   return result;
  // }

  // void updateUserDetails(UserDetailsApi responseModel) {
  //   userBox.put("data", responseModel.toJson());
  //   getHiveUserDetails();
  // }

  // Future<void> setCity(Datum city) async {
  //   if (city == null)
  //     await GetStorage().remove("city");
  //   else
  //     await GetStorage().write("city", city.toJson());
  //   Logger().d(city.toJson(), "city_changed");
  // }

  // Datum getCity() {
  //   // Logger().d(GetStorage().read("city"), "requested_for_city");
  //   return GetStorage().read("city") != null
  //       ? Datum.fromJson(GetStorage().read("city"))
  //       : null;
  // }

  // void setAppLanguge(String l) async {
  //   await GetStorage().write("languge", l);
  // }

  // String getAppLanguge() {
  //   return GetStorage().read("languge");
  // }
  //
  updatePhoneNumber(
      {@required String phoneNumber,
      void Function(PhoneAuthCredential phoneAuthCredential) verfiedCallBack,
      void Function(String verficationID, int resendToken) smsSentCallBack,
      void Function(FirebaseAuthException e) verificationFaildCallBck,
      void Function(Exception e) authExciptionCallBck,
      int resendToken}) {
    //*
    this.verfiedCallBack = verfiedCallBack;

    registerWithPhoneNumber(
      phoneNumber: phoneNumber,
      verfiedCallBack: (phoneCredential) {
        FirebaseAuth.instance.currentUser.updatePhoneNumber(phoneCredential);
        if (verfiedCallBack != null) verfiedCallBack(phoneCredential);
      },
      verificationFaildCallBck: (e) => FirebaseAuthExceptionHandler.handle(e),
      smsSentCallBack: smsSentCallBack,
      authExciptionCallBck: authExciptionCallBck,
    );
  }

  _resetPhoneAuthParams() {
    waitingForFirebaseSmsSend.value = false;
    waitingForFirebaseotpToVerify.value = false;
    smsSent = false.obs;
    verificationCode = null;
    // resendToken = null;
    this.verfiedCallBack = null;
  }
}

enum NUMBER_TYPE { LOCAL, INTERNATIONAL }