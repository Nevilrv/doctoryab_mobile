import 'package:doctor_yab/app/data/models/HospitalsModel.dart';
import 'package:doctor_yab/app/data/repository/HospitalRepository.dart';
import 'package:doctor_yab/app/modules/home/tab_home_others/controllers/tab_home_others_controller.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

class HospitalsController extends TabHomeOthersController {
  @override
  // var pageController = PagingController<int, Hospital>(firstPageKey: 1);

  @override
  void onInit() {
    // pageController.addPageRequestListener((pageKey) {
    //   loadData(pageKey);
    // });
    super.onInit();
  }

  var light1 = true.obs;
  // setEmergencyMode(bool value) {
  //   light1 = value;
  //   update();
  // }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void loadData(int page) async {
    HospitalRepository.fetchHospitals(
      page,
      cancelToken: cancelToken,
      onError: (e) {
        pageController.error = e;
        // super.pageController.error = e;
        Logger().e(
          "load-hospitals",
          e,
        );
      },
    ).then((data) {
      Utils.addResponseToPagingController<Hospital>(
        data,
        pageController,
        page,
      );
    });
  }
}
