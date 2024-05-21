import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/reports.dart';
import 'package:doctor_yab/app/data/repository/ReportsRepository.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ReportsController extends GetxController {
  REPORT_TYPE? reportType;
  var pagingController = PagingController<int, Report>(firstPageKey: 1);

  CancelToken cancelToken = CancelToken();
  var tabIndex = 0.obs;

  int? index;

  @override
  void onInit() {
    tabIndex.value = 0;
    pagingController.addPageRequestListener((pageKey) {
      fetchReportsDoctor(pageKey);
    });

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void fetchReportsLab(int pageKey) {
    ReportsRepository.fetchLabReports(pageKey, cancelToken: cancelToken,
        onError: (e) {
      if (!(e is DioError && CancelToken.isCancel(e))) {
        pagingController.error = e;
      }
    }).then((value) {
      Utils.addResponseToPagingController<Report>(
        value,
        pagingController,
        pageKey,
      );
    });
  }

  void fetchReportsDoctor(int pageKey) {
    ReportsRepository.fetchDoctorReports(pageKey, cancelToken: cancelToken,
        onError: (e) {
      if (!(e is DioError && CancelToken.isCancel(e))) {
        pagingController.error = e;
      }
    }).then((value) {
      Utils.addResponseToPagingController<Report>(
        value,
        pagingController,
        pageKey,
      );
    });
  }
}
