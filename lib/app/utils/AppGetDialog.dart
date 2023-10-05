import 'package:doctor_yab/app/components/buttons/custom_rounded_button.dart';
import 'package:doctor_yab/app/components/paging_indicators/no_item_list.dart';
import 'package:doctor_yab/app/components/paging_indicators/paging_error_view.dart';
import 'package:doctor_yab/app/components/shimmer/city_shimmer.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/models/categories_model.dart';
import 'package:doctor_yab/app/data/models/city_model.dart';
import 'package:doctor_yab/app/data/models/doctors_model.dart';
import 'package:doctor_yab/app/data/repository/CategoriesRepository.dart';
import 'package:doctor_yab/app/data/repository/LocationRepository.dart';
import 'package:doctor_yab/app/modules/home/controllers/home_controller.dart';
import 'package:doctor_yab/app/services/LocalizationServices.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

enum DialogType { ERROR, DONE, QUESTION, MESSAGE }

class AppGetDialog {
  static show({
    String title,
    String mainButtonText,
    String middleText,
    List<Widget> actions,
    Widget component,
    bool hasOnlyContent = false, //TODO this is bad way, use child instead
  }) {
    title = title == null ? "error".tr : title;
    return Get.defaultDialog(
      backgroundColor: AppColors.scaffoldColor,
      title: hasOnlyContent ? '' : title,
      // titleStyle: TextStyle(color: AppColors.lgt1),
      titleStyle: hasOnlyContent ? TextStyle(fontSize: 1) : TextStyle(),
      middleText: hasOnlyContent ? '' : middleText,
      radius: 10,
      content: hasOnlyContent ? component : null,
      actions: actions == null || actions.isEmpty || hasOnlyContent
          ? <Widget>[]
          : actions,
      confirm: hasOnlyContent
          ? Container()
          : TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                mainButtonText != null ? mainButtonText : "got_it".tr,
                style: TextStyle(
                  color: Get.theme.primaryColor,
                ),
              ),
            ),

      // cancel: Text("OK"),
    );
  }

  static showSuccess({@required String middleText, VoidCallback onTap}) {
    show(
        hasOnlyContent: true,
        component: Column(
          children: [
            Image.asset(
              'assets/png/verify.png',
              height: 68,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              middleText,
              textAlign: TextAlign.center,
              style: AppTextTheme.b2(),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 70,
              child: Center(
                child: CustomRoundedButton(
                  color: AppColors.easternBlue,
                  textColor: Colors.white,
                  splashColor: Colors.white.withOpacity(0.2),
                  disabledColor: AppColors.easternBlue.withOpacity(0.2),
                  // height: 50,
                  width: 230,
                  text: "done".tr,
                  onTap: onTap ??
                      () {
                        // Get.offAllNamed(Routes.HOME);

                        Get.until((route) => route.isFirst);
                        Get.find<HomeController>().pageController.animateTo(2,
                            duration: Duration(milliseconds: 0),
                            curve: Curves.ease);
                        Get.find<HomeController>().setIndex(2);
                      },
                ),
              ),
            ).paddingOnly(bottom: 0, top: 8),
          ],
        ));
  }

  static showWithRetryCallBack(
      {@required String middleText,
      Function retryCallBak,
      String operationTitle,
      String retryButtonText}) {
    show(
      hasOnlyContent: false,
      middleText: operationTitle == null
          ? middleText
          : "while".tr + " " + operationTitle + " " + middleText,
      actions: retryCallBak == null
          ? <Widget>[]
          : <Widget>[
              TextButton(
                child: Text(
                  "retry".tr,
                  style: TextStyle(
                    color: Get.theme.primaryColor,
                  ),
                ),
                onPressed: () {
                  Get.back();
                  retryCallBak();
                },
              ),
            ],
    );
  }

  //* City Select dialog
  static showSelctCityDialog(
      {bool restartApp = false,
      cityChangedCallBack(City city),
      bool saveInstantlyAfterClick = true}) {
    // var values = <City>[].obs;
    // var currentCity = AuthController.to.getCity();
    // var currentCityId = currentCity == null ? "" : currentCity.id;
    var _pagedController = PagingController<int, City>(firstPageKey: 1);

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
            _pagedController.appendLastPage(newItems);
          } else {
            var itt = _pagedController.itemList != null
                ? newItems
                    .where(
                      (element) =>
                          // !(_pagedController.itemList.contains(element)),
                          !_pagedController.itemList
                              .any((el) => element.sId == el.sId),
                    )
                    .toList()
                : newItems;
            _pagedController.appendPage(itt, pageKey + 1);
          }
          // values.addAll( City.fromJson(data.data["data"]));
          // print(data.value.success);
        } else {}
      }).catchError((e, s) {
        //close loading dialog
        _pagedController.error = e;
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

    _pagedController.addPageRequestListener((pageKey) {
      _fetchCities(pageKey);
    });

    Get.defaultDialog(
        title: "select_city".tr,
        content: Container(
          height: 250,
          width: 260,
          child: Scrollbar(
            thumbVisibility: true,
            child: PagedListView.separated(
              separatorBuilder: (c, i) {
                return SizedBox(height: 4);
              },
              pagingController: _pagedController,
              physics: BouncingScrollPhysics(),
              builderDelegate: PagedChildBuilderDelegate<City>(
                itemBuilder: (context, item, index) {
                  // var item = controller.latestVideos[index];
                  return ListTile(
                    // title: Center(child: Text(city.getMultiLangName())),
                    title: Center(child: Text(item.getMultiLangName())),
                    // leading: Icon(Icons.language),
                    onTap: () {
                      Get.back();
                      // print(city.getMultiLangName() + " " + city.id);
                      // AuthController.to.setCity(city);
                      if (saveInstantlyAfterClick)
                        SettingsController.auth.savedCity = item;
                      // print("dddddddd ${SettingsController.auth.savedCityId}");
                      if (cityChangedCallBack != null)
                        cityChangedCallBack(item);
                      if (restartApp)
                        Phoenix.rebirth(Get.context); //TODO Fix this
                    },
                    // trailing: currentCityId == city.id
                    //     ? Icon(Icons.done)
                    //     : Container(
                    //         height: 0,
                    //         width: 0,
                  );
                },
                // noMoreItemsIndicatorBuilder: (_) => PagingNoMoreItemList(),
                noItemsFoundIndicatorBuilder: (_) => PagingNoItemFountList(),
                firstPageErrorIndicatorBuilder: (context) => PagingErrorView(
                  controller: _pagedController,
                ),
                firstPageProgressIndicatorBuilder: (_) => CityShimmer(
                  linesCount: 4,
                ),
                newPageProgressIndicatorBuilder: (_) => CityShimmer(
                  linesCount: 2,
                ),
              ),
            ),
          ),
        ));
  }

  //*
  static showSeleceDoctorCategoryDialog(
    Doctor doctor, {
    onChange(Category category),
  }) {
    var _pagedController = PagingController<int, Category>(firstPageKey: 1);
    _fetchData(pageKey) {
      CategoriesRepository.categoryByDoctor(
        pageKey,
        doctor,
        onError: (e) {
          _pagedController.error = e;
        },
      ).then((data) {
        if (data != null) {
          if (data == null || data.length == 0) {
            _pagedController.appendLastPage(data);
          } else {
            _pagedController.appendPage(data, pageKey + 1);
          }
        } else {}
      });
    }

    _pagedController.addPageRequestListener((pageKey) {
      _fetchData(pageKey);
    });

    Get.defaultDialog(
        title: "select_category".tr,
        content: Container(
          height: 250,
          width: 200,
          child: PagedListView.separated(
            separatorBuilder: (c, i) {
              return SizedBox(height: 4);
            },
            pagingController: _pagedController,
            physics: BouncingScrollPhysics(),
            builderDelegate: PagedChildBuilderDelegate<Category>(
              itemBuilder: (context, item, index) {
                // var item = controller.latestVideos[index];
                return ListTile(
                  title: Center(child: Text(item.title ?? "")),
                  onTap: () {
                    Get.back();
                    if (onChange != null) onChange(item);
                  },
                );
              },
              // noMoreItemsIndicatorBuilder: (_) => PagingNoMoreItemList(),
              noItemsFoundIndicatorBuilder: (_) => PagingNoItemFountList(),
              firstPageErrorIndicatorBuilder: (context) => PagingErrorView(
                controller: _pagedController,
              ),
              firstPageProgressIndicatorBuilder: (_) => CityShimmer(
                linesCount: 4,
              ),
              newPageProgressIndicatorBuilder: (_) => CityShimmer(
                linesCount: 2,
              ),
            ),
          ),
        ));
  }

  static showFilterDialog(List<String> filterList, String currentSelected,
      {void filterCallBack(String v)}) {
    // var dummyList = ['most_rated'.tr, 'suggested'.tr, 'nearest'.tr, 'A-Z'];
    Get.defaultDialog(
      title: 'filter'.tr,
      content: Column(
        children: [
          SizedBox(height: 15),
          Column(
              children: filterList.map((l) {
            return Column(
              children: [
                ListTile(
                    title: Text(l).paddingSymmetric(horizontal: 16),
                    // leading: Icon(Icons.language),
                    onTap: () {
                      Get.back();
                      if (filterCallBack != null) filterCallBack(l);
                    },
                    trailing: Opacity(
                        opacity:
                            (currentSelected != null && l == currentSelected)
                                ? 1
                                : 0,
                        child: Icon(Icons.check))),
                Divider(),
              ],
            );
          }).toList()),
        ],
      ),
    );
  }

  static showChangeLangDialog({langChangedCallBack(String languge)}) {
    Get.defaultDialog(
      title: "change_language".tr,
      content: Column(
        children: [
          SizedBox(height: 15),
          Column(
              children: LocalizationService.langs.map((l) {
            return Column(
              children: [
                ListTile(
                  title: Center(child: Text(l)),
                  // leading: Icon(Icons.language),
                  onTap: () {
                    Get.back();

                    LocalizationService().changeLocale(l);
                    // AuthController.to.setAppLanguge(l);
                    SettingsController.appLanguge = l;
                    if (langChangedCallBack != null) langChangedCallBack(l);
                  },
                ),
                Divider(),
              ],
            );
          }).toList()),
        ],
      ),
      // confirm: Text("cooo"),
      // actions: <Widget>[Text("aooo"), Text("aooo")],
      // cancel: Text("bla bla"),
      // content: Text("bla bldddda"),
    );
  }

  static showSelectDialog(
      String title, List<String> items, void Function(int selected) onSelected,
      {TextDirection textDirection = TextDirection.ltr}) {
    Get.defaultDialog(
      title: title,
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      content: Column(
        children: [
          SizedBox(height: 15),
          SizedBox(
            height: 250,
            width: 260,
            child: Scrollbar(
              thumbVisibility: true,
              child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: items.map((i) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Center(
                              child: Text(
                            i,
                            textDirection: textDirection,
                          )),
                          // leading: Icon(Icons.language),
                          onTap: () {
                            Get.back();
                            onSelected(items.indexOf(i));
                          },
                        ),
                        Divider(),
                      ],
                    );
                  }).toList()),
            ),
          ),
        ],
      ),
      // confirm: Text("cooo"),
      // actions: <Widget>[Text("aooo"), Text("aooo")],
      // cancel: Text("bla bla"),
      // content: Text("bla bldddda"),
    );
  }
}
