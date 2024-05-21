import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/categories_model.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final Category item;
  const CategoryItem(
    this.item, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: h * 0.1,
      // width: 142,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 7,
            blurRadius: 7,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            child: Container(
              // constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Utils.hexToColor(
                  item.background!,
                  defaultColorIfInvalid: AppColors.disabledButtonColor,
                ).withOpacity(1),
              ),
              child: Center(
                child: SizedBox(
                  // height: h * 0.15,
                  // height: 65,
                  // width: 20,
                  child:
                      // Image.network(
                      //   '${ApiConsts.hostUrl}${item.photo}',
                      //   // height: 20,
                      //   // width: 20,
                      //   // fit: BoxFit.,
                      // ),
                      Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      imageUrl: '${ApiConsts.hostUrl}${item.photo}',
                      errorWidget: (_, __, ___) {
                        return SizedBox();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Spacer(),
          Expanded(
            child: Center(
              child: AutoSizeText(
                item.title!,
                maxLines: 2,
                minFontSize: 8, maxFontSize: 12, textAlign: TextAlign.center,
                style: AppTextStyle.mediumBlack12
                    .copyWith(fontWeight: FontWeight.w600),
                // style: AppTextTheme.m(12).copyWith(
                //   color: AppColors.black2,
                // ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // Spacer(),
        ],
      ),
    );
  }
}
