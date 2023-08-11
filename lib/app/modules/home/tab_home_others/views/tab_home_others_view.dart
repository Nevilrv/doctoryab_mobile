import 'package:dio/dio.dart';
import 'package:doctor_yab/app/components/buttons/custom_animated_switch.dart';
import 'package:doctor_yab/app/components/paging_indicators/dotdot_nomore_items.dart';
import 'package:doctor_yab/app/components/paging_indicators/no_item_list.dart';
import 'package:doctor_yab/app/components/paging_indicators/paging_error_view.dart';
import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

abstract class TabHomeOthersView<ControllerType, ResponseType> extends GetView {
  @override
  get controller => GetInstance().find<ControllerType>();

  bool pageHas24Hours = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => Future.sync(
          () async {
            // Utils.resetPagingController(controller.pageController);
            // await Future.delayed(Duration.zero, () {
            //   controller.cancelToken.cancel();
            // });
            // controller.cancelToken = new CancelToken();
            // controller.loadData(
            //   controller.pageController.firstPageKey,
            // );
            controller.cancelToken.cancel();
            controller.cancelToken = new CancelToken();
            controller.pageController.refresh();
          },
        ),
        child:
        
         Column(
           children: [
          if ( pageHas24Hours)
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              children: [
                SizedBox(width: 20),
                Text(
                  "24_hours".tr,
                  style: AppTextTheme.m(12),
                ),
                SizedBox(width: 15),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: CustomAnimatedSwitch(
                    colorOff: AppColors.lgt.withOpacity(0.4),
                    onChanged: (s) => controller.on24SwitchHourStateChanged(s),
                    value: controller.the24HourState,
                  ),
                ),
              ],
            ),
          ),
             Expanded(
               child: PagedListView<int, ResponseType>.separated(
                padding: EdgeInsets.all(8),
                pagingController: controller.pageController,
                // physics: BouncingScrollPhysics(),
                separatorBuilder: (c, i) {
                  return SizedBox(height: 2);
                },
                builderDelegate: PagedChildBuilderDelegate<ResponseType>(
                  itemBuilder: (context, item, index) {
                    // var item = controller.latestVideos[index];
                    return _buildItemView(context, item, index);
                  },
                  
                  noMoreItemsIndicatorBuilder: (_) => DotDotPagingNoMoreItems(),
             
                  noItemsFoundIndicatorBuilder: (_) => PagingNoItemFountList(),
             
                  firstPageErrorIndicatorBuilder: (context) => PagingErrorView(
                    controller: controller.pageController,
                  ),
                ),
                     ),
             ),
           ],
         ),
      ),
    );
  }

  Widget buildItem(BuildContext context, ResponseType item, int index) {
    return Text("ovveride buildItem");
  }

  Widget _buildItemView(BuildContext context, ResponseType item, i) {
<<<<<<< Updated upstream
    if (i == 0 && pageHas24Hours && item != null)
=======
  
>>>>>>> Stashed changes
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
          SizedBox(height: 10),
          buildItem(context, item, i)
        ],
      );
   
  }
}
