import 'dart:developer';

import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AddAd extends StatefulWidget {
  @override
  AddAdState createState() => AddAdState();
}

class AddAdState extends State<AddAd> {
  //ad setup
  BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  @override
  void initState() {
    _bannerAd = BannerAd(
      adUnitId: Utils.bannerAdId,
      request: AdRequest(),
      // size: AdSize(height: (200).round(), width: Get.width.round()),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          log("ad--------------> ${ad}");

          //if this is the first banner load set adsready true
          if (!_isBannerAdReady) {
            setState(() {
              _isBannerAdReady = true;
              log("_isBannerAdReady--------------> ${_isBannerAdReady}");
            });
          }
        },
        onAdFailedToLoad: (ad, err) {
          log("ad----err----------> ${ad}");
          log('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
    setState(() {});

    super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  //the card takes will either take editable form or view form
  Widget build(BuildContext context) {
    return _isBannerAdReady == true
        ? Container(
            height: Get.height * 0.1,
            width: _bannerAd.size.width.toDouble(),
            alignment: Alignment.center,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: AdWidget(ad: _bannerAd),
            ),
          )
        : Container(
            // height: 10,
            // color: Colors.red,
            );
  }
}
