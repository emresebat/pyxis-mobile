import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/app/models/place.dart';
import 'package:plateau/app/networking/places_api_service.dart';

import '/app/controllers/controller.dart';
import 'package:flutter/widgets.dart';

class EditNewPlaceController extends Controller {
  late LatLng currentCoords;
  late Annotation currentLocationAnnotation;
  late AppleMapController mapController;
  late Place? place;

  @override
  construct(BuildContext context) {
    super.construct(context);
  }

  Future<Place?> getPlace(String id) async {
    place = await api<PlacesApiService>((request) => request.getById(id));
    currentCoords = LatLng(place!.lat, place!.lng);
    currentLocationAnnotation = Annotation(
      annotationId: AnnotationId('current_location'),
      position: currentCoords,
      infoWindow: InfoWindow(title: place!.name),
    );
    return place;
  }
}
