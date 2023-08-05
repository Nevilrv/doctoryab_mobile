import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/ads_model.dart';
import 'package:doctor_yab/app/data/repository/AdRepository.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:logger/logger.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '/app/extentions/widget_exts.dart';

class AdView extends StatelessWidget {
  PageController pageController = PageController();
  var dataList = Rx<AdsModel>(null);
  var selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    _fetchAds();
    return Center(
      child: Container(
        color: AppColors.lgt.withOpacity(0.7),
        // height: 100,
        width: MediaQuery.of(context).size.width < 360 ? null : 343,
        child: Obx(
          () => AspectRatio(
            aspectRatio: 343 / 181,
            // child: TestWidget(),
            child: dataList.value == null
                ? Column(
                    children: [
                      Spacer(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "loading_ad".tr,
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(width: 8),
                          Icon(Entypo.megaphone),
                        ],
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        height: 35,
                        width: 35,
                        child: LoadingIndicator(
                            indicatorType: Indicator.ballClipRotateMultiple,

                            /// Required, The loading type of the widget
                            colors: const [Colors.black],

                            /// Optional, The color collections
                            strokeWidth: 2,

                            /// Optional, The stroke of the line, only applicable to widget which contains line
                            backgroundColor: Colors.transparent,

                            /// Optional, Background of the widget
                            pathBackgroundColor: Colors.black

                            /// Optional, the stroke backgroundColor
                            ),
                      ),
                      Spacer(),
                    ],
                  )
                : Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Positioned.fill(
                        child: PageView.builder(
                          onPageChanged: (i) => selectedPage = i,
                          // physics: BouncingScrollPhysics(),
                          itemCount: dataList().data.length,
                          controller: pageController,
                          itemBuilder: (c, i) {
                            var _item = dataList().data[i];
                            return CachedNetworkImage(
                              imageUrl: "${ApiConsts.hostUrl}${_item.img}",
                              fit: BoxFit.cover,
                              placeholder: (_, __) {
                                return AspectRatio(
                                  aspectRatio: 1,
                                  child: LoadingIndicator(
                                          indicatorType: Indicator.ballScale,

                                          /// Required, The loading type of the widget
                                          colors: const [AppColors.lgt],

                                          /// Optional, The color collections
                                          strokeWidth: 2,

                                          /// Optional, The stroke of the line, only applicable to widget which contains line
                                          backgroundColor: Colors.transparent,

                                          /// Optional, Background of the widget
                                          pathBackgroundColor: Colors.black

                                          /// Optional, the stroke backgroundColor
                                          )
                                      .paddingAll(16),
                                );
                              },
                              errorWidget: (_, __, ___) {
                                return Container(
                                    // color: Colors.amber,
                                    );
                              },
                            ).onTap(() {
                              print("ad tapped");
                              try {
                                launch(_item.link);
                              } catch (e, s) {
                                Logger().e("lucinching-ad-link", e, s);
                              }
                            });
                          },
                        ),
                      ),
                      Positioned.directional(
                        textDirection: Directionality.of(context),
                        top: 20,
                        end: 20,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "ad".tr,
                              style: AppTextTheme.m(8),
                            ),
                            SizedBox(width: 6),
                            Icon(
                              Entypo.megaphone,
                              size: 10,
                            ),
                          ],
                        )
                            .paddingSymmetric(horizontal: 8, vertical: 2)
                            .bgColor(Colors.white)
                            .radiusAll(50),
                      ),
                      Positioned(
                        bottom: 2,
                        child: SmoothPageIndicator(
                          controller: pageController, // PageController
                          count: dataList().data.length,
                          effect: WormEffect(
                            dotHeight: 8,
                            dotWidth: 8,
                          ), // your preferred effect
                          onDotClicked: (index) {},
                        )
                            .paddingAll(4)
                            .bgColor(Colors.white)
                            .radiusAll(50)
                            .basicShadow(),
                      )
                    ],
                  ).onTap(() {
                    print("ad tapped");
                    try {
                      launch(dataList()
                          .data[() {
                            return selectedPage;
                          }()]
                          .link);
                    } catch (e, s) {
                      Logger().e("lucinching-ad-link", e, s);
                    }
                  }),
          ),
        ),
      ).radiusAll(12).paddingSymmetric(vertical: 30, horizontal: 16),
    );
  }

  void _fetchAds() {
    AdsRepository.fetchAds().then((v) {
      // AdsModel v = AdsModel();
      if (v.data == null) {
        v.data = <Ad>[Ad()];
      }
      // var _tmp = v.data.where((element) => true).toList();
      // // _tmp.data.addAll(v.data.where((element) => true));
      // _tmp.addAll(v.data);
      // _tmp.addAll(v.data);
      // v.data.addAll(_tmp);
      dataList.value = v;

      // dataList.update((val) => v);
    }).catchError((e, s) {
      Logger().e("message", e, s);
      Future.delayed(Duration(seconds: 3), () {
        if (this != null) _fetchAds();
      });
    });
  }
}
