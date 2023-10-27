import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/ApiConsts.dart';
import 'package:doctor_yab/app/data/models/blog_categories.dart';
import 'package:doctor_yab/app/data/repository/BlogRepository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../data/models/post.dart';
import '../../../data/models/post.dart' as p;
import '../../../services/DioService.dart';
import '../../../utils/utils.dart';

class TabBlogController extends GetxController {
  var pagingController = PagingController<int, Post>(firstPageKey: 1);
  TextEditingController comment = TextEditingController();
  //*DIO
  CancelToken categoriesCancelToken = CancelToken();
  CancelToken blogCancelToken = CancelToken();
  var tabIndex = 0.obs;
  final isLoading = true.obs;
  final selectedIndex = 0.obs;
  final tabTitles = <BlogCategory>[].obs;
  final postList = <Post>[];
  static Dio dio = AppDioService.getDioInstance();
  final isLoadingComment = false.obs;
  List<p.Comment> commentList = [];

  @override
  void onInit() {
    super.onInit();

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
      tabTitles.value = value
          .where((element) => (element?.category ?? "").trim() != "")
          .toList();
      tabTitles.refresh();

      isLoading.value = false;

      //
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
    await Future.delayed(Duration.zero, () {
      blogCancelToken.cancel();
      // categoriesCancelToken.cancel();
    });
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
      log("e--------------> ${e}");

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
      log("e--------------> ${e}");

      Future.delayed(Duration(seconds: 3), () {});
    });
    update();
  }

  Future<void> commentBlog(String postId, String text) async {
    BlogRepository.blogComment(
            userId: SettingsController.userId,
            postId: postId.toString(),
            text: text)
        .then((v) {
      commentList.clear();
      // v.data.comments.forEach((element) {commentList.add(element)});

      log(" controller.comment--------------> ${v.data.comments}");
    }).catchError((e, s) {
      log("e--------------> ${e}");

      Future.delayed(Duration(seconds: 3), () {});
    });
    update();
  }
}
