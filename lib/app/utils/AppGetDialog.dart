import 'dart:developer';
import 'dart:ffi';

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
import 'package:doctor_yab/app/modules/notification/controllers/notification_controller.dart';
import 'package:doctor_yab/app/services/LocalizationServices.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart' as intl;
import 'package:logger/logger.dart';
import 'dart:math' as math;

enum DialogType { ERROR, DONE, QUESTION, MESSAGE }

class AppGetDialog {
  static show({
    String? title,
    String? mainButtonText,
    String? middleText,
    List<Widget>? actions,
    Widget? component,
    Color? color,
    double? double,
    bool hasOnlyContent = false, //TODO this is bad way, use child instead
  }) {
    title = title == null ? "error".tr : title;
    return Get.defaultDialog(
      backgroundColor: color ?? AppColors.scaffoldColor,
      title: hasOnlyContent ? '' : title,
      // titleStyle: TextStyle(color: AppColors.lgt1),
      titleStyle: hasOnlyContent ? TextStyle(fontSize: 1) : TextStyle(),
      middleText: hasOnlyContent ? '' : middleText.toString(),
      radius: double ?? 10,
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

  static showSuccess({required String? middleText, VoidCallback? onTap}) {
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
              middleText ?? "",
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
                  color: AppColors.primary,
                  textColor: Colors.white,
                  splashColor: Colors.white.withOpacity(0.2),
                  disabledColor: AppColors.easternBlue.withOpacity(0.2),
                  // height: 50,
                  width: 230,
                  text: "done".tr,
                  onTap: onTap ??
                      () {
                        Get.back();
                        // // Get.offAllNamed(Routes.HOME);
                        //
                        // Get.until((route) => route.isFirst);
                        // Get.find<HomeController>().pageController.animateTo(2,
                        //     duration: Duration(milliseconds: 0),
                        //     curve: Curves.ease);
                        // Get.find<HomeController>().setIndex(2);
                      },
                ),
              ),
            ).paddingOnly(bottom: 0, top: 8),
          ],
        ));
  }

  static showAppointmentSuccess(
      {required String? doctorName, DateTime? date, VoidCallback? onTap}) {
    show(
        hasOnlyContent: true,
        component: Column(
          children: [
            Image.asset(
              AppImages.bookingDoneCalender,
              height: 45,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              SettingsController.appLanguge == 'English'
                  ? 'Your appointment is confirmed with $doctorName on ${intl.DateFormat.yMd().add_jm().format(DateTime.now())}.\n\nPlease reach 15 minutes before your Appointment!'
                  : SettingsController.appLanguge == 'پشتو'
                      ? ' تاسو په بریالیتوب سره د$doctorName سره په ${intl.DateFormat.yMd().add_jm().format(DateTime.now())} \n\nهیله ده 15 دقیقی مخکی له معاینی څخه ورسیږی'
                      : ' شما به شکل موفقانه نوبت معاینه از$doctorName به تاریخ ${intl.DateFormat.yMd().add_jm().format(DateTime.now())}  گرفتید \n\n لطفاً ۱۵ دقیقه قبل از وقت معاینه برسید',
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
                  color: Color(0xff00A79D),
                  textColor: Colors.white,
                  splashColor: Colors.white.withOpacity(0.2),
                  disabledColor: AppColors.easternBlue.withOpacity(0.2),
                  // height: 50,
                  width: 230,
                  text: "done".tr,
                  onTap: onTap ??
                      () {
                        Get.back();
                        // // Get.offAllNamed(Routes.HOME);
                        //
                        // Get.until((route) => route.isFirst);
                        // Get.find<HomeController>().pageController.animateTo(2,
                        //     duration: Duration(milliseconds: 0),
                        //     curve: Curves.ease);
                        // Get.find<HomeController>().setIndex(2);
                      },
                ),
              ),
            ).paddingOnly(bottom: 0, top: 8),
          ],
        ));
  }

  static showCancelAppointment(
      {required String doctorName, DateTime? date, VoidCallback? onTap}) {
    show(
      hasOnlyContent: true,
      component: Column(
        children: [
          Image.asset(
            AppImages.bookingDoneCalender,
            height: 45,
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            SettingsController.appLanguge == 'English'
                ? 'Are you sure you want to cancel your appointment?'
                : SettingsController.appLanguge == 'پشتو'
                    ? 'ایا تاسو ډاډه یاست چې خپل معاینه وخت لغوه کړئ؟'
                    : 'آیا مطمین هستید که وقت معاینه تانرا فسخ نمایید؟',
            textAlign: TextAlign.center,
            style: AppTextTheme.b2(),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 70,
                child: Center(
                  child: CustomRoundedButton(
                      color: Color(0xff00A79D),
                      textColor: Colors.white,
                      splashColor: Colors.white.withOpacity(0.2),
                      disabledColor: AppColors.easternBlue.withOpacity(0.2),
                      // height: 50,
                      width: 115,
                      text: "yes".tr,
                      onTap: onTap
                      // ??
                      // () {
                      //   Get.back();
                      //   // // Get.offAllNamed(Routes.HOME);
                      //   //
                      //   // Get.until((route) => route.isFirst);
                      //   // Get.find<HomeController>().pageController.animateTo(2,
                      //   //     duration: Duration(milliseconds: 0),
                      //   //     curve: Curves.ease);
                      //   // Get.find<HomeController>().setIndex(2);
                      // },
                      ),
                ),
              ).paddingOnly(bottom: 0, top: 8, left: 20),
              Container(
                height: 70,
                child: Center(
                  child: CustomRoundedButton(
                    color: Color(0xff00A79D),
                    textColor: Colors.white,
                    splashColor: Colors.white.withOpacity(0.2),
                    disabledColor: AppColors.easternBlue.withOpacity(0.2),
                    // height: 50,
                    width: 115,
                    text: "no".tr,
                    onTap: () {
                      Get.back();
                      // // Get.offAllNamed(Routes.HOME);
                      //
                      // Get.until((route) => route.isFirst);
                      // Get.find<HomeController>().pageController.animateTo(2,
                      //     duration: Duration(milliseconds: 0),
                      //     curve: Curves.ease);
                      // Get.find<HomeController>().setIndex(2);
                    },
                  ),
                ),
              ).paddingOnly(bottom: 0, top: 8, right: 20),
            ],
          ),
        ],
      ),
    );
  }

  static pregnancyComplete(
      {required String title,
      VoidCallback? onTapYes,
      VoidCallback? onTapNo,
      String? image}) {
    show(
      color: Color(0xffE1F0DA),
      double: 50.0,
      hasOnlyContent: true,
      component: Column(
        children: [
          Image.asset(
            image!,
            height: 70,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextTheme.b2(),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap: onTapYes,
                  child: Container(
                      height: 40,
                      margin: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                          color: Color(0xff00A79D),
                          borderRadius: BorderRadius.circular(20)),
                      width: 100,
                      child: Center(
                        child: Text(
                          "yes".tr,
                          style: TextStyle(color: AppColors.white),
                        ),
                      ))),
              GestureDetector(
                  onTap: onTapNo,
                  child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color(0xff00A79D),
                          borderRadius: BorderRadius.circular(20)),
                      width: 100,
                      child: Center(
                        child: Text(
                          "no".tr,
                          style: TextStyle(color: AppColors.white),
                        ),
                      ))),
            ],
          ),
        ],
      ),
    );
  }

  static showWithRetryCallBack(
      {required String middleText,
      Function? retryCallBak,
      String? operationTitle,
      String? retryButtonText}) {
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
      required cityChangedCallBack(City city),
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
          if (newItems == "" || newItems.length == 0) {
            _pagedController.appendLastPage(newItems);
          } else {
            var itt = _pagedController.itemList != null
                ? newItems
                    .where(
                      (element) =>
                          // !(_pagedController.itemList.contains(element)),
                          !_pagedController.itemList!
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
          if (_eCode != "") {
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
                    title:
                        Center(child: Text(item.getMultiLangName().toString())),
                    // leading: Icon(Icons.language),
                    onTap: () {
                      Get.back();
                      // print(city.getMultiLangName() + " " + city.id);
                      // AuthController.to.setCity(city);
                      if (saveInstantlyAfterClick)
                        SettingsController.auth.savedCity = item;
                      // print("dddddddd ${SettingsController.auth.savedCityId}");
                      if (cityChangedCallBack != "") cityChangedCallBack(item);
                      if (restartApp)
                        Phoenix.rebirth(Get.context!); //TODO Fix this
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
    required onChange(Category category),
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
        if (data != "") {
          if (data == "" || data.length == 0) {
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
                    if (onChange != "") onChange(item);
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

  static showChangeLangDialog(NotificationController controller) {
    Get.dialog(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Container(
            // height: Get.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                      ),
                      SvgPicture.asset(
                        AppImages.language,
                        height: 48,
                        width: 48,
                        color: AppColors.primary,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.cancel_outlined,
                          color: AppColors.primary,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    "select_a_language".tr,
                    style: AppTextStyle.boldBlack13,
                  ),

                  Text(
                    "please_select_your_preferred_language".tr,
                    style: AppTextStyle.boldBlack13
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 15),
                  Column(
                      children: LocalizationService.langs.map((l) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GestureDetector(
                        onTap: () {
                          Get.back();

                          LocalizationService().changeLocale(l);

                          // AuthController.to.setAppLanguge(l);
                          SettingsController.appLanguge = l;
                          controller.changeLanguage();

                          log("SettingsController.appLanguge--------------> ${SettingsController.appLanguge}");
                        },
                        child: Container(
                          width: Get.width * 0.3,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Center(
                              child: Text(
                                l,
                                style: AppTextStyle.boldWhite14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList()),
                  // Column(
                  //     children: LocalizationService.langs.map((l) {
                  //   return Column(
                  //     children: [
                  //       ListTile(
                  //         title: Center(child: Text(l)),
                  //         // leading: Icon(Icons.language),
                  //         onTap: () {
                  //           Get.back();
                  //
                  //           LocalizationService().changeLocale(l);
                  //           // AuthController.to.setAppLanguge(l);
                  //           SettingsController.appLanguge = l;
                  //           if (langChangedCallBack != null) langChangedCallBack(l);
                  //         },
                  //       ),
                  //       Divider(),
                  //     ],
                  //   );
                  // }).toList()),
                ],
              ),
            ),
          ),
        ),
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
