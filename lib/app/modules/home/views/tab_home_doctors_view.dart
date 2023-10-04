import 'package:dio/dio.dart';
import 'package:doctor_yab/app/components/category_item.dart';
import 'package:doctor_yab/app/components/paging_indicators/no_item_list.dart';
import 'package:doctor_yab/app/components/paging_indicators/paging_error_view.dart';
import 'package:doctor_yab/app/components/shimmer/categories_grid_shimmer.dart';
import 'package:doctor_yab/app/components/shimmer/city_shimmer.dart';
import 'package:doctor_yab/app/controllers/booking_controller.dart';
import 'package:doctor_yab/app/data/models/categories_model.dart';
import 'package:doctor_yab/app/modules/home/controllers/tab_home_doctors_controller.dart';
import 'package:doctor_yab/app/routes/app_pages.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TabHomeDoctorsView extends GetView<TabTabHomeController> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: RefreshIndicator(
          onRefresh: () => Future.sync(
            () async {
              Utils.resetPagingController(controller.pagingController);
              await Future.delayed(Duration.zero, () {
                controller.cancelToken.cancel();
              });
              controller.cancelToken = new CancelToken();
              controller.fetchCategories(
                controller.pagingController.firstPageKey,
              );
            },
          ),
          child: PagedGridView(
            pagingController: controller.pagingController,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            // shrinkWrap: true,
            physics: BouncingScrollPhysics(),

            // itemCount: 9,
            // primary: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              // childAspectRatio: 132 / 169,
              // mainAxisExtent: 2,
              mainAxisExtent: h * 0.2,

              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            // SliverGridDelegateWithMaxCrossAxisExtent(
            //   // childAspectRatio: 1,
            //   mainAxisSpacing: 40,
            //   crossAxisSpacing: 20,
            //   maxCrossAxisExtent: 120,
            // ),
            builderDelegate: PagedChildBuilderDelegate<Category>(
              itemBuilder: (BuildContext context, item, int i) {
                // var item = controller.dummyData[i];
                // print("vvvvvvvvvvvvv" + context.size.height.toString());
                return CategoryItem(item).onTap(() {
                  BookingController.to.selectedCategory.value = item;
                  Get.toNamed(Routes.DOCTORS);
                });
              },
              noItemsFoundIndicatorBuilder: (_) => PagingNoItemFountList(),
              firstPageErrorIndicatorBuilder: (context) => PagingErrorView(
                controller: controller.pagingController,
              ),
              firstPageProgressIndicatorBuilder: (_) => CategoriesGridShimmer(
                yCount: 3,
                xCount: 3,
                // linesCount: 4,
              ),
              newPageProgressIndicatorBuilder: (_) => CityShimmer(
                linesCount: 3,
              ),
            ),
          ),
        ),
      ),
      // SizedBox(
      //   height: 20,
      // )
    );
  }
}
