import 'package:dio/dio.dart';
import 'package:doctor_yab/app/data/models/doctor_full_model.dart';
import 'package:doctor_yab/app/data/models/doctors_model.dart';
import 'package:doctor_yab/app/data/repository/DoctorsRepository.dart';
import 'package:get/get.dart';

class DoctorController extends GetxController {
  final args = Get.arguments;
  // var doctorsLoded = false.obs;
  Rxn<DoctorFullModel> doctorFullData = Rxn();
  Doctor doctor;
  var cancelToken = CancelToken();
  var tabIndex = 0.obs;
  @override
  void onInit() {
    if (!(args is List && args.length > 0 && args[0] is Doctor)) {
      Get.back();
    } else {
      doctor = args[0];
    }
    // _fetchDoctorFullData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    cancelToken.cancel();
  }

  void _fetchDoctorFullData() async {
    try {
      var _response = await DoctorsRepository().fetchDoctorFullData(doctor.id);
      var _data = _response.data;
      doctorFullData.value = DoctorFullModel.fromJson(_data);
      doctorFullData.refresh();
    } on DioError catch (e) {
      await Future.delayed(Duration(seconds: 2), () {});
      if (!cancelToken.isCancelled) _fetchDoctorFullData();
      // throw e;
      print(e);
    }
  }
}
