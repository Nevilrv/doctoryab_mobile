import 'dart:developer';

import 'package:doctor_yab/app/data/models/ads_model.dart';
import 'package:doctor_yab/app/data/models/doctors_model.dart';
import 'package:doctor_yab/app/data/repository/AdRepository.dart';
import 'package:doctor_yab/app/data/repository/DoctorsRepository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

class TabSearchController extends GetxController {
  //
  TextEditingController teSearchController = TextEditingController();
  var filterName = RxnString(null);

  //Paging
  var pagingController = PagingController<int, Doctor>(firstPageKey: 1);
  var firstSearchInit = false.obs;

  @override
  void onInit() {
    // _registerPagingListener();
    debounce(filterName, (_) {
      if (teSearchController.text.trim() != "") {
        // pagingController.error = null;
        // pagingController.itemList.clear();
        // pagingController.nextPageKey = pagingController.firstPageKey;
        _search(pagingController.firstPageKey);
        pagingController.refresh();
      } else {
        firstSearchInit(false);
      }
    });
    _fetchAds();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // pagingController.dispose();
    super.onClose();
  }

  Future<void> _search(int pageKey) async {
    print('----IS SEARCH>>>>>>');
    firstSearchInit(true);

    await DoctorsRepository.searchDoctors(pageKey, teSearchController.text,
        onError: (e) {
      pagingController.error = e;
    }).then((value) {
      print('====value====>>>>$value');

      print('===>>CONDITIOn>>>>>${value != null}');
      if (value != null) {
        print(value?.length);
        if (value.length > 0) {
          pagingController.appendPage(value, pageKey + 1);
        } else {
          pagingController.appendLastPage(value);
        }
      } else {}
    });
  }

  void _registerPagingListener() {
    pagingController.addPageRequestListener((pageKey) {
      print("call");
      _search(pageKey);
    });
  }

  List<Ad> adList = [];
  var adIndex = 0;
  void _fetchAds() {
    AdsRepository.fetchAds().then((v) {
      // AdsModel v = AdsModel();

      log('v.data  ---------->>>>>>>> ${v.data}');

      if (v.data != null) {
        v.data?.forEach((element) {
          adList.add(element);
          update();
        });
      }
    }).catchError((e, s) {
      Logger().e("message", e, s);
      Future.delayed(Duration(seconds: 3), () {
        _fetchAds();
      });
    });
  }
}
