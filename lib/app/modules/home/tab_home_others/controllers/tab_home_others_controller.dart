import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

abstract class TabHomeOthersController extends GetxController {
  PagingController? pageController;
  CancelToken cancelToken = CancelToken();
  bool the24HourState = false;

  void on24SwitchHourStateChanged(bool state) {
    if (state != the24HourState) {
      // Future.delayed(Duration(milliseconds: 250), () {
      cancelToken.cancel();
      cancelToken = CancelToken();
      the24HourState = state;
      pageController?.refresh();
      // });
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
