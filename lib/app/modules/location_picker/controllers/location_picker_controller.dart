import 'package:get/get.dart';
import 'package:place_picker/place_picker.dart';

class LocationPickerController extends GetxController {
  final kInitialPosition = LatLng(34.349241179856044, 62.21916250738316);
  var selectedPlace = LocationResult().obs;

  @override
  void onInit() {}

  @override
  void onReady() {}

  @override
  void onClose() {}

  changePickedPlace(LocationResult result) {
    selectedPlace(result);
    // Get.back();
  }
}
