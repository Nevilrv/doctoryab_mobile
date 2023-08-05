import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/ApiConsts.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class FullScreenImageViewr extends StatelessWidget {
  final String imgUrl;
  const FullScreenImageViewr(this.imgUrl, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar.specialAppBar("full_image_view".tr),
      body: Center(
        child: Hero(
          tag: imgUrl,
          child: PinchZoom(
            resetDuration: const Duration(milliseconds: 100),
            maxScale: 2.5,
            child: CachedNetworkImage(
              imageUrl: imgUrl,
              fit: BoxFit.contain,

              // alignment: Alignment.center,
            ),
          ),
        ),
      ),
    );
  }
}
