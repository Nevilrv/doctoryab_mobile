import 'package:get/get.dart';

class LangSelectController extends GetxController {
  final RxString selectedLang = ''.obs;
  @override
  void onInit() {
    // selectedLang = LocalizationService.langs.length.obs;
    // selectedLang.value = null;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
