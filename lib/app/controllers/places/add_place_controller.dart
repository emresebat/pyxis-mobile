import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '/app/controllers/controller.dart';
import 'package:flutter/widgets.dart';

class AddPlaceController extends Controller {
  late Position currentPosition;
  late LatLng currentCoords;
  late Annotation currentLocationAnnotation;
  bool positionReady = false;
  late AppleMapController mapController;

  @override
  construct(BuildContext context) {
    super.construct(context);
  }

  Future getPosition() async {
    currentPosition = await Geolocator.getCurrentPosition();
    currentCoords = LatLng(currentPosition.latitude, currentPosition.longitude);
    currentLocationAnnotation = Annotation(
      annotationId: AnnotationId('current_location'),
      position: currentCoords,
      infoWindow: const InfoWindow(title: 'You are here'),
    );
    positionReady = true;
  }

  void onMapCreated(AppleMapController controller) {
    mapController = controller;
  }

  String coordsText() {
    return "${currentPosition.latitude}, ${currentPosition.longitude}";
  }
}
