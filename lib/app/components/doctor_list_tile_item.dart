import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/doctors_model.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';

class DoctorListTileItem extends StatelessWidget {
  final Doctor doctor;
  final Widget? trailing;
  final int imageRadius;
  final VoidCallback? onTap;
  final ListTileMode listTileMode;

  const DoctorListTileItem(
    this.doctor, {
    Key? key,
    this.imageRadius = 20,
    this.trailing,
    this.onTap,
    this.listTileMode = ListTileMode.tile,
  }) : super(key: key);
  // const DoctorListTileItem(this.doctor);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        listTileMode == ListTileMode.tile
            ? SizedBox()
            : SizedBox(
                height: 150,
                width: 150,
                child: _profileImge(radius: imageRadius, doctor: doctor),
              ),
        ListTile(
          onTap: onTap,
          leading: listTileMode == ListTileMode.tile
              ? AspectRatio(
                  aspectRatio: 1,
                  child: Transform.scale(
                    scale: 1.09,
                    child: _profileImge(radius: imageRadius, doctor: doctor),
                  ),
                )
              : null,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  doctor.fullname ??
                      " ${doctor.name ?? ""} ${doctor.lname ?? ""}",
                  style: AppTextTheme.h(15).copyWith(color: AppColors.black2),
                ),
              ),
              if (doctor.verification ?? false)
                Icon(
                  Icons.verified,
                  color: AppColors.verified,
                ).paddingHorizontal(6),
            ],
          ).paddingOnly(top: 8, bottom: 2),
          // title: Text(
          //   "${doctor.name ?? ""} ${doctor.lname ?? ""}",
          //   style: AppTextTheme.h(15).copyWith(color: AppColors.black2),
          // ).paddingOnly(top: 8, bottom: 2),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctor.category?.eTitle ?? "",
                style: AppTextTheme.b(14)
                    .copyWith(color: AppColors.lgt2, height: 1.0),
              ),
              SizedBox(height: 2),
              if (doctor.stars != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RatingBar.builder(
                      ignoreGestures: true,
                      itemSize: 15,
                      initialRating:
                          double.tryParse(doctor.stars?.toStringAsFixed(1)) ??
                              0.0,
                      // minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                        // size: 10,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    SizedBox(width: 4),
                    Text(
                      '(${double.tryParse(doctor.totalStar?.toStringAsFixed(1)) ?? ""})',
                      style:
                          AppTextTheme.b(10.5).copyWith(color: AppColors.lgt2),
                    ),
                  ],
                ),
              SizedBox(height: 8),
            ],
          ),
          trailing: trailing,
        ),
      ],
    );
  }

  Widget _profileImge({int? radius, Doctor? doctor}) {
    return Container(
      // color: Colors.black,
      // height: 65,
      // width: 65,
      child:
          //   Image.network(
          //     "${ApiConsts.hostUrl}${doctor.photo}",
          //     fit: BoxFit.cover,
          //   ),
          // ).radiusAll(imageRadius ?? 20),
          CachedNetworkImage(
        imageUrl: "${ApiConsts.hostUrl}${doctor!.photo}",
        placeholder: (_, __) {
          return Image.asset(
            "assets/png/person-placeholder.jpg",
            fit: BoxFit.cover,
          );
        },
        errorWidget: (_, __, ___) {
          return Image.asset(
            "assets/png/person-placeholder.jpg",
            fit: BoxFit.cover,
          );
        },
        fit: BoxFit.cover,
      ),
    ).radiusAll(imageRadius ?? 20);
  }
}

enum ListTileMode { profile, tile }
