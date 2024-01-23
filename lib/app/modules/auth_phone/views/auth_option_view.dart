import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:doctor_yab/app/components/SpecialAppBackground.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:doctor_yab/app/data/models/user_model.dart' as u;
import 'dart:io' show Platform;
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../data/models/city_model.dart';
import '../../../data/repository/AuthRepository.dart';
import '../../../utils/utils.dart';
import '../controllers/auth_phone_controller.dart';
import 'dart:math' as math;

class AuthView extends GetView<AuthPhoneController> {
  AuthPhoneController controller = Get.put(AuthPhoneController());

  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('AuthPhoneView'),
      //   centerTitle: true,
      // ),
      body: Obx(() {
        return SpecialAppBackground(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Spacer(),
              // Hero(
              //     tag: "doctor_svg",
              //     child: SvgPicture.asset("assets/svg/d2.svg")),
              // SizedBox(height: 20),
              Text(
                'sign_in'.tr,
                style: AppTextTheme.h1().copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Text(
                'sign_description'.tr,
                style: AppTextTheme.r(15).copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),

              controller.isLoading.value == true
                  ? Center(
                      child: CircularProgressIndicator(
                      color: AppColors.white,
                    ))
                  : GestureDetector(
                      onTap: () {
                        controller.signInWithGoogle(context);
                      },
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(AppImages.google),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "sign_google".tr,
                                style: AppTextTheme.b(16)
                                    .copyWith(color: AppColors.primary),
                              ),
                            ],
                          )),
                        ),
                      ),
                    ),

              Platform.isAndroid
                  ? SizedBox()
                  : SizedBox(
                      height: 20,
                    ),
              Platform.isAndroid
                  ? SizedBox()
                  : GestureDetector(
                      onTap: () async {
                        final _firebaseAuth = FirebaseAuth.instance;
                        try {
                          // final AuthorizationResult result =
                          //     await AppleSignIn.performRequests([
                          //   AppleIdRequest(requestedScopes: [
                          //     Scope.email,
                          //     Scope.fullName
                          //   ])
                          // ]);
                          // final appleIdCredential = result.credential;
                          // final oAuthProvider = OAuthProvider("apple.com");
                          // final credential = oAuthProvider.credential(
                          //   idToken: String.fromCharCodes(
                          //       appleIdCredential.identityToken),
                          //   accessToken: String.fromCharCodes(
                          //       appleIdCredential.authorizationCode),
                          // );

                          final rawNonce = generateNonce();
                          final nonce = sha256ofString(rawNonce);

                          final appleCredential =
                              await SignInWithApple.getAppleIDCredential(
                            scopes: [
                              AppleIDAuthorizationScopes.email,
                              AppleIDAuthorizationScopes.fullName,
                            ],
                            nonce: nonce,
                          );
                          // Create an `OAuthCredential` from the credential returned by Apple.
                          final oauthCredential =
                              OAuthProvider("apple.com").credential(
                            idToken: appleCredential.identityToken,
                            rawNonce: rawNonce,
                          );
                          // Sign in the user with Firebase. If the nonce we generated earlier does
                          // not match the nonce in `appleCredential.identityToken`, sign in will fail.
                          final authResult = await _firebaseAuth
                              .signInWithCredential(oauthCredential);

                          if (authResult.credential != null) {
                            try {
                              AuthRepository()
                                  .signInWithGAppleApi(oauthCredential.idToken)
                                  .then((value) {
                                var reponseData = value.data;

                                SettingsController.userToken =
                                    reponseData["jwtoken"];
                                dev.log(
                                    "SettingsController.userToken--------------> ${SettingsController.userToken}");
                                SettingsController.userProfileComplete =
                                    reponseData["profile_completed"];
                                dev.log(
                                    "SettingsController.userProfileComplete--------------> ${reponseData["profile_completed"]}");
                                SettingsController.userId =
                                    reponseData['user'] == null
                                        ? reponseData['newUser']['_id']
                                        : reponseData['user']['_id'];
                                dev.log(
                                    "SettingsController.SettingsController.userId--------------> ${SettingsController.userId}");

                                dev.log(
                                    "SettingsController.userToken--------------> ${SettingsController.userToken}");

                                try {
                                  SettingsController.savedUserProfile =
                                      u.User.fromJson(
                                          reponseData['user'] == null
                                              ? reponseData['newUser']
                                              : reponseData['user']);
                                  if (SettingsController
                                          .isUserProfileComplete ==
                                      false) {
                                    Get.toNamed(Routes.ADD_PERSONAL_INFO);
                                  } else {
                                    SettingsController.auth.savedCity =
                                        City.fromJson(reponseData['city']);
                                    SettingsController.userLogin = true;
                                    Get.offAllNamed(Routes.HOME);
                                  }
                                  dev.log(
                                      "SettingsController.savedUserProfile.sId--------------> ${SettingsController.savedUserProfile.id}");
                                } catch (e) {
                                  Utils.commonSnackbar(
                                      context: context,
                                      text: "Apple login failed");
                                  dev.log("e--------------> ${e}");
                                }
                                dev.log(
                                    "SettingsController.savedUserProfile.sId--------------> ${SettingsController.userId}");

                                dev.log("value--------------> ${value}");
                              });
                            } catch (e) {
                              Utils.commonSnackbar(
                                  context: context, text: "Apple login failed");
                            }
                          }

                          dev.log(
                              "credential.idToken/----------------------------->${oauthCredential.idToken}");
                          // switch (result.status) {
                          //   case AuthorizationStatus.authorized:
                          //     print(result
                          //         .credential.user); //All the required credentials
                          //   case AuthorizationStatus.error:
                          //     print(
                          //         "Sign in failed: ${result.error.localizedDescription}");
                          //     break;
                          //   case AuthorizationStatus.cancelled:
                          //     print('User cancelled');
                          //     break;
                          // }
                        } on FirebaseAuthException catch (e) {
                          Utils.commonSnackbar(
                              context: context, text: e.message);
                        }
                      },
                      child: Container(
                        width: Get.width,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(AppImages.appleLogin),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "sign_Apple".tr,
                                style: AppTextTheme.b(16)
                                    .copyWith(color: AppColors.primary),
                              ),
                            ],
                          )),
                        ),
                      ),
                    ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.REGISTER_GUEST_USER);
                },
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppImages.userCircle),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "guest_user".tr,
                          style: AppTextTheme.b(16)
                              .copyWith(color: AppColors.primary),
                        ),
                      ],
                    )),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.AUTH_PHONE);
                },
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SettingsController.appLanguge != "English"
                            ? Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(math.pi),
                                child: SvgPicture.asset(AppImages.phone,
                                    color: AppColors.primary),
                              )
                            : SvgPicture.asset(AppImages.phone,
                                color: AppColors.primary),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "sign_phone".tr,
                          style: AppTextTheme.b(16)
                              .copyWith(color: AppColors.primary),
                        ),
                      ],
                    )),
                  ),
                ),
              ),

              // SizedBox(
              //   height: 20,
              // ),
              // Container(
              //   width: Get.width,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(5),
              //       color: Colors.white),
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 10),
              //     child: Center(
              //         child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         SvgPicture.asset(AppImages.facebook),
              //         SizedBox(
              //           width: 5,
              //         ),
              //         Text(
              //           "sign_Facebook".tr,
              //           style: AppTextTheme.b(16)
              //               .copyWith(color: AppColors.primary),
              //         ),
              //       ],
              //     )),
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Container(
              //   width: Get.width,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(5),
              //       color: Colors.white),
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 10),
              //     child: Center(
              //         child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         SvgPicture.asset(AppImages.facebook),
              //         SizedBox(
              //           width: 5,
              //         ),
              //         Text(
              //           "sign_Apple".tr,
              //           style: AppTextTheme.b(16)
              //               .copyWith(color: AppColors.primary),
              //         ),
              //       ],
              //     )),
              //   ),
              // ),
              Spacer(),
            ],
          ).paddingSymmetric(horizontal: 20),
        );
      }),
    );
  }
}
