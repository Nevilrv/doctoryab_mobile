import 'package:doctor_yab/app/data/models/labs_model.dart';
import 'package:doctor_yab/app/data/repository/LabsRepository.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/controllers/tab_home_others_controller.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

class LabsController extends TabHomeOthersController {
  @override
  var pageController = PagingController<int, Labs>(firstPageKey: 1);

  @override
  void onInit() {
    pageController.addPageRequestListener((pageKey) {
      loadData(pageKey);
    });
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

  void loadData(int page) async {
    LabsRepository.fetchLabs(
      page,
      cancelToken: cancelToken,
      onError: (e) {
        pageController.error = e;
        // super.pageController.error = e;
        Logger().e(
          "load-Labs",
          e,
        );
      },
    ).then((data) {
      Utils.addResponseToPagingController<Labs>(
        data,
        pageController,
        page,
      );
    });
  }
}
