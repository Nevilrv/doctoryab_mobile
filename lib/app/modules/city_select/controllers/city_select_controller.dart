import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/models/city_model.dart';
import 'package:doctor_yab/app/data/repository/LocationRepository.dart';
import 'package:doctor_yab/app/utils/AppGetDialog.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

class CitySelectController extends GetxController {
  var selectedCity = City().obs;
  var selectedCityItem = City().obs;
  var pagedController = PagingController<int, City>(firstPageKey: 1);

  _fetchCities(pageKey) {
    LocationRepository().loadCities(pageKey).then((data) {
      ///////////////
      if (data != null) {
        if (data.data["data"] == null) {
          data.data["data"] = [];
        }
        var newItems = <City>[];
        data.data["data"].forEach((item) {
          newItems.add(City.fromJson(item));
        });
        if (newItems == null || newItems.length == 0) {
          pagedController.appendLastPage(newItems);
        } else {
          var itt = pagedController.itemList != null
              ? newItems
                  .where(
                    (element) =>
                        // !(_pagedController.itemList.contains(element)),
                        !pagedController.itemList
                            .any((el) => element.sId == el.sId),
                  )
                  .toList()
              : newItems;
          pagedController.appendPage(itt, pageKey + 1);
        }
        // values.addAll( City.fromJson(data.data["data"]));
        // print(data.value.success);
      } else {}
    }).catchError((e, s) {
      //close loading dialog
      pagedController.error = e;
      if (e is FirebaseException) {
        var _eCode = (e).code;
        if (_eCode != null) {
          AppGetDialog.show(middleText: _eCode);
        }
      }

      Logger().d("Error", e, s);
      FirebaseCrashlytics.instance.recordError(e, s);
    });
  }

  @override
  void onInit() {
    pagedController.addPageRequestListener((pageKey) {
      _fetchCities(pageKey);
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void cityChanged(City city) {
    selectedCity(city);
  }

  void confirmSelectedCity() {
    SettingsController.auth.savedCity = selectedCity();
    Utils.whereShouldIGo();
  }
}
