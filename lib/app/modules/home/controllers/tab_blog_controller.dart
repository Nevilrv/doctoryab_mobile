import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/models/ads_model.dart';
import 'package:doctor_yab/app/data/models/blog_categories.dart';
import 'package:doctor_yab/app/data/models/post.dart' as post;
import 'package:doctor_yab/app/data/repository/AdRepository.dart';
import 'package:doctor_yab/app/data/repository/BlogRepository.dart';
import 'package:doctor_yab/app/services/DioService.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

class TabBlogController extends GetxController {
  var pagingController = PagingController<int, post.Post>(firstPageKey: 1);
  TextEditingController comment = TextEditingController();
  //*DIO
  CancelToken categoriesCancelToken = CancelToken();
  CancelToken blogCancelToken = CancelToken();
  Rx<int> selected = 0.obs;
  var tabIndex = 0.obs;
  final isLoading = true.obs;
  final selectedIndex = 0.obs;
  final tabTitles = <BlogCategory>[].obs;
  final postList = <post.Post>[];
  static Dio dio = AppDioService.getDioInstance();
  bool isLoadingComment = false;
  bool? isBottom;
  int showDesc = -1;

  @override
  void onInit() {
    super.onInit();
    log('----->>>>>>eee');
    _fetchAds();
    loadCategories();

    // scrollController.animateTo(
    //   scrollController.position.maxScrollExtent,
    //   duration: Duration(seconds: 2),
    //   curve: Curves.fastOutSlowIn,
    // );
    // loadTabTitles();
  }

  @override
  void onReady() {
    super.onReady();
    // loadCategories();
  }

  Future<void> loadCategories() async {
    BlogRepository.fetchCategories(
        cancelToken: categoriesCancelToken,
        onError: (e) {
          if (!(e is DioError && CancelToken.isCancel(e))) {
            isLoading.value = false;
          }
        }).then((value) {
      tabTitles.value = value;

      tabTitles.refresh();

      isLoading.value = false;

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        pagingController.addPageRequestListener((pageKey) {
          loadPosts(pageKey, selectedIndex.value);
        });
      });
      Utils.resetPagingController(pagingController);
      Future.delayed(Duration.zero, () {
        changeSelectedCategory(0);
      });
    }).catchError((e) {
      Future.delayed(Duration(seconds: 3), () {
        loadCategories();
      });
    });
  }

  void changeSelectedCategory(int i) async {
    Utils.resetPagingController(pagingController);
    selectedIndex.value = i;
    await Future.delayed(
      Duration.zero,
      () {
        blogCancelToken.cancel();
      },
    );
    blogCancelToken = new CancelToken();
    loadPosts(pagingController.firstPageKey, selectedIndex.value);
    pagingController.addPageRequestListener((pageKey) {
      loadPosts(pageKey, selectedIndex.value);
    });

    update();
  }

  Future<void> loadPosts(int pageKey, int index) async {
    BlogRepository.fetchPostsByCategory(pageKey, tabTitles[index],
        cancelToken: blogCancelToken, onError: (e) {
      if (!(e is DioError && CancelToken.isCancel(e))) {
        pagingController.error = e;
      }
    }).then((value) {
      Utils.addResponseToPagingController<post.Post>(
        value,
        pagingController,
        pageKey,
      );
      postList.clear();
      postList.addAll(pagingController.value.itemList ?? []);

      update();
    });
  }

  Future<void> likeBlog(String postId, int index, post.Post item) async {
    BlogRepository.blogLike(
            userId: SettingsController.userId, postId: postId.toString())
        .then((v) {
      // v.data.likes.forEach((element) {
      //   if(element.)
      // });
    }).catchError((e, s) {
      Future.delayed(Duration(seconds: 3), () {});
    });
    update();
  }

  Future<void> shareBlog(String postId, int index, post.Post item) async {
    BlogRepository.blogShare(
            userId: SettingsController.userId, postId: postId.toString())
        .then((v) {})
        .catchError((e, s) {
      Future.delayed(Duration(seconds: 3), () {});
    });
    update();
  }

  Future<void> commentBlog(String postId, String text, int index) async {
    isLoadingComment = true;
    update();
    BlogRepository.blogComment(
            userId: SettingsController.userId,
            postId: postId.toString(),
            text: text)
        .then((v) {
      isLoadingComment = false;
      update();
      comment.clear();
      postList[index].comments!.clear();

      v.data!.comments!.forEach((element) {
        postList[index].comments!.add(element);
      });
      update();

      postList[index].comments?.forEach((element) {
        // log('------elekment---${element['whoPosted']}');
      });
    }).catchError((e, s) {
      isLoadingComment = false;
      update();
      Future.delayed(Duration(seconds: 3), () {});
    });
    update();
  }

  List<Ad> adList = [];
  var adIndex = 0;
  void _fetchAds() {
    AdsRepository.fetchAds().then((v) {
      // AdsModel v = AdsModel();

      if (v.data != null) {
        v.data?.forEach((element) {
          adList.add(element);
          update();
        });
      }
    }).catchError((e, s) {
      Logger().e("message", e, s);
      Future.delayed(Duration(seconds: 3), () {
        _fetchAds();
      });
    });
  }

  showDescription(int index) {
    if (showDesc == index) {
      showDesc = -1;
      update();
    } else {
      showDesc = index;
      update();
    }
  }
}
