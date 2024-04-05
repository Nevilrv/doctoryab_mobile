import 'dart:async';

import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  List<LatLng> latLng;
  List<String> name;
  String title;
  MapScreen({Key key, this.latLng, this.name, this.title}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  // on below line we are specifying our camera position
  CameraPosition _kGoogle;

  // on below line we have created list of markers
  List<Marker> _marker = [];
  bool isLoading = false;

  void _determinePosition() async {
    try {
      _kGoogle = CameraPosition(
        target: LatLng(widget.latLng[0].latitude, widget.latLng[0].longitude),
        zoom: 12,
      );
      setState(() {});
      widget.latLng.forEach((element) {
        _marker.add(
          Marker(
              markerId: MarkerId(widget.latLng.indexOf(element).toString()),
              position: LatLng(element.latitude, element.longitude),
              infoWindow: InfoWindow(
                title: widget.name[widget.latLng.indexOf(element)],
              )),
        );
      });
      setState(() {});
    } catch (e) {
      _kGoogle = CameraPosition(
        target: LatLng(37.42796133580664, -122.885749655962),
        zoom: 12,
      );
    } // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
  }

  @override
  void initState() {
    _determinePosition();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
          ),
          backgroundColor: AppColors.primary,
          title: Text(widget.title, style: AppTextStyle.boldWhite14),
        ),
        body: Container(
          // on below line creating google maps.
          child: GoogleMap(
            markers: Set<Marker>.of(_marker),
            // on below line setting camera position
            initialCameraPosition: _kGoogle,
            // on below line specifying map type.
            mapType: MapType.normal,
            // on below line setting user location enabled.
            myLocationEnabled: true,
            // on below line setting compass enabled.
            compassEnabled: true,
            // on below line specifying controller on map complete.
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ));
  }
}
