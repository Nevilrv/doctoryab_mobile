import 'dart:io' as Io;

import 'package:doctor_yab/app/controllers/auth_controller.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/user_model.dart';
import 'package:doctor_yab/app/data/repository/AuthRepository.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/utils/AppGetDialog.dart';
import 'package:doctor_yab/app/utils/exception_handler/DioExceptionHandler.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../data/static.dart';

class ProfileUpdateController extends GetxController {
  //TODO this user must be rx and must be in global
  var user = SettingsController.savedUserProfile;
  var imagePicked = false.obs;
  Rx<Io.File> image = Io.File("").obs;
  final picker = ImagePicker();
  var isUploadingImage = false.obs;
  var uploadProgress = 0.0.obs;
  var lastUploadedImagePath = "".obs;
  var uploadHadError = false.obs;
  //*
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var formValid = false.obs;

  //*text Edtings
  TextEditingController teName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController teAge = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController teNewNumber = TextEditingController();

  @override
  void onInit() {
    ever(image, (_) {
      uploadImage();
    });

    super.onInit();
  }

  @override
  void onReady() {
    teName.text = user?.name?.toString() ?? "";
    teAge.text = user?.age?.toString() ?? "";
    teNewNumber.text = AuthController.to.getUser.phoneNumber
            .replaceFirst(AppStatics.envVars.countryCode, "0") ??
        "";
    // formKey = GlobalKey<FormState>();
    super.onReady();
  }

  @override
  void onClose() {}

  void uploadImage() {
    isUploadingImage(true);
    // if (isUpdateType && imagedPicked.value != true) {
    //   updateName(null);
    //   return;
    // }
    AuthRepository().updateImage(image.value, (pr) {
      uploadProgress.value = pr / 100;
    }).then((value) {
      var response = value.data;
      if (response["success"]) {
        resetUploadProgress();
        // SettingsController.userProfileComplete = true;
        // lastUploadedImagePath.value = response["name"];
        lastUploadedImagePath.value = image.value.path.toString();

        if (SettingsController.savedUserProfile?.photo != null) {
          User _user = SettingsController.savedUserProfile;
          _user.photo = response["name"];
          SettingsController.savedUserProfile = _user;
        }
      } else {
        AppGetDialog.show(middleText: response["message"].toString());
      }
      // TODO Not Tested Yet
    }).catchError((e, s) {
      DioExceptionHandler.handleException(
        exception: e,
        retryCallBak: uploadImage,
      );
      resetUploadProgress();
      uploadHadError(true);
      // AppGetDialog.show(middleText: e.message.toString());
      FirebaseCrashlytics.instance.recordError(e, s);
    });
  }

  void updateProfile() {
    var _newIntlNumber = Utils.changeAfgNumberToIntlFormat(teNewNumber.text);
    try {
      _newIntlNumber = _newIntlNumber.toEnglishDigit();
    } catch (e) {}
    _updateApi({String authToken}) {
      AuthRepository()
          .updateProfile(
              teName.text, int.tryParse(teAge.text?.toEnglishDigit()),
              firebaseUserToken: authToken)
          .then((value) {
        try {
          User user = User.fromJson(value.data["data"]);
          SettingsController.savedUserProfile = user;
          // print(SettingsController.savedUserProfile.toJson());
          SettingsController.userProfileComplete = true;
          Utils.whereShouldIGo();
        } catch (e, s) {
          //TODO handle
          Logger().e(e.toString());
          FirebaseCrashlytics.instance.recordError(e, s);
        }

        // print(Map.of(response["data"])?.runtimeType);
        EasyLoading.dismiss();
      }).catchError((e, s) {
        DioExceptionHandler.handleException(
            //TODO not tesetd yet
            exception: e,
            retryCallBak: () {
              updateProfile();
            });
        // waitingForUpload(false);
        // AppGetDialog.show(middleText: e.message.toString());
        FirebaseCrashlytics.instance.recordError(e, s);
      });
    }

    if (_newIntlNumber != AuthController.to.getUser.phoneNumber) {
      // if(AuthController.to.firebaseAuth.app. ){

      // }
      // cheack if can change number to this number
      EasyLoading.show(status: "please_wait".tr);
      AuthRepository.numberExists(teNewNumber.text).then((value) {
        if (value) {
          EasyLoading.dismiss();
          AppGetDialog.show(middleText: "user_with_same_number_exists".tr);
        } else {
          AuthController.to.updatePhoneNumber(
            phoneNumber: _newIntlNumber,
            smsSentCallBack: (_, __) {
              EasyLoading.dismiss();
              Get.toNamed(
                Routes.AUTH_OTP,
                arguments: teNewNumber.text,
              );
            },
            verfiedCallBack: (phoneAuthCredential) async {
              // EasyLoading.dismiss();
              EasyLoading.show(status: "please_wait".tr);
              //TODO critical, Make sure this happens even if net disconnected
              _updateApi(
                authToken: await AuthController.to.firebaseAuth.currentUser
                    .getIdToken(),
              );
            },
          );
        }
      });
    } else {
      _updateApi();
    }

    EasyLoading.show(status: "please_wait".tr);
  }

  void pickImage() async {
    //TODO handle exception
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      Io.File pickedFileAsFile = Io.File(pickedFile.path);

      //* To resize the image if it lags comment from here
      // Plugin.Image tmpImg =
      //     Plugin.decodeImage(pickedFileAsFile.readAsBytesSync());

      // // Resize the image to a 120x? thumbnail (maintaining the aspect ratio).
      // Plugin.Image thumbnail = Plugin.copyResize(tmpImg, width: 512);

      // // Save the thumbnail as a PNG.
      // File(pickedFileAsFile.path)
      //   ..writeAsBytesSync(Plugin.encodePng(thumbnail));
      //*till here

      //*Image Croper start
      Io.File croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFileAsFile.path,
        maxWidth: 512,
        maxHeight: 512,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'cropper'.tr,
          toolbarColor: Get.theme.primaryColor,
          toolbarWidgetColor: Colors.white,
          activeControlsWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
          aspectRatioLockEnabled: true,
        ),
      );
      //*Image Croper End
      //file size limit
      // var pickedFileSize = await pickedFileAsFile.length() / 1024; //In KB
      var pickedFileSize = await croppedFile.length() / 1024; //In KB
      // AppGetDialog.show(middleText: pickedFileSize.toString());
      if (pickedFileSize > ApiConsts.maxImageSizeLimit) {
        imagePicked(false);
        AppGetDialog.show(middleText: "max_file_limit_is_5MB".tr);
        // lastImageError.value = "max_file_limit_is_5MB".tr;

        return;
      }

      image.value = croppedFile;
      imagePicked(true);
    } else {
      imagePicked(false);
    }
  }

  void resetUploadProgress() {
    uploadProgress.value = 0.0;
    isUploadingImage.value = false;
    uploadHadError = false.obs;
  }

  //*
  void validateForm() {
    formValid(formKey.currentState.validate());
    print(formKey.currentState.validate());
  }
}
