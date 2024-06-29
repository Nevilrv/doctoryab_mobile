import 'package:meta/meta.dart';
import 'package:get/get.dart';

import '../data/static.dart';

class PhoneValidatorUtils {
  String number;
  // bool _isValid = false;
  String errorMessage = "";
  PhoneValidatorUtils({
    required this.number,
  });
  bool isValid() {
    String pattern = AppStatics.envVars.phoneNumberPattern;
    //https://regex101.com/r/mhXP2g/2
    RegExp regex = RegExp(pattern);

    if (number.length < 10) {
      errorMessage = "min_10_digits_required".tr;
    } else if (number.length > 10) {
      errorMessage = "max_10_digits_allowed".tr;
    } else if (!regex.hasMatch(number)) {
      errorMessage = "not_a_valid_afghanistan_number".tr;
    } else {
      errorMessage = "";
      return true;
    }
    return false;
  }
}
