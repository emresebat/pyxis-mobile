import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/app/controllers/controller.dart';
import 'package:plateau/app/models/create_place_request.dart';
import 'package:plateau/app/models/place.dart';
import 'package:flutter/widgets.dart';
import 'package:plateau/app/networking/supabase_edge_api.dart';

class NewPlaceController extends Controller {
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

  Future<Place?> createPlace() async {
    return await api<SupabaseEdgeApiService>((request) => request.createPlace(
          CreatePlaceRequest(
            null,
            null,
            null,
            null,
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
