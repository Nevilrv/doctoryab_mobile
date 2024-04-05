import 'package:doctor_yab/app/modules/home/controllers/messages_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/background.dart';
import '../../../components/message_tile.dart';
import '../../../theme/AppColors.dart';
import '../../../utils/app_text_styles.dart';

class MessagesListView extends GetView<MessagesListController> {
  const MessagesListView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch: AppColors.primarySwatch,
        scaffoldBackgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColors.white),
        appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            titleTextStyle: AppTextStyle.boldPrimary16,
            iconTheme: IconThemeData(
              color: AppColors.white,
            ),
            actionsIconTheme: IconThemeData(
              color: AppColors.primary,
            )),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.primary,
            padding: EdgeInsets.symmetric(
              vertical: 15,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ),
      child: Background(
        isSecond: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text('messages'.tr),
              centerTitle: true,
            ),
            body: Column(children: [
              TextFormField(
                controller: controller.teSearchController,
                onChanged: (s) => controller.filterSearch(s),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 14.0),
                  filled: true,
                  suffixIcon: Icon(
                    Icons.search,
                    size: 20,
                    color: AppColors.primary,
                  ),
                  hintText: 'search...'.tr,
                  hintStyle:
                      AppTextStyle.mediumGrey12.copyWith(color: Colors.grey),
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              InkWell(
                onTap: controller.sending()
                    ? null
                    : () {
                        controller.sendMessage();
                      },
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 42.0,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'new_question'.tr,
                              style: AppTextStyle.boldWhite14,
                            ),
                          ]),
                    ),
                    Positioned(top: 10, left: 18, child: Icon(Icons.add)),
                  ],
                ),
              ),
              SizedBox(
                height: 14.0,
              ),

              Obx(() {
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => Future.sync(
                      () async {
                        controller.reloadChats();
                      },
                    ),
                    child: controller.isLoading()
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          )
                        : ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return MessageTile(
                                chat: controller.chats[index],
                                onTap: () {
                                  controller.onTapMessageTile(
                                      controller.chats[index]);
                                },
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 14.0,
                            ),
                            itemCount: controller.chats.length,
                          ),
                    // child: PagedListView.separated(
                    //   pagingController: controller.pagingController,
                    //   builderDelegate:
                    //       PagedChildBuilderDelegate<ChatListApiModel>(
                    //     itemBuilder: (context, item, index) {
                    //       // var item = controller.latestVideos[index];
                    //       return MessageTile(
                    //         chat: controller.chats[index],
                    //         onTap: () => controller.onTapMessageTile(index),
                    //       );
                    //     },
                    //     noMoreItemsIndicatorBuilder: (_) =>
                    //         DotDotPagingNoMoreItems(),
                    //     noItemsFoundIndicatorBuilder: (_) =>
                    //         PagingNoItemFountList(),
                    //     firstPageErrorIndicatorBuilder: (context) =>
                    //         PagingErrorView(
                    //       controller: controller.pagingController,
                    //     ),
                    //   ),
                    //   separatorBuilder: (context, index) => const SizedBox(
                    //     height: 14.0,
                    //   ),
                    // ),
                  ),
                );
              }),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                child: Divider(
                  height: 2,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(
                height: 80.0,
              ),

              ///height for bottomBar
              // const SizedBox(
              //   height: 102,
              // ),
            ]),
          ),
        ),
      ),
    );
  }
}
