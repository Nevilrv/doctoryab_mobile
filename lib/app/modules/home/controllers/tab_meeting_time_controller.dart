import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/histories.dart';
import 'package:doctor_yab/app/data/repository/HistoryRepository.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

class TabMeetingTimeController extends GetxController {
  var pagingController = PagingController<int, History>(firstPageKey: 1);
  int firstFutureItemIndex;
  int firstPastItemIndex;

  //*DIO
  CancelToken cancelToken = CancelToken();

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      fetchHistory(pageKey);
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void fetchHistory(int pageKey) {
    HistoryRepository.fetchHistory(pageKey, cancelToken: cancelToken,
        onError: (e) {
      if (!(e is DioError && CancelToken.isCancel(e))) {
        pagingController.error = e;
      }
    }).then((value) {
      Utils.addResponseToPagingController<History>(
        value,
        pagingController,
        pageKey,
      );
    });
  }

  void reloadAll() {
    firstFutureItemIndex = null;
    firstPastItemIndex = null;
    pagingController.refresh();
  }
}
