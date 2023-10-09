import 'package:dio/dio.dart';
import 'package:doctor_yab/app/extentions/widget_exts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../components/paging_indicators/dotdot_nomore_items.dart';
import '../../../components/paging_indicators/no_item_list.dart';
import '../../../components/paging_indicators/paging_error_view.dart';
import '../../../components/spacialAppBar.dart';
import '../../../data/models/post.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/AppColors.dart';
import '../../../theme/TextTheme.dart';
import '../../../utils/utils.dart';
import '../controllers/tab_blog_controller.dart';
import 'package:html/parser.dart' show parse;

class TabBlogView extends GetView<TabBlogController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar.specialAppBar(
        "blog".tr,
        showLeading: false,
      ),
      body: Obx(() {
        // if (controller.isLoading.value) {
        //   return const Center(child: CircularProgressIndicator());
        // } else {
        return IndexedStack(
          index: !controller.isLoading() ? 0 : 1,
          children: [
            RefreshIndicator(
              onRefresh: () => Future.sync(
                () async {
                  Utils.resetPagingController(controller.pagingController);
                  await Future.delayed(Duration.zero, () {
                    controller.blogCancelToken.cancel();
                    controller.categoriesCancelToken.cancel();
                  });
                  controller.blogCancelToken = new CancelToken();
                  controller.categoriesCancelToken = new CancelToken();
                  controller.selectedIndex.value = 0;
                  controller.isLoading(true);

                  controller.loadCategories(
                      // controller.pagingController.firstPageKey,
                      );
                },
              ),
              child: _body(controller: controller),
            ),
            Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            ).bgColor(Colors.white),
          ],
        );
      }
          // },
          ),
    );
  }
}

class _body extends StatelessWidget {
  const _body({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final TabBlogController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 65,
          child: Obx(() => ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(8),
                scrollDirection: Axis.horizontal,
                itemCount: controller.tabTitles.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => controller.changeSelectedCategory(index),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: controller.selectedIndex.value == index
                            ? AppColors.primary
                            : AppColors.primary.withOpacity(0.06),
                        // border: Border.all(
                        //   color: AppColors.primary,
                        //   width: 1,
                        // ),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.center,
                        child: Text(
                          controller.tabTitles[index].category,
                          style: AppTextTheme.m(16).copyWith(
                            color: controller.selectedIndex.value == index
                                ? Colors.white
                                : AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ).paddingHorizontal(4);
                },
              )),
        ),
        // const Divider(height: 1, thickness: 1),
        Expanded(
          // Wrap Column with Expanded
          child: PagedListView.separated(
            physics: BouncingScrollPhysics(),
            separatorBuilder: (c, i) {
              return SizedBox(height: 15);
            },
            // padding: EdgeInsets.symmetric(vertical: 30, horizontal: 22),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            pagingController: controller.pagingController,

            builderDelegate: PagedChildBuilderDelegate<Post>(
              itemBuilder: (context, item, index) {
                // var item = controller.latestVideos[index];
                return _buildItemView(context, item);
              },
              noMoreItemsIndicatorBuilder: (_) => DotDotPagingNoMoreItems(),
              noItemsFoundIndicatorBuilder: (_) => PagingNoItemFountList(),
              firstPageErrorIndicatorBuilder: (context) => PagingErrorView(
                controller: controller.pagingController,
              ),
            ),
            // itemBuilder: (context, index) {
            //   return ListTile(
            //     title: Text(controller.postsList[index].blogTitle),
            //     subtitle: Text(controller.postsList[index].desc),
            //   );
            // },
          ),
        ),
        const SizedBox(
          height: 80.0,
        ),
      ],
    );
  }

  Widget _buildItemView(BuildContext context, Post item) {
    return PostItemView(item);
  }
}

class PostItemView extends StatefulWidget {
  PostItemView(this.item, {Key key}) : super(key: key);
  final Post item;

  @override
  State<PostItemView> createState() => _PostItemViewState();
}

class _PostItemViewState extends State<PostItemView> {
  bool _isExpanded = false;
  var short = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(widget.item?.blogTitle ?? ""),
        // SizedBox(height: 20),
        Wrap(
          // direction: Axis.vertical,
          children: [
            Container(
                // height: containerHeight > 200 ? 300 : null,
                child: () {
              String html = widget.item?.desc ?? "";
              var document = parse(html);
              String text =
                  parse(document.body?.text ?? "").documentElement?.text ?? "";
              // print(text);

              //if (text.length > 100) {
              // return Text(text.substring(0, 100));
              //}

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                // margin: EdgeInsets.all(0.0),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item?.blogTitle ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 20),
                      Text(
                          "${text.length > 100 ? (text.substring(0, 100) + ' ...') : text}"),
                      SizedBox(height: 20),
                      //TODO share and like function
                      if (1 == 3)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              icon: Icon(Icons.thumb_up),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(Icons.chat_bubble_outline),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(Icons.share),
                              onPressed: () {},
                            ),
                          ],
                        ),

                      Row(),
                    ],
                  ),
                ),
              ).onTap(() {
                Get.toNamed(Routes.BLOG_FULL_PAGE, arguments: widget.item);
              });

              // return Html(
              //   // customRender: (node, children) {
              //   //   return node.Container();
              //   // },

              //   data: widget.item?.desc ?? "",
              //   //TODO fix this for english posts
              //   customTextAlign: (elem) => TextAlign.right,
              // );
            }()),
          ],
        ),
      ],
    );

    // return ListTile(
    //   title: Text(widget.item?.blogTitle ?? ""),
    //   subtitle: Stack(
    //     children: [
    //       if (_isExpanded)
    //         Html(
    //           data: widget.item.desc,
    //           customTextAlign: (elem) => TextAlign.right,
    //         ),
    //       if (!_isExpanded)
    //         Positioned(
    //           bottom: 0,
    //           right: 0,
    //           child: Container(
    //             color: Colors.white.withOpacity(0.8),
    //             child: TextButton(
    //               onPressed: () {
    //                 setState(() {
    //                   _isExpanded = true;
    //                 });
    //               },
    //               child: Text(
    //                 'See More',
    //                 style: TextStyle(color: Colors.blue),
    //               ),
    //             ),
    //           ),
    //         ),
    //       if (_isExpanded)
    //         Positioned(
    //           bottom: 0,
    //           right: 0,
    //           child: Container(
    //             color: Colors.white.withOpacity(0.8),
    //             child: TextButton(
    //               onPressed: () {
    //                 setState(() {
    //                   _isExpanded = false;
    //                 });
    //               },
    //               child: Text(
    //                 'See Less',
    //                 style: TextStyle(color: Colors.blue),
    //               ),
    //             ),
    //           ),
    //         ),
    //     ],
    //   ),
    // );
  }
}
