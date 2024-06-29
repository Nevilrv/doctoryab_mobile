import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerView extends StatelessWidget {
  const BannerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.2,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
            "https://static.vecteezy.com/system/resources/thumbnails/005/009/008/small/printend-of-year-sale-banner-with-copy-space-background-for-product-promotion-and-advertising-free-vector.jpg",
            fit: BoxFit.cover),
      ),
    );
  }
}
