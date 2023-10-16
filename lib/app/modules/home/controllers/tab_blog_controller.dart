import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/blog_categories.dart';
import 'package:doctor_yab/app/data/repository/BlogRepository.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../data/models/post.dart';
import '../../../utils/utils.dart';

class TabBlogController extends GetxController {
  var pagingController = PagingController<int, Post>(firstPageKey: 1);
  //*DIO
  CancelToken categoriesCancelToken = CancelToken();
  CancelToken blogCancelToken = CancelToken();
  var tabIndex = 0.obs;
  final isLoading = true.obs;
  final selectedIndex = 0.obs;
  final tabTitles = <BlogCategory>[].obs;

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

      pagingController.addPageRequestListener((pageKey) {
        loadPosts(pageKey, selectedIndex());
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
    });

    // Replace with actual API call
    // postsList.value = [
    //   Post(blogTitle: "Post 1", desc: "Content of Post 1"),
    //   Post(blogTitle: "Post 2", desc: "Content of Post 2"),
    //   Post(blogTitle: "Post 3", desc: "Content of Post 3"),
    // ];

    isLoading.value = false;
  }

  void _re() {}
}
