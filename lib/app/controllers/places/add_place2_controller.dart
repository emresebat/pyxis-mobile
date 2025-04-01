import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/app/models/create_place_request.dart';
import 'package:plateau/app/models/place.dart';
import 'package:plateau/app/networking/places_api_service.dart';
import 'package:word_generator/word_generator.dart';

import '/app/controllers/controller.dart';
import 'package:flutter/widgets.dart';

class AddPlace2Controller extends Controller {
  late Position currentPosition;
  late LatLng currentCoords;
  late Annotation currentLocationAnnotation;
  bool positionReady = false;
  late AppleMapController mapController;
  late String randomName;

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
    final WordGenerator wordGenerator = WordGenerator();
    randomName = wordGenerator.randomSentence(3).trim().replaceAll(" ", "-");
    positionReady = true;
  }

  Future<Place?> createPlace() async {
    return await api<PlacesApiService>((request) => request.create(
          CreatePlaceRequest(
            randomName,
            randomName,
            randomName,
            "",
            currentPosition.latitude,
            currentPosition.longitude,
          ),
        ));
  }

  void onMapCreated(AppleMapController controller) {
    mapController = controller;
  }

  String coordsText() {
    return "${currentPosition.latitude}, ${currentPosition.longitude}";
  }
}
