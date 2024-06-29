import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/components/ad_view.dart';
import 'package:doctor_yab/app/components/full_screen_image_viewer.dart';
import 'package:doctor_yab/app/components/profile_view.dart';
import 'package:doctor_yab/app/data/repository/DrugStoreRepository.dart';
import 'package:doctor_yab/app/data/repository/LabsRepository.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/HospitalsModel.dart';
import 'package:doctor_yab/app/data/models/labs_model.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../components/dot_dot_spacer.dart';
import '../../../components/spacialAppBar.dart';
import '/app/extentions/widget_exts.dart';

class DrugStoreLabView extends StatelessWidget {
  final Labs itemp;
  _Model _model = _Model();
  final DRUG_STORE_LAB_PAGE_TYPE drugStoreLabPageType;
  // var j2 = Jiffy([2021, 7, 30]);
  Hospital? hospital;
  final _checkUpLoaded = false.obs;

  DrugStoreLabView(
    this.itemp,
    this.drugStoreLabPageType, {
    this.hospital,
    Key? key,
  })  : assert(
          drugStoreLabPageType == DRUG_STORE_LAB_PAGE_TYPE.hospital
              ? hospital != null
                  ? true
                  : false
              : true,
        ),
        super(key: key) {
    if (drugStoreLabPageType == DRUG_STORE_LAB_PAGE_TYPE.hospital &&
        hospital != null) {
      //*make the title
      _model.title = hospital!.name!;
      //* make the lat and lon and address
      _model.lat = hospital?.geometry!.coordinates![1];
      _model.lon = hospital?.geometry!.coordinates![0];
      _model.address = hospital?.address;
      _model.imageUrl = hospital?.photo;
      _model.phoneNumbers = [hospital!.phone!.toEnglishDigit()];
      // model.times = itemp?.times; //* we remove this as hasanzada request
    } else {
      //*make the title
      _model.title = itemp.name;
      //* make the lat and lon
      //* make the lat and lon and address
      _model.lat = itemp.geometry?.coordinates![1];
      _model.lon = itemp.geometry?.coordinates![0];
      _model.address = itemp.address;
      _model.imageUrl = itemp.photo;
      // model.times = itemp?.times; //* we remove this as hasanzada request
      _model.checkUp = itemp.checkUp;
      _model.phoneNumbers =
          itemp.phone?.map((e) => e.toEnglishDigit()).toList();
    }

//*
    if (drugStoreLabPageType != DRUG_STORE_LAB_PAGE_TYPE.lab) {
      loadCHeckups();
    }
  }
  @override
  Widget build(BuildContext context) {
    // Intl.defaultLocale = "fa";

    return Scaffold(
      appBar: AppAppBar.specialAppBar(_model.title.toString()),
      body: ProfileViewNew(
        address: _model.address.toString(),
        photo: _model.imageUrl.toString(),
        showChildInBox: false,
        // star: _model.stars,
        geometry: Geometry(coordinates: [
          _model.lon!,
          _model.lat!,
        ]),
        name: _model.title.toString(),
        phoneNumbers: "",

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                _checkUpLoaded();
                return () {
                  var wdgts = <Widget>[];
                  if (_model.checkUp != null && _model.checkUp!.isNotEmpty) {
                    // wdgts.add(
                    //   SizedBox(height: 25),
                    // );

                    // wdgts.add(
                    //   Divider().paddingExceptBottom(16),
                    // );
                    // wdgts.add(
                    //   Text(
                    //     "services_list".tr,
                    //     style: AppTextTheme.h(15),
                    //   ).paddingExceptBottom(16),
                    // );

                    wdgts.add(
                      SizedBox(height: 14),
                    );
                    wdgts.add(
                      GridView.builder(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 161 / 261,
                          crossAxisCount:
                              (MediaQuery.of(context).size.width / 165)
                                  .floorToDouble()
                                  .toInt(),
                        ),
                        //  SliverGridDelegateWithMaxCrossAxisExtent(
                        //   maxCrossAxisExtent: 190,
                        //   childAspectRatio: 161 / 261,
                        // ),
                        itemCount: _model.checkUp
                                ?.where((e) => e.isBrief != true)
                                .length ??
                            0,
                        itemBuilder: (BuildContext context, int index) {
                          return _checkupWithImage(index).paddingAll(8);
                        },
                      ),
                    );
                  }

                  return SizedBox(child: () {
                    if (drugStoreLabPageType == DRUG_STORE_LAB_PAGE_TYPE.lab) {
                      _checkUpLoaded(true);
                      wdgts.add(SizedBox());
                    }
                    if (!_checkUpLoaded()) {
                      return Center(
                        child: SizedBox(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                      ).paddingAll(30);
                    }
                    if (wdgts.length > 0 && (_checkUpLoaded.value)) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: wdgts);
                    } else
                      return SizedBox();
                  }()

                      // wdgts.length > 0 &&
                      //         (_checkUpLoaded.value ||
                      //             drugStoreLabPageType ==
                      //                 DRUG_STORE_LAB_PAGE_TYPE.lab)
                      //     ? Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: wdgts)
                      //     : (_model?.checkUp?.isEmpty ?? false) &&
                      //             (_checkUpLoaded())
                      //         ? SizedBox()
                      //         : Center(
                      //             child: SizedBox(
                      //               child: CircularProgressIndicator(),
                      //             ),
                      //           ).paddingAll(30),
                      );
                }();
              }),
              Obx(() {
                _checkUpLoaded();
                return () {
                  var itms = _model.checkUp
                          ?.where((e) => e.isBrief == true)
                          .toList() ??
                      [];
                  // var tmp = itms?.toList();
                  // itms.addAll(tmp);
                  var widgts = <Widget>[];
                  if (itms != null && itms.isNotEmpty) {
                    for (var i = 0; i < itms.length; i++) {
                      widgts.add(
                        Row(
                          children: [
                            Text(
                              "${itms[i].title}",
                              style: AppTextTheme.m(13).copyWith(),
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                            ),
                            SizedBox(width: 8),
                            PointPainter(),
                            SizedBox(width: 8),
                            Text(
                              "${itms[i].price}",
                              style: AppTextTheme.b(15).copyWith(),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "afghani".tr,
                              style: AppTextTheme.b(12)
                                  .copyWith(color: AppColors.lgt2),
                            ),
                          ],
                        ).paddingExceptTop(16),
                      );
                    }
                  }

                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widgts ?? [Container()]);
                }();
              })
            ]..add(AdView()),
          ),
        ),
      ),
    );
    // return Scaffold(
    // appBar: AppAppBar.specialAppBar(_model.title),
    // body: SingleChildScrollView(
    //  // physics: BouncingScrollPhysics(),
    // child: Column(
    // crossAxisAlignment: CrossAxisAlignment.start,
    // children: [
    //         AspectRatio(
    //           aspectRatio: 375 / 188,
    //           child: CachedToFullScreenImage(_model.imageUrl),
    //         ),
    //         // SizedBox(height: 20),
    //         Text(
    //           "${_model.title}",
    //           style: AppTextTheme.h(18),
    //         ).paddingExceptBottom(16),

    //         AddressShowOnMap(
    //           address: _model.address,
    //           lat: _model.lat,
    //           lon: _model.lon,
    //         ).paddingExceptBottom(16),
    //         //*
    //         if (drugStoreLabPageType == DRUG_STORE_LAB_PAGE_TYPE.hospital)
    //           OutlinedButton(
    //             onPressed: () {
    //               Get.to(() => DoctorsView(
    //                     action: DOCTORS_LOAD_ACTION.ofhospital,
    //                     hospitalId: hospital.id ?? "",
    //                     hospitalName: hospital.name,
    //                   ));
    //               return;
    //             },
    //             child: Row(
    //               children: [
    //                 Text(
    //                   "show_doctors".tr,
    //                   style:
    //                       AppTextTheme.b(14).copyWith(color: AppColors.primary),
    //                 ),
    //                 Spacer(),
    //                 // Transform.rotate(
    //                 //   angle: math.pi,
    //                 //   child: Icon(Icons.arrow_back, color: AppColors.primary),
    //                 // ),
    //                 Icon(MaterialCommunityIcons.doctor),
    //               ],
    //             ).paddingVertical(16),
    //           ).paddingExceptBottom(16),

    //         Wrap(
    //           children: [
    //             Icon(Icons.phone, color: AppColors.green),
    //             SizedBox(width: 4),
    //           ]..addAll(() {
    //               var items = _model.phoneNumbers
    //                       ?.map<Widget>(
    //                         (e) => Text(e, style: AppTextTheme.m(14))
    //                             .paddingHorizontal(4)
    //                             .onTap(() {
    //                           Utils.openPhoneDialer(context, e);
    //                         }),
    //                       )
    //                       ?.toList() ??
    //                   [SizedBox()];
    //               List<Widget> result = <Widget>[];
    //               for (int i = 0; i < items.length; i++) {
    //                 result.add(items[i]);
    //                 if (i != items.length - 1) {
    //                   result.add(Text("-", style: AppTextTheme.m(14))
    //                       .paddingHorizontal(4));
    //                 }
    //               }
    //               return result;
    //             }()),
    //         ).paddingExceptBottom(16),

    //         //*timetable
    //         if (_model.times != null && _model.times.length > 0)
    //           Column(
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               Divider(),
    //               SizedBox(height: 14),
    //               Row(
    //                 children: [
    //                   Icon(
    //                     Icons.watch_later_outlined,
    //                     color: Get.theme.primaryColor,
    //                   ),
    //                   SizedBox(width: 8),
    //                   Text(
    //                     "working_hours".tr,
    //                     style: AppTextTheme.b(18),
    //                   )
    //                 ],
    //               ),
    //               SizedBox(height: 12),
    //               Row(
    //                 children: [
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     mainAxisSize: MainAxisSize.min,
    //                     children: _model.times.map<Widget>((e) {
    //                       // var j = Jiffy(e[0].toLocal());
    //                       // j = j.add(duration: Duration(days: 1));
    //                       return SizedBox(
    //                         height: 45,
    //                         child: Center(
    //                           child: Text(
    //                             () {
    //                               j2 = j2.add(duration: Duration(days: 1));

    //                               return j2.format("EEEE");
    //                             }(),
    //                             style: AppTextTheme.m(15)
    //                                 .copyWith(color: Get.theme.primaryColor),
    //                           ),
    //                         ),
    //                       );
    //                     }).toList(),
    //                   ),
    //                   Spacer(),
    //                   Column(
    //                     mainAxisSize: MainAxisSize.min,
    //                     children: _model.times.map<Widget>((e) {
    //                       var j = Jiffy(e[0].toLocal());
    //                       return SizedBox(
    //                         height: 45,
    //                         child: Center(
    //                           child: FittedBox(
    //                             child: Text(
    //                               j.format("HH:mm"),
    //                               style: AppTextTheme.m(13),
    //                             ),
    //                           ),
    //                         ),
    //                       );
    //                     }).toList(),
    //                   ),
    //                   Spacer(),
    //                   Column(
    //                     mainAxisSize: MainAxisSize.min,
    //                     children: _model.times.map<Widget>((e) {
    //                       return SizedBox(
    //                         height: 45,
    //                         child: Center(
    //                           child: Text(
    //                             "up_to".tr,
    //                             style: AppTextTheme.m(11)
    //                                 .copyWith(color: AppColors.lgt2),
    //                           ),
    //                         ),
    //                       );
    //                     }).toList(),
    //                   ),
    //                   Spacer(),
    //                   Column(
    //                     mainAxisSize: MainAxisSize.min,
    //                     children: _model.times.map<Widget>((e) {
    //                       var j = Jiffy(e[1].toLocal());
    //                       return SizedBox(
    //                         height: 45,
    //                         child: Center(
    //                           child: FittedBox(
    //                             child: Text(
    //                               j.format("HH:mm"),
    //                               style: AppTextTheme.m(13),
    //                             ),
    //                           ),
    //                         ),
    //                       );
    //                     }).toList(),
    //                   ),
    //                   Spacer(
    //                     flex: 2,
    //                   ),
    //                 ],
    //               ).paddingHorizontal(30),
    //             ],
    //           ).paddingExceptBottom(16),
    //         Obx(() {
    //           _checkUpLoaded();
    //           return () {
    //             var wdgts = <Widget>[];
    //             if (_model.checkUp != null && _model.checkUp.isNotEmpty) {
    //               wdgts.add(
    //                 SizedBox(height: 25),
    //               );

    //               wdgts.add(
    //                 Divider().paddingExceptBottom(16),
    //               );
    //               wdgts.add(
    //                 Text(
    //                   "services_list".tr,
    //                   style: AppTextTheme.h(15),
    //                 ).paddingExceptBottom(16),
    //               );

    //               wdgts.add(
    //                 SizedBox(height: 14),
    //               );
    //               wdgts.add(
    //                 GridView.builder(
    //                   padding:
    //                       EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    //                   shrinkWrap: true,
    //                   physics: NeverScrollableScrollPhysics(),
    //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //                     childAspectRatio: 161 / 261,
    //                     crossAxisCount:
    //                         (MediaQuery.of(context).size.width / 165)
    //                             .floorToDouble()
    //                             .toInt(),
    //                   ),
    //                   //  SliverGridDelegateWithMaxCrossAxisExtent(
    //                   //   maxCrossAxisExtent: 190,
    //                   //   childAspectRatio: 161 / 261,
    //                   // ),
    //                   itemCount: _model.checkUp
    //                           ?.where((e) => e.isBrief != true)
    //                           ?.length ??
    //                       0,
    //                   itemBuilder: (BuildContext context, int index) {
    //                     return _checkupWithImage(index).paddingAll(8);
    //                   },
    //                 ),
    //               );
    //             }

    //             return SizedBox(child: () {
    //               if (drugStoreLabPageType == DRUG_STORE_LAB_PAGE_TYPE.lab) {
    //                 _checkUpLoaded(true);
    //                 wdgts.add(SizedBox());
    //               }
    //               if (!_checkUpLoaded()) {
    //                 return Center(
    //                   child: SizedBox(
    //                     child: CircularProgressIndicator(),
    //                   ),
    //                 ).paddingAll(30);
    //               }
    //               if (wdgts.length > 0 && (_checkUpLoaded.value)) {
    //                 return Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: wdgts);
    //               } else
    //                 return SizedBox();
    //             }()

    //                 // wdgts.length > 0 &&
    //                 //         (_checkUpLoaded.value ||
    //                 //             drugStoreLabPageType ==
    //                 //                 DRUG_STORE_LAB_PAGE_TYPE.lab)
    //                 //     ? Column(
    //                 //         crossAxisAlignment: CrossAxisAlignment.start,
    //                 //         children: wdgts)
    //                 //     : (_model?.checkUp?.isEmpty ?? false) &&
    //                 //             (_checkUpLoaded())
    //                 //         ? SizedBox()
    //                 //         : Center(
    //                 //             child: SizedBox(
    //                 //               child: CircularProgressIndicator(),
    //                 //             ),
    //                 //           ).paddingAll(30),
    //                 );
    //           }();
    //         }),

    //         Obx(() {
    //           _checkUpLoaded();
    //           return () {
    //             var itms =
    //                 _model.checkUp?.where((e) => e.isBrief == true)?.toList() ??
    //                     [];
    //             // var tmp = itms?.toList();
    //             // itms.addAll(tmp);
    //             var widgts = <Widget>[];
    //             if (itms != null && itms.isNotEmpty) {
    //               for (var i = 0; i < itms.length; i++) {
    //                 widgts.add(
    //                   Row(
    //                     children: [
    //                       Text(
    //                         "${itms[i].title}",
    //                         style: AppTextTheme.m(13).copyWith(),
    //                         maxLines: 1,
    //                         overflow: TextOverflow.fade,
    //                       ),
    //                       SizedBox(width: 8),
    //                       PointPainter(),
    //                       SizedBox(width: 8),
    //                       Text(
    //                         "${itms[i].price}",
    //                         style: AppTextTheme.b(15).copyWith(),
    //                       ),
    //                       SizedBox(width: 8),
    //                       Text(
    //                         "afghani".tr,
    //                         style: AppTextTheme.b(12)
    //                             .copyWith(color: AppColors.lgt2),
    //                       ),
    //                     ],
    //                   ).paddingExceptTop(16),
    //                 );
    //               }
    //             }

    //             return Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: widgts ?? [Container()]);
    //           }();
    //         })
    //       ]..add(AdView()),
    //     ),
    //   ),
    // );
  }

  Widget _checkupWithImage(int i) {
    var list = _model.checkUp?.where((e) => e.isBrief != true)?.toList();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            // height: 100,
            // width: 100,
            // color: Colors.red,
            child: CachedToFullScreenImage("${list![i].img}"),
          ),
        ).radiusAll(10),
        SizedBox(height: 5),
        FittedBox(
            child: Text(
          "${list[i].title}",
          maxLines: 1,
          style: AppTextTheme.b(14),
          overflow: TextOverflow.ellipsis,
        )),
        SizedBox(height: 5),
        Text(
          "${list[i].content}",
          style: AppTextTheme.r(10).copyWith(color: AppColors.lgt2),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Text(
              "${list[i].price}",
              style: AppTextTheme.r(15).copyWith(),
            ),
            SizedBox(width: 12),
            Text(
              "afghani".tr,
              style: AppTextTheme.r(11).copyWith(color: AppColors.lgt2),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> loadCHeckups() async {
    if (drugStoreLabPageType == DRUG_STORE_LAB_PAGE_TYPE.lab) {
      _model.checkUp = _model.checkUp;
      _checkUpLoaded(true);
      return;
    }
    try {
      var resp = drugStoreLabPageType == DRUG_STORE_LAB_PAGE_TYPE.hospital
          ? await LabsRepository().fetchCheckup(hospital!.id.toString())
          : await DrugStoreRepository().fetchCheckup(itemp.id.toString());
      var res =
          List<CheckUp>.from(resp.data["data"].map((x) => CheckUp.fromJson(x)));
      _model.checkUp = res;
      _checkUpLoaded(true);
      return;
    } catch (e, s) {
      FirebaseCrashlytics.instance
          .recordError(e, s, reason: "Can Not load checkup list");
      Future.delayed(Duration(seconds: 2), () {
        loadCHeckups();
      });
    }
  }
}

//TODO Export this to a widget file
class CachedToFullScreenImage extends StatelessWidget {
  const CachedToFullScreenImage(
    String imageUrl, {
    Key? key,
  })  : _imageUrl = imageUrl,
        super(key: key);

  final String _imageUrl;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "${ApiConsts.hostUrl}$_imageUrl",
      child: CachedNetworkImage(
        imageUrl: "${ApiConsts.hostUrl}$_imageUrl",
        fit: BoxFit.cover,
        // alignment: Alignment.center,
        placeholder: (_, __) {
          return Image.asset(
            "assets/png/placeholder_hospital.png",
            fit: BoxFit.cover,
          ).onTap(() {});
        },
        errorWidget: (_, __, ___) {
          return Image.asset(
            "assets/png/placeholder_hospital.png",
            fit: BoxFit.cover,
          ).onTap(() {});
        },
      ).onTap(() {
        Get.to(
          () => FullScreenImageViewr("${ApiConsts.hostUrl}$_imageUrl"),
          transition: Transition.noTransition,
        );
      }),
    );
  }
}

enum DRUG_STORE_LAB_PAGE_TYPE {
  lab,
  drugstore,
  hospital,
}

class _Model {
  String? title, imageUrl, address;
  double? lat, lon;
  List<String>? phoneNumbers;
  List<List<DateTime>>? times;
  List<CheckUp>? checkUp;
  _Model({
    this.title,
    this.imageUrl,
    this.address,
    this.lat,
    this.lon,
    this.phoneNumbers,
    this.times,
    this.checkUp,
  });
}
