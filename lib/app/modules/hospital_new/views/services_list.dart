import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:doctor_yab/app/modules/hospital_new/controllers/hospital_new_controller.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../../../components/ad_view.dart';
import '../../../components/address_show_on_map.dart';
import '../../../components/dot_dot_spacer.dart';
import '../../../data/models/HospitalsModel.dart';
import '../../../theme/AppColors.dart';
import '../../../theme/TextTheme.dart';
import '../../drug_store_lab/views/drug_store_lab_view.dart';

class HospitalServicesList extends GetView<HospitalNewController> {
  HospitalServicesList({Key key}) : super(key: key);
  final _checkUpLoaded = false.obs;
  var j2 = Jiffy([2021, 7, 30]);
  // Hospital hospital;
  Hospital _model;
  @override
  Widget build(BuildContext context) {
    _model = controller.hospital;
    return SingleChildScrollView(
      // physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //*timetable
          () {
            var wdgts = <Widget>[];
            if (_model.checkUp != null && _model.checkUp.isNotEmpty) {
              wdgts.add(
                SizedBox(height: 25),
              );

              wdgts.add(
                SizedBox(height: 14),
              );
              wdgts.add(
                GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 161 / 261,
                    crossAxisCount: (MediaQuery.of(context).size.width / 165)
                        .floorToDouble()
                        .toInt(),
                  ),
                  //  SliverGridDelegateWithMaxCrossAxisExtent(
                  //   maxCrossAxisExtent: 190,
                  //   childAspectRatio: 161 / 261,
                  // ),
                  itemCount:
                      _model.checkUp?.where((e) => e.isBrief != true)?.length ??
                          0,
                  itemBuilder: (BuildContext context, int index) {
                    return _checkupWithImage(index).paddingAll(8);
                  },
                ),
              );
            }

            return SizedBox(child: () {
              // if (!_checkUpLoaded()) {
              //   return Center(
              //     child: SizedBox(
              //       child: CircularProgressIndicator(),
              //     ),
              //   ).paddingAll(30);
              // }
              if (wdgts.length > 0) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: wdgts);
              } else
                return SizedBox();
            }());
          }(),

          () {
            var itms =
                _model.checkUp?.where((e) => e.isBrief == true)?.toList() ?? [];
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
                        style:
                            AppTextTheme.b(12).copyWith(color: AppColors.lgt2),
                      ),
                    ],
                  ).paddingExceptTop(16),
                );
              }
            }

            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widgts ?? [Container()]);
          }()
        ]..add(AdView()),
      ),
    );
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
            child: CachedToFullScreenImage("${list[i].img}"),
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
  // Future<void> loadCHeckups() async {
  //   if (drugStoreLabPageType == DRUG_STORE_LAB_PAGE_TYPE.lab) {
  //     _model.checkUp = _model.checkUp;
  //     _checkUpLoaded(true);
  //     return;
  //   }
  //   try {
  //     var resp = drugStoreLabPageType == DRUG_STORE_LAB_PAGE_TYPE.hospital
  //         ? await LabsRepository().fetchCheckup(hospital.id)
  //         : await DrugStoreRepository().fetchCheckup(itemp.id);
  //     var res =
  //         List<CheckUp>.from(resp.data["data"].map((x) => CheckUp.fromJson(x)));
  //     _model.checkUp = res;
  //     _checkUpLoaded(true);
  //     return;
  //   } catch (e, s) {
  //     FirebaseCrashlytics.instance
  //         .recordError(e, s, reason: "Can Not load checkup list");
  //     Future.delayed(Duration(seconds: 2), () {
  //       loadCHeckups();
  //     });
  //   }
  // }
}
