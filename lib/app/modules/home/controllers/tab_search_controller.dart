import 'package:doctor_yab/app/data/models/doctors_model.dart';
import 'package:doctor_yab/app/data/repository/DoctorsRepository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TabSearchController extends GetxController {
  //
  TextEditingController teSearchController = TextEditingController();
  var filterName = RxString(null);

  //Paging
  var pagingController = PagingController<int, Doctor>(firstPageKey: 1);
  var firstSearchInit = false.obs;

  @override
  void onInit() {
    _registerPagingListener();
    debounce(filterName, (_) {
      if (teSearchController.text.trim() != "") {
        pagingController.error = null;
        pagingController.itemList = null;
        pagingController.nextPageKey = pagingController.firstPageKey;
        _search(pagingController.firstPageKey);
        print("refresh");
        pagingController.refresh();
      } else {
        firstSearchInit(false);
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }

  void _search(int pageKey) {
    firstSearchInit(true);

    DoctorsRepository.searchDoctors(pageKey, teSearchController.text,
        onError: (e) {
      pagingController.error = e;
    }).then((value) {
      if (value != null) {
        print(value?.length);
        if (value.length > 0) {
          pagingController.appendPage(value, pageKey + 1);
        } else {
          pagingController.appendLastPage(value);
        }
      } else {
        //TODO handle this case
      }
    });
  }

  void _registerPagingListener() {
    pagingController.addPageRequestListener((pageKey) {
      print("call");
      _search(pageKey);
    });
  }
}
