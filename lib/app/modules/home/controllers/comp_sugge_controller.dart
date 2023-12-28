import 'dart:developer';
import 'dart:io' as Io;

import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/repository/AuthRepository.dart';
import 'package:doctor_yab/app/utils/AppGetDialog.dart';
import 'package:doctor_yab/app/utils/exception_handler/DioExceptionHandler.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ComplaintSuggestionController extends GetxController {
  TextEditingController cTitle = TextEditingController();
  TextEditingController cDesc = TextEditingController();
  TextEditingController sTitle = TextEditingController();
  TextEditingController sDesc = TextEditingController();
  bool loading = false;
  Rx<Io.File> image = Io.File("").obs;
  final picker = ImagePicker();
  complaintApi(BuildContext context) {
    loading = true;
    AuthRepository()
        .complaintApi(title: cTitle.text, desc: cDesc.text)
        .then((value) {
      cTitle.clear();
      cDesc.clear();
      var responseData = value.data;
      String id = responseData['data']['_id'];

      if (image.value.path.isNotEmpty) {
        AuthRepository()
            .complaintImageApi(image: image.value, id: id)
            .then((value) {
          print("image>>>>value>>>>>>>>>>>>${value}");
          Get.back();
          Utils.commonSnackbar(
              text: "Complaint successfully uploaded", context: context);
        });
      } else {
        Get.back();
        Utils.commonSnackbar(
            text: "Complaint successfully uploaded", context: context);
      }

      log("value--------------> ${value}");
    }).catchError((e, s) {
      loading = false;
      DioExceptionHandler.handleException(
          //TODO not tesetd yet
          exception: e,
          retryCallBak: () {
            // complaintApi(context);
          });
      FirebaseCrashlytics.instance.recordError(e, s);
    });
  }

  suggestionApi(BuildContext context) {
    loading = true;
    AuthRepository()
        .suggestionApi(title: cTitle.text, desc: cDesc.text)
        .then((value) {
      sTitle.clear();
      sDesc.clear();

      var responseData = value.data;
      String id = responseData['data']['_id'];

      if (image.value.path.isNotEmpty) {
        AuthRepository()
            .suggestionImageApi(image: image.value, id: id)
            .then((value) {
          print("image>>>>value>>>>>>>>>>>>${value}");
          Get.back();
          Utils.commonSnackbar(
              text: "Suggestion successfully uploaded", context: context);
        });
      } else {
        Utils.commonSnackbar(
            text: "Suggestion successfully uploaded", context: context);
        Get.back();
      }

      log("value--------------> ${value}");
    }).catchError((e, s) {
      loading = false;
      DioExceptionHandler.handleException(
          //TODO not tesetd yet
          exception: e,
          retryCallBak: () {});
      // waitingForUpload(false);
      // AppGetDialog.show(middleText: e.message.toString());
      FirebaseCrashlytics.instance.recordError(e, s);
    });
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
        AppGetDialog.show(middleText: "max_file_limit_is_5MB".tr);
        // lastImageError.value = "max_file_limit_is_5MB".tr;

        return;
      }

      image.value = croppedFile;
    } else {}
    update();
  }
}
