import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/ads_model.dart';
import 'package:doctor_yab/app/data/models/blog_categories.dart';
import 'package:doctor_yab/app/data/repository/AdRepository.dart';
import 'package:doctor_yab/app/data/repository/BlogRepository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

import '../../../data/models/post.dart';
import '../../../data/models/post.dart';
import '../../../services/DioService.dart';
import '../../../utils/utils.dart';

class TabBlogController extends GetxController {
  var pagingController = PagingController<int, Post>(firstPageKey: 1);
  TextEditingController comment = TextEditingController();
  //*DIO
  CancelToken categoriesCancelToken = CancelToken();
  CancelToken blogCancelToken = CancelToken();
  Rx<int> selected = 0.obs;
  var tabIndex = 0.obs;
  final isLoading = true.obs;
  final selectedIndex = 0.obs;
  final tabTitles = <BlogCategory>[].obs;
  final postList = <Post>[];
  static Dio dio = AppDioService.getDioInstance();
  bool isLoadingComment = false;
  bool isBottom;
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
    loadCategories();
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

      // tabTitles.value = value.where((element) {
      //   log('-----dede--$element');
      //   return (element?.category ?? "").trim() != "";
      // }).toList();
      tabTitles.refresh();

      isLoading.value = false;

      //

      log('---->>>tabTitles>>>>>$tabTitles');
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        pagingController.addPageRequestListener((pageKey) {
          loadPosts(pageKey, selectedIndex());
        });
      });

      Utils.resetPagingController(pagingController);
      // pagingController.refresh();
      // loadPosts(pagingController.firstPageKey, selectedIndex());
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
        // categoriesCancelToken.cancel();
      },
    );
    blogCancelToken = new CancelToken();
    // categoriesCancelToken = new CancelToken();
    loadPosts(pagingController.firstPageKey, selectedIndex());

    print(i);
  }

  Future<void> loadPosts(int pageKey, int index) async {
    // await Future.delayed(const Duration(seconds: 2));
    isLoading.value = true;
    BlogRepository.fetchPostsByCategory(pageKey, tabTitles()[index],
        cancelToken: blogCancelToken, onError: (e) {
      if (!(e is DioError && CancelToken.isCancel(e))) {
        pagingController.error = e;
      }
    }).then((value) {
      Utils.addResponseToPagingController<Post>(
        value,
        pagingController,
        pageKey,
      );

      postList.clear();
      postList.addAll(pagingController.value.itemList);
      update();
    });

    // Replace with actual API call
    // postsList.value = [
    //   Post(blogTitle: "Post 1", desc: "Content of Post 1"),
    //   Post(blogTitle: "Post 2", desc: "Content of Post 2"),
    //   Post(blogTitle: "Post 3", desc: "Content of Post 3"),
    // ];

    isLoading.value = false;
  }

  Future<void> likeBlog(String postId, int index, Post item) async {
    BlogRepository.blogLike(
            userId: SettingsController.userId, postId: postId.toString())
        .then((v) {
      // v.data.likes.forEach((element) {
      //   if(element.)
      // });
      log("v--------------> ${v.data}");
    }).catchError((e, s) {
      log("e--------------> $e");

      Future.delayed(Duration(seconds: 3), () {});
    });
    update();
  }

  Future<void> shareBlog(String postId, int index, Post item) async {
    BlogRepository.blogShare(
            userId: SettingsController.userId, postId: postId.toString())
        .then((v) {
      log("v--------------> ${v.data}");
    }).catchError((e, s) {
      log("e--------------> $e");

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
      postList[index].comments.clear();

      v.data.comments.forEach((element) {
        postList[index].comments.add(element);
      });
      update();
      log(" controller.comment--------------> ${v.data.comments}");
    }).catchError((e, s) {
      log("e--------------> $e");
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
      log("v.data--------------> ${v.data}");

      if (v.data != null) {
        v.data.forEach((element) {
          adList.add(element);
          update();
          log("adList--------------> ${adList.length}");
        });
      }
    }).catchError((e, s) {
      log("e--------------> $e");

      Logger().e("message", e, s);
      Future.delayed(Duration(seconds: 3), () {
        if (this != null) _fetchAds();
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
