import 'package:doctor_yab/app/data/models/drug_stores_model.dart';
import 'package:doctor_yab/app/data/repository/DrugStoreRepository.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/controllers/tab_home_others_controller.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

class DrugStoreController extends TabHomeOthersController {
  @override
  var pageController = PagingController<int, DrugStore>(firstPageKey: 1);
  var tabIndex = 0.obs;
  @override
  void onInit() {
    pageController.addPageRequestListener((pageKey) {
      loadData(pageKey);
    });
    super.onInit();
  }

  var light1 = true.obs;
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void loadData(int page) async {
    DrugStoreRepository.fetchDrugStores(
      page,
      the24HourState,
      cancelToken: cancelToken,
      onError: (e) {
        pageController.error = e;
        // super.pageController.error = e;
        Logger().e(
          "load-drugStore",
          e,
        );
      },
    ).then((data) {
      Utils.addResponseToPagingController<DrugStore>(
        data,
        pageController,
        page,
      );
    });
  }
}
