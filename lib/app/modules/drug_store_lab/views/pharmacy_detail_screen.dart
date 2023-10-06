import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_yab/app/components/background.dart';
import 'package:doctor_yab/app/components/profile_view.dart';
import 'package:doctor_yab/app/components/spacialAppBar.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/controllers/tab_home_drugstore_controller.dart';
import 'package:doctor_yab/app/modules/home/views/home_view.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class PharmacyDetailScreen extends GetView<DrugStoreController> {
  List tab = ["products".tr, "services_list".tr];
// class HospitalNewView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Background(
      isSecond: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppAppBar.specialAppBar("Pharmacy",
            backgroundColor: Colors.transparent,
            action: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SvgPicture.asset(AppImages.blackBell),
            )),

        body: ProfileViewNew(
          address: "",
          photo: "",
          star: 4,
          geometry: null,
          name: "controller.hospital.name",
          phoneNumbers: ["26589658985"],
          numberOfusersRated: 5,
          child: Obx(() {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      tab.length,
                      (index) => Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              onTap: () {
                                controller.tabIndex.value = index;
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: controller.tabIndex.value != index
                                        ? AppColors.white
                                        : AppColors.primary,
                                    border:
                                        Border.all(color: AppColors.primary)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Center(
                                    child: Container(
                                        width: w * 0.25,
                                        child: Center(
                                            child: Text(
                                          tab[index],
                                          style:
                                              controller.tabIndex.value != index
                                                  ? AppTextStyle.boldPrimary14
                                                  : AppTextStyle.boldWhite14,
                                        ))),
                                  ),
                                ),
                              ),
                            ),
                          )),
                ),
                controller.tabIndex.value == 0
                    ? Container(
                        height: h * 0.263,
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.only(top: 10),
                          child: GridView.builder(
                            itemCount: 4,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 9,
                                    mainAxisExtent: h * 0.26),
                            itemBuilder: (context, index) {
                              return Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: h * 0.15,
                                      width: w,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "https://img.freepik.com/free-photo/beautiful-young-female-doctor-looking-camera-office_1301-7807.jpg?size=626&ext=jpg&ga=GA1.1.1413502914.1696464000&semt=sph",
                                        fit: BoxFit.cover,
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
                                      ),
                                    ),
                                    Text(
                                      "Example Service",
                                      style: AppTextStyle.boldPrimary14,
                                    ),
                                    Text(
                                      "Example service explain",
                                      style: AppTextStyle.boldPrimary12
                                          .copyWith(
                                              color: AppColors.primary
                                                  .withOpacity(0.5)),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AppColors.primary,
                                          border: Border.all(
                                              color: AppColors.primary)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        child: Center(
                                          child: Text(
                                            "22000 Afghani",
                                            style: AppTextStyle.boldWhite14,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : Container(
                        height: h * 0.263,
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.only(top: 10),
                          child: Column(
                            children: List.generate(
                                5,
                                (index) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Example Service",
                                                style:
                                                    AppTextStyle.boldPrimary16,
                                              ),
                                              Text(
                                                "Example service explain",
                                                style: AppTextStyle
                                                    .boldPrimary14
                                                    .copyWith(
                                                        color: AppColors.primary
                                                            .withOpacity(0.5)),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: AppColors.primary,
                                                border: Border.all(
                                                    color: AppColors.primary)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                              child: Center(
                                                child: Text(
                                                  "22000 Afghani",
                                                  style:
                                                      AppTextStyle.boldWhite14,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                          ),
                        ),
                      )

                // TabBar(
                //   controller: controller.tabController,
                //   labelColor: AppColors.black2,
                //   unselectedLabelColor: AppColors.lgt,
                //   isScrollable: true,
                //   tabs: [
                //     Text("doctors".tr).paddingVertical(8),
                //     Text("services_list".tr),
                //     // Text("reviews".tr),
                //     Text("about".tr),
                //   ],
                // )
              ],
            );
          }),
        ),
        bottomNavigationBar: BottomBarView(isHomeScreen: false),
        // body: ProfileViewNew(
        //   address: controller.hospital.address,
        //   photo: controller.hospital.photo,
        //   star: controller.hospital.stars,
        //   geometry: controller.hospital.geometry,
        //   name: controller.hospital.name,
        //   phoneNumbers: [controller.hospital.phone],
        //   numberOfusersRated: controller.hospital.usersStaredCount,
        //   child: TabMainView(),
        // ),
      ),
    );
  }
}
