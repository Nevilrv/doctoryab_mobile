import 'dart:async';
import 'dart:developer';
import 'dart:io' show Platform;

import 'package:doctor_yab/app/data/models/diaease_data_list_res_model.dart'
    as d;
import 'package:doctor_yab/app/data/repository/DieaseTreatmentRepository.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../../data/models/diaese_category_res_model.dart';

class DiseaseTreatmentController extends GetxController {
  List<Datum> category = [];
  Datum? selectedCategory;
  List<d.Datum> diaseaList = [];
  d.Datum? selectedDieases;

  bool isLoading = false;
  bool isLoadingList = false;

  @override
  void onInit() {
    bannerAds();
    super.onInit();
  }

  @override
  void onReady() {
    dieaseCategory();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> dieaseCategory() async {
    isLoading = true;
    DieaseTreatementRepository.getDieaseCategory().then((v) {
      isLoading = false;
      if (v.success == true) {
        category.addAll(v.data!);
        update();
      } else {
        isLoading = false;
        category = [];
      }
      // v.data.likes.forEach((element) {
      //   if(element.)
      // });
    }).catchError((e, s) {
      category = [];
      isLoading = false;
      Future.delayed(Duration(seconds: 3), () {});
    });
    update();
  }

  Future<void> dieaseDataList(String title) async {
    isLoadingList = true;
    update();
    DieaseTreatementRepository.getDieaseData(title).then((v) {
      isLoadingList = false;
      update();
      diaseaList.clear();
      if (v.data!.isNotEmpty) {
        diaseaList.addAll(v.data!);
      }
    }).catchError((e, s) {
      category = [];
      isLoadingList = false;
      update();
      Future.delayed(Duration(seconds: 3), () {});
    });
    update();
  }

  BannerAd? bannerAd;
  bool isLoadAd = false;

  bannerAds() {
    bannerAd = BannerAd(
        // size: AdSize.banner,
        size: AdSize(height: (200).round(), width: Get.width.round()),
        adUnitId: Platform.isAndroid ? Utils.bannerAdId : Utils.bannerAdIOSId,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            isLoadAd = true;
            update();
            log('Banner Ad Loaded...');
          },
          onAdFailedToLoad: (ad, error) {
            isLoadAd = false;
            update();
            log('Banner Ad failed...$error');
            ad.dispose();
          },
        ),
        request: AdRequest());
    return bannerAd!.load();
  }
}
