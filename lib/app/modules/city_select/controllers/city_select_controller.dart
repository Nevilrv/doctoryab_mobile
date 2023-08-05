import 'package:doctor_yab/app/controllers/settings_controller.dart';
import 'package:doctor_yab/app/data/models/city_model.dart';
import 'package:doctor_yab/app/utils/utils.dart';
import 'package:get/get.dart';

class CitySelectController extends GetxController {
  var selectedCity = City().obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void cityChanged(City city) {
    selectedCity(city);
  }

  void confirmSelectedCity() {
    SettingsController.auth.savedCity = selectedCity();
    Utils.whereShouldIGo();
  }
}
