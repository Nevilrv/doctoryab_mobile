import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:place_picker/entities/localization_item.dart';
import 'package:place_picker/place_picker.dart';

import '../../../data/ApiConsts.dart';
import '../controllers/location_picker_controller.dart';

class LocationPickerView extends GetView<LocationPickerController> {
  const LocationPickerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('select_from_map'.tr),
        // centerTitle: true,
        elevation: 0,
        leading:
            IconButton(onPressed: () => Get.back(), icon: Icon(Icons.clear)),
      ),
      body: Container(
        child: PlacePicker(
          ApiConsts.mapsApiKey,

          displayLocation: (Get.arguments != null &&
                  Get.arguments is LocationResult &&
                  Get.arguments?.latLng != null)
              ? Get.arguments.latLng
              : LatLng(34.5418664, 69.1644598),
          localizationItem: LocalizationItem(
            languageCode: "en_US",
            // languageCode: LocalizationService.,
            nearBy: "nearby_places".tr,
            findingPlace: "finding_places".tr,
            noResultsFound: "no_result_found".tr,
            unnamedLocation: "unnamed_location".tr,
            tapToSelectLocation: "tap_to_select_this_location".tr,
          ),
          searchBarOptions: SearchBarOptions(
            padding: EdgeInsets.zero,
            backgroundColor: Colors.white,
            elevation: 2,
            overlyTopPadding:
                MediaQuery.of(context).padding.top + kToolbarHeight,
            searchIcon: Icon(
              Icons.search,
              color: Get.theme.colorScheme.secondary,
            ),
            clearTextIcon: Icon(
              Icons.close,
              color: Get.theme.colorScheme.secondary,
            ),
            inputDecoration: InputDecoration(
              hintText: "search_place".tr,
              border: InputBorder.none,
              hintStyle: TextStyle(),
            ),
            // height: 50,
            searchIconPadding:
                EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            clearTextIconPadding:
                EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
                // color: Colors.white,
                ),
          ),
          // searchAutoCompletLoadingBuilder: () => Material(
          //   child: SizedBox(
          //     height: 50,
          //     width: 50,
          //     child: Center(child: CircularProgressIndicator()),
          //   ),
          // ),
          // bottomResultWidgetBuilder: (_, __, ___, h, _____) => SizedBox(
          //   height: h / 4,
          // ),
          // searchAutoCompleteItemBuilder: (a, b) => GestureDetector(
          //   onTap: b,
          //   child: Text(
          //     a.text,
          //   ),
          // ),
          // searchAutoCompleteBuilder: (list) => Material(
          //   elevation: 1,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: list,
          //   ),
          // ),

          mapOptions: MapOptions(
            myLocationButtonEnabled: true,
          ),
        ),
      ),
    );
  }
}
