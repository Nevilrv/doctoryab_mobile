import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  static GetStorage getStorage = GetStorage();

  static Future setVerifyImage(String value) async {
    await getStorage.write('saveDrug', value);
  }

  static getVerifyImage() {
    return getStorage.read('saveDrug');
  }

  static Future getClear() {
    return getStorage.erase();
  }
}
