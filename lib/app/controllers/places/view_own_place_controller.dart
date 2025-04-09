import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:plateau/app/controllers/controller.dart';
import 'package:plateau/app/models/place.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ViewOwnPlaceController extends Controller {
  late LatLng currentCoords;
  late Annotation currentLocationAnnotation;
  late AppleMapController mapController;
  late Place? place;

  @override
  construct(BuildContext context) {
    super.construct(context);
  }

  Future<Place?> getPlace(String id) async {
    final supabase = Supabase.instance.client;
    place = await supabase
        .from('places')
        .select()
        .eq('id', id)
        .order('created_at', ascending: false)
        .single()
        .then((json) => Place.fromJson(json));
    currentCoords = LatLng(place!.lat, place!.lng);
    currentLocationAnnotation = Annotation(
      annotationId: AnnotationId('current_location'),
      position: currentCoords,
      infoWindow: InfoWindow(title: place!.name),
    );
    return place;
  }

  void onMapCreated(AppleMapController controller) {
    mapController = controller;
  }
}
