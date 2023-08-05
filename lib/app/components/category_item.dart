import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/categories_model.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final Category item;
  const CategoryItem(
    this.item, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 179,
      width: 142,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
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
            aspectRatio: 1,
            child: Container(
              // constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Utils.hexToColor(
                  item.background,
                  defaultColorIfInvalid: AppColors.disabledButtonColor,
                ).withOpacity(1),
              ),
              child: Center(
                child: SizedBox(
                  height: 65,
                  // width: 20,
                  child:
                      // Image.network(
                      //   '${ApiConsts.hostUrl}${item.photo}',
                      //   // height: 20,
                      //   // width: 20,
                      //   // fit: BoxFit.,
                      // ),
                      CachedNetworkImage(
                    imageUrl: '${ApiConsts.hostUrl}${item.photo}',
                    errorWidget: (_, __, ___) {
                      return SizedBox();
                    },
                  ),
                ),
              ),
            ),
          ),
          // Spacer(),
          Expanded(
            child: Center(
              child: FittedBox(
                child: AutoSizeText(
                  item.title,
                  maxLines: 1,
                  minFontSize: 8,
                  // style: AppTextTheme.m(12).copyWith(
                  //   color: AppColors.black2,
                  // ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          // Spacer(),
        ],
      ),
    );
  }
}